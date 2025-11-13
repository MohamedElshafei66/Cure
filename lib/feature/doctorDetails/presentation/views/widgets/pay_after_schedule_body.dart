import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/core/constants/dependincy_injection.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/booking_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/add_new_card.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/day_and_time_schedule.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/select_payment_method.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/success_appointment.dart' show successAppointment;
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

class PayAfterScheduleBody extends StatefulWidget {
  const PayAfterScheduleBody({super.key});

  @override
  State<PayAfterScheduleBody> createState() => _PayAfterScheduleBodyState();
}

class _PayAfterScheduleBodyState extends State<PayAfterScheduleBody> {
  @override
  void initState() {
    super.initState();
    // Fetch doctor details if not available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final appointmentState = context.read<AppointmentCubit>().state;
        if (appointmentState.doctorDetails == null) {
          print('No doctor details found, fetching doctor details...');
          // Use doctor ID 2 as default for testing
          context.read<DoctorDetailsCubit>().fetchDoctorDetails(2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DoctorDetailsCubit, DoctorDetailsState>(
          listener: (context, state) {
            if (state is DoctorDetailsLoaded) {
              print('Doctor details loaded, setting to AppointmentCubit');
              context.read<AppointmentCubit>().setDoctorDetails(state.doctorDetails);
            }
          },
        ),
        BlocListener<BookingCubit, BookingState>(
          listener: (context, state) {
            if (state is BookingSuccess) {
              // If payment method is Stripe (Credit Card), open payment URL
              if (state.booking.paymentUrl != null && state.booking.paymentUrl!.isNotEmpty) {
                _launchPaymentUrl(context, state.booking.paymentUrl!);
              } else {
                // Show success dialog if no payment URL
                successAppointment(context);
              }
            } else if (state is BookingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, bookingState) {
          return BlocBuilder<AppointmentCubit, AppointmentState>(
            builder: (context, appointmentState) {
              // Show loading if no doctor details
              if (appointmentState.doctorDetails == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DoctorInfo(doctorDetails: appointmentState.doctorDetails!),
                            const SizedBox(height: 32),
                            const DayAndTimeSchedule(),
                            const SizedBox(height: 50),
                            Text(
                              AppStrings.paymentMethod,
                              style: AppStyle.styleRegular20(context),
                            ),
                            const SizedBox(height: 16),
                            const SelectPaymentMethod(),
                            const SizedBox(height: 8),
                            const AddNewCard(),
                            const Spacer(),
                            Column(
                              children: [
                                PriceOfDoctor(doctorDetails: appointmentState.doctorDetails),
                                const SizedBox(height: 12),
                                if (bookingState is BookingLoading)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                else
                                  CustomButton(
                                    text: AppStrings.pay,
                                    onPressed: () {
                                      _handlePayButton(context, appointmentState);
                                    },
                                  ),
                              ],
                            ),
                            const SizedBox(height: 29),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _handlePayButton(BuildContext context, AppointmentState appointmentState) {
    print('========================================');
    print('PAY BUTTON PRESSED - Starting Booking Process');
    print('========================================');
    
    // Validate required fields
    if (appointmentState.doctorDetails == null) {
      print('ERROR: Doctor details not available');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor details not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (appointmentState.selectedDate == null || appointmentState.selectedTime == null) {
      print('ERROR: Date or time not selected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date and time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (appointmentState.paymentMethod == null) {
      print('ERROR: Payment method not selected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get slot ID
    final appointmentCubit = context.read<AppointmentCubit>();
    final slotId = appointmentCubit.getSelectedSlotId();
    
    if (slotId == null) {
      print('ERROR: Could not find selected slot');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not find selected slot'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Map payment method to payment code
    // 1 = Credit Card (Stripe), 2 = PayPal, 3 = Apple Pay
    int paymentCode = 1; // Default to Credit Card
    if (appointmentState.paymentMethod == AppStrings.paypal) {
      paymentCode = 2;
    } else if (appointmentState.paymentMethod == AppStrings.applePay) {
      paymentCode = 3;
    }

    // Create booking based on payment method
    final bookingCubit = context.read<BookingCubit>();
    
    // Different request bodies based on payment method
    if (paymentCode == 1) {
      // Visa (Credit Card) - Payment: 1
      print('========================================');
      print('PAYMENT METHOD: VISA (Credit Card)');
      print('Using test data for Visa payment');
      print('========================================');
      bookingCubit.createBooking(
        doctorId: 2,
        slotId: 23,
        amount: 100.00,
        payment: 1,
        status: 0,
        appointmentAt: DateTime.parse('2025-11-15T18:00:00'),
      );
    } else if (paymentCode == 2) {
      // PayPal - Payment: 2
      print('========================================');
      print('PAYMENT METHOD: PAYPAL');
      print('Using test data for PayPal payment');
      print('========================================');
      bookingCubit.createBooking(
        doctorId: 2,
        slotId: 24,
        amount: 100.00,
        payment: 2,
        status: 0,
        appointmentAt: DateTime.parse('2025-11-11T18:00:00'),
      );
    } else {
      // Apple Pay or other - use original logic
      final selectedDate = appointmentState.selectedDate!;
      final selectedTime = appointmentState.selectedTime!;
      final appointmentDateTime = _createAppointmentDateTime(selectedDate, selectedTime);
      
      print('========================================');
      print('PAYMENT METHOD: OTHER (Apple Pay)');
      print('Using selected date/time');
      print('========================================');
      bookingCubit.createBooking(
        doctorId: appointmentState.doctorDetails!.doctorId,
        slotId: slotId,
        amount: appointmentState.doctorDetails!.doctorPrice.toDouble(),
        payment: paymentCode,
        status: 0,
        appointmentAt: appointmentDateTime,
      );
    }
    
    print('Booking cubit called, waiting for response...');
    print('========================================');
  }

  DateTime _createAppointmentDateTime(DateTime date, String time12Hour) {
    try {
      final parts = time12Hour.split(' ');
      if (parts.length == 2) {
        final timePart = parts[0];
        final period = parts[1].toUpperCase();
        final timeComponents = timePart.split(':');
        
        if (timeComponents.length == 2) {
          var hour = int.parse(timeComponents[0]);
          final minute = int.parse(timeComponents[1]);
          
          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }
          
          return DateTime(date.year, date.month, date.day, hour, minute);
        }
      }
    } catch (e) {
      print('Error creating appointment DateTime: $e');
    }
    return date;
  }

  Future<void> _launchPaymentUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        
        // Show success dialog after payment (you might want to add a callback here)
        // For now, we'll show it immediately. In production, you'd wait for Stripe callback
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            successAppointment(context);
          }
        });
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not launch payment URL'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Error launching payment URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
