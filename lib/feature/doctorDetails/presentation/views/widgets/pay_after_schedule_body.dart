import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
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
                final appointmentState = context.read<AppointmentCubit>().state;
                successAppointment(
                  context,
                  doctorName: appointmentState.doctorDetails?.doctorName,
                  selectedDate: appointmentState.selectedDate,
                  selectedTime: appointmentState.selectedTime,
                );
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
    // 1 = Credit Card (Stripe), 2 = Cash, 3 = Apple Pay
    int paymentCode = 1; // Default to Credit Card
    if (appointmentState.paymentMethod == AppStrings.cach) {
      paymentCode = 2;
    } else if (appointmentState.paymentMethod == AppStrings.applePay) {
      paymentCode = 3;
    }

    // Create booking based on payment method
    final bookingCubit = context.read<BookingCubit>();
    
    // Create appointment date time from selected date and time
    final selectedDate = appointmentState.selectedDate!;
    final selectedTime = appointmentState.selectedTime!;
    final appointmentDateTime = _createAppointmentDateTime(selectedDate, selectedTime);
    
    // Different request bodies based on payment method
    if (paymentCode == 1) {
      bookingCubit.createBooking(
        doctorId:appointmentState.doctorDetails!.doctorId,
        slotId:slotId,
        amount:appointmentState.doctorDetails!.doctorPrice.toDouble(),
        payment:1,
        status: 0,
        appointmentAt:appointmentDateTime,
      );
    } else if (paymentCode == 2) {
      // PayPal - Payment: 2
      bookingCubit.createBooking(
        doctorId:appointmentState.doctorDetails!.doctorId,
        slotId:slotId,
        amount:appointmentState.doctorDetails!.doctorPrice.toDouble(),
        payment:2,
        status: 0,
        appointmentAt:appointmentDateTime,
      );
    } else {
      // Apple Pay or other - use original logic
            bookingCubit.createBooking(
        doctorId: appointmentState.doctorDetails!.doctorId,
        slotId: slotId,
        amount: appointmentState.doctorDetails!.doctorPrice.toDouble(),
        payment: paymentCode,
        status: 0,
        appointmentAt: appointmentDateTime,
      );
      
      print('========================================');
      print('PAYMENT METHOD: OTHER (Apple Pay)');
      print('Using selected date/time');
      print('========================================');
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
      print('Opening payment URL in WebView: $url');
      
      // Get appointment data before navigation
      final appointmentState = context.read<AppointmentCubit>().state;
      final doctorName = appointmentState.doctorDetails?.doctorName;
      final selectedDate = appointmentState.selectedDate;
      final selectedTime = appointmentState.selectedTime;
      
      // Navigate to WebView screen with payment URL and appointment data
      if (context.mounted) {
        context.push(
          '${AppRoutes.paymentWebView}?url=${Uri.encodeComponent(url)}'
          '${doctorName != null ? '&doctorName=${Uri.encodeComponent(doctorName)}' : ''}'
          '${selectedDate != null ? '&date=${selectedDate.toIso8601String()}' : ''}'
          '${selectedTime != null ? '&time=${Uri.encodeComponent(selectedTime)}' : ''}',
        ).then((result) {
          // If payment was completed, show success dialog
          if (result == true && context.mounted) {
            successAppointment(
              context,
              doctorName: doctorName,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
            );
          }
        });
      }
    } catch (e) {
      print('Error opening payment URL: $e');
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
