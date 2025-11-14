
import 'package:stomp_dart_client/stomp_dart_client.dart';

class StompService {
  late StompClient _client;

  void connect(String token, Function(dynamic message) onNewMessage) {
    _client = StompClient(
      config: StompConfig(
        url: 'wss://cure-doctor-booking.runasp.net/notificationsHub',
        onConnect: (StompFrame frame) {
          print('STOMP Connected');
          _client.subscribe(
            destination: '/user/queue/notifications',
            callback: (frame) {
              if (frame.body != null) {
                onNewMessage(frame.body);
              }
            },
          );
        },
        beforeConnect: () async {
          print('Connecting STOMP...');
          await Future.delayed(Duration(milliseconds: 200));
        },
        onWebSocketError: (dynamic error) => print('STOMP Error: $error'),
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
      ),
    );

    _client.activate();
  }

  void disconnect() {
    _client.deactivate();
  }
}