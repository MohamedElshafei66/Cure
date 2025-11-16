import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final VoidCallback? onPaymentSuccess;
  final String? doctorName;
  final DateTime? selectedDate;
  final String? selectedTime;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    this.onPaymentSuccess,
    this.doctorName,
    this.selectedDate,
    this.selectedTime,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    if (widget.paymentUrl.isNotEmpty) {
      _initializeWebView();
    }
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
            });
            print('Page started loading: $url');
            
            // Check URL for success indicators immediately
            _checkPaymentSuccess(url);
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });
            print('Page finished loading: $url');
            
            // Check URL for success indicators
            _checkPaymentSuccess(url);
            
            // Also check page content using JavaScript
            try {
              final result = await _controller?.runJavaScriptReturningResult(
                '''
                (function() {
                  var bodyText = document.body ? document.body.innerText.toLowerCase() : '';
                  var title = document.title ? document.title.toLowerCase() : '';
                  var url = window.location.href.toLowerCase();
                  
                  // Check for success indicators
                  if (bodyText.includes('success') || 
                      bodyText.includes('payment successful') ||
                      bodyText.includes('thank you') ||
                      bodyText.includes('completed') ||
                      title.includes('success') ||
                      url.includes('success') ||
                      url.includes('return_url') ||
                      url.includes('payment_success') ||
                      url.includes('checkout/success')) {
                    return 'success';
                  }
                  return 'pending';
                })();
                '''
              );
              
              print('JavaScript result: $result');
              if (result != null && result.toString().contains('success')) {
                _handlePaymentSuccess();
              }
            } catch (e) {
              print('Error running JavaScript: $e');
            }
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
            setState(() {
              _isLoading = false;
            });
          },
          onUrlChange: (UrlChange change) {
            print('URL changed to: ${change.url}');
            if (change.url != null) {
              _checkPaymentSuccess(change.url!);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _checkPaymentSuccess(String url) {
    final urlLower = url.toLowerCase();

    final successIndicators = [
      'success',
      'payment_success',
      'payment-success',
      'checkout/success',
      'return_url',
      'return-url',
      'completed',
      'paid',
      'thank-you',
      'thank_you',
      'confirmation',
    ];
    
    for (var indicator in successIndicators) {
      if (urlLower.contains(indicator)) {
        print('Payment success detected from URL: $url');
        _handlePaymentSuccess();
        return;
      }
    }
  }

  bool _hasShownSuccess = false;

  void _handlePaymentSuccess() {
    // Prevent showing success dialog multiple times
    if (_hasShownSuccess) {
      return;
    }
    
    _hasShownSuccess = true;
    print('Handling payment success...');
    
    // Close WebView and show success dialog
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Return true to indicate payment was successful
        Navigator.of(context).pop(true);
        
        if (widget.onPaymentSuccess != null) {
          widget.onPaymentSuccess!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.paymentUrl.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const Center(
          child: Text('Payment URL is not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _controller != null
          ? Stack(
              children: [
                WebViewWidget(controller: _controller!),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

