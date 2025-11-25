import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';

// Doctor details imports
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/booking_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/doctor_details_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/booking_repo_impl.dart'
    as DoctorDetailsBookingRepoImpl;
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/create_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/booking_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';

// Feature imports
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/view/sign_in_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/app_startup_logic.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/otp_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/presentation/view/sign_up_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/booking_view.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/reschedule_view.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/view/chat_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/view/chats_list_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/models/chat_model.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/repositories/ChatRepositoryImp.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/models/doctor_details_args.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/add_review_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/confirm_appointment_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/doctor_details_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/pay_after_schedule.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/payment_webview_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/all_doctors.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/favourites.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/home.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/map.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/view/notification_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/ProfileRemoteDataSource.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/add_card_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/faqs_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_second_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_third_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/visa_payment_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/mastercard_payment_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/apple_pay_payment_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/paypal_payment_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/privacy_policy_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_edit_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/setting_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/search_screen.dart';
import 'package:round_7_mobile_cure_team3/main_layout.dart';

import '../../feature/profile/logic/Cubit/profile_cubit.dart';

abstract class AppRoutes {
  static String doctorDetailsScreen = "/doctorDetailsScreen";
  static String confirmAppointmentScreen = "/confirmAppointment";
  static String payAfterScheduleScreen = "/payAfterScheduleScreen";
  static String addReviewScreen = "/addReviewScreen";
  static String bookingScreen = "/bookingScreen";
  static String rescheduleScreen = "/rescheduleScreen";
  static String onBoarding_screen = '/onboarding';
  static String sign_in_screen = '/sign_in';
  static String sign_up_screen = '/sign_up';
  static String otp_screen = '/otp';
  static String notification_screen = '/notification';
  static String faqsSreen = "/faqsSreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String profileScreen = "/profileScreen";
  static String settingScreen = "/settingScreen";
  static String paymentMethodScreen = "/paymentMethodScreen";
  static String paymentMethodSecondScreen = "/paymentMethodSecondScreen";
  static String paymentMethodThirdScreen = "/paymentMethodThirdScreen";
  static String visaPaymentScreen = "/visaPaymentScreen";
  static String masterCardPaymentScreen = "/masterCardPaymentScreen";
  static String applePayPaymentScreen = "/applePayPaymentScreen";
  static String payPalPaymentScreen = "/payPalPaymentScreen";
  static String chatsListScreen = "/chats_list_screen";
  static String chatScreen = "/chatScreen";
  static String allDoctorsScreen = '/doctors';
  static String search = '/search';
  static String favourites = '/favourites';
  static String map = '/map';
  static String home = '/home';
  static String mainLayout = '/main_layout';
  static String profileEdit = '/profile_edit';
  static String addCard = '/addCard';
  static String paymentWebView = '/paymentWebView';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: profileEdit,
        builder: (context, state) {
          final profile = state.extra as ProfileModel;
          return BlocProvider(
            create: (_) => ProfileCubit(
              ProfileRepository(
                ProfileRemoteDataSource(
                  ApiServices(authProvider: context.read<AuthProvider>()),
                ),
              ),
            ),
            child: ProfileEditScreen(profile: profile),
          );
        },
      ),
      GoRoute(path: mainLayout, builder: (context, state) => MainLayout()),
      GoRoute(path: home, builder: (context, state) => Home()),
      GoRoute(
        path: search,
        builder: (context, state) {
          final specialtyId = state.extra as int?;
          return SearchScreen(preselectedSpecialtyId: specialtyId);
        },
      ),
      GoRoute(path: favourites, builder: (context, state) => Favourites()),
      GoRoute(path: map, builder: (context, state) => MapScreen()),
      GoRoute(path: '/', builder: (context, state) => AppStartupLogic()),
      GoRoute(
        path: allDoctorsScreen,
        builder: (context, state) => AllDoctorsScreen(),
      ),
      GoRoute(
        path: onBoarding_screen,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: sign_in_screen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: sign_up_screen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: otp_screen,
        builder: (context, state) {
          final phoneNumber = state.extra as String;
          return OTPVerificationScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: notification_screen,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: paymentMethodThirdScreen,
        builder: (context, state) => PaymentMethodThirdScreen(),
      ),
      GoRoute(
        path: chatsListScreen,
        builder: (context, state) => ChatsListScreen(),
      ),
      GoRoute(
        path: chatScreen,
        builder: (context, state) {
          final authProvider = context.read<AuthProvider>();
          final chatRemote = ChatRemoteDataSource(authProvider: authProvider);
          final chatRepository = ChatRepositoryImpl(chatRemote);

          // Handle multiple data types: Map, ChatData, and DoctorDTO
          dynamic data = state.extra;

          String? doctorName;
          String? doctorImage;
          String? chatId;
          String? receiverId;
          dynamic customRepository;

          // Check if it's a Map (from Doctor Details screen)
          if (data is Map<String, dynamic>) {
            doctorName = data['doctorName'] as String?;
            doctorImage = data['doctorImage'] as String?;
            chatId = data['chatId'] as String?;
            receiverId = data['receiverId'] as String?;
            customRepository = data['chatRepository'];
          }
          // Check if it's ChatData (from All tab)
          else if (data is ChatData) {
            doctorName = data.name;
            doctorImage = data.image;
            chatId = data.id.toString();
            // receiverId should be the other person in the conversation
            // If senderId is current user, use receiverId, otherwise use senderId
            receiverId = data.receiverId.isNotEmpty
                ? data.receiverId
                : data.senderId;

            print('🔍 Route - ChatData:');
            print('  - chatId: $chatId');
            print('  - receiverId: $receiverId');
            print('  - senderId: ${data.senderId}');
          }
          // Check if it's a DoctorDTO (from Unread/Favorite tabs)
          else {
            // Access properties directly - both DoctorDTO types have id, name, img
            doctorName = data.name?.toString() ?? data.name ?? '';
            doctorImage = data.img?.toString() ?? data.img ?? '';
            receiverId = data.id?.toString() ?? data.id ?? '';
            chatId = receiverId; // Use receiverId as chatId
          }

          return ChatScreen(
            doctorName: doctorName,
            doctorImage: doctorImage,
            chatId: chatId,
            receiverId: receiverId,
            chatRepository: customRepository ?? chatRepository,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paymentMethodSecondScreen,
        builder: (context, state) {
          final method = state.extra as String;
          return PaymentMethodSecondScreen(methodName: method);
        },
      ),
      GoRoute(
        path: paymentMethodScreen,
        builder: (context, state) => PaymentMethodScreen(),
      ),
      GoRoute(
        path: AppRoutes.addCard,
        builder: (context, state) {
          final method = state.extra as String;
          return AddCardScreen(methodName: method);
        },
      ),
      GoRoute(
        path: AppRoutes.visaPaymentScreen,
        builder: (context, state) => const VisaPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.masterCardPaymentScreen,
        builder: (context, state) => const MasterCardPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.applePayPaymentScreen,
        builder: (context, state) => const ApplePayPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.payPalPaymentScreen,
        builder: (context, state) => const PayPalPaymentScreen(),
      ),
      GoRoute(
        path: settingScreen,
        builder: (context, state) => SettingScreen(),
      ),
      GoRoute(
        path: profileScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ProfileCubit(
              ProfileRepository(
                ProfileRemoteDataSource(
                  ApiServices(authProvider: context.read<AuthProvider>()),
                ),
              ),
            )..getProfile(),
            child: ProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: privacyPolicyScreen,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(path: faqsSreen, builder: (context, state) => FaqsScreen()),

      GoRoute(
        path: AppRoutes.doctorDetailsScreen,
        builder: (context, state) {
          final extra = state.extra;
          int? doctorId;
          String? fallbackImageUrl;

          if (extra is DoctorDetailsArgs) {
            doctorId = extra.doctorId;
            fallbackImageUrl = extra.fallbackImageUrl;
          } else if (extra is int) {
            doctorId = extra;
          } else {
            doctorId = extra as int?;
          }

          return DoctorDetailsScreen(
            doctorId: doctorId,
            fallbackImageUrl: fallbackImageUrl,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.confirmAppointmentScreen,
        builder: (context, state) {
          final appointmentCubit = state.extra as AppointmentCubit?;
          if (appointmentCubit != null) {
            return BlocProvider.value(
              value: appointmentCubit,
              child: const ConfirmAppointmentScreen(),
            );
          } else {
            return BlocProvider(
              create: (context) => AppointmentCubit(),
              child: const ConfirmAppointmentScreen(),
            );
          }
        },
      ),
      GoRoute(
        path: AppRoutes.payAfterScheduleScreen,
        builder: (context, state) {
          final appointmentCubit = state.extra as AppointmentCubit?;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => appointmentCubit ?? AppointmentCubit(),
              ),
              BlocProvider(
                create: (context) => BookingCubit(
                  createBookingUseCase: CreateBookingUseCase(
                    DoctorDetailsBookingRepoImpl.BookingRepoImpl(
                      remoteDataSource: BookingRemoteDataSourceImpl(
                        apiServices: ApiServices(
                          authProvider: context.read<AuthProvider>(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => DoctorDetailsCubit(
                  getDoctorDetailsUseCase: GetDoctorDetailsUseCase(
                    DoctorDetailsRepoImpl(
                      remoteDataSource: DoctorDetailsRemoteDataSourceImpl(
                        apiServices: ApiServices(
                          authProvider: context.read<AuthProvider>(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            child: const PayAfterScheduleScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addReviewScreen,
        builder: (context, state) {
          final doctorId = state.extra as int? ?? 2;
          return AddReviewScreen(doctorId: doctorId);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingScreen,
        builder: (context, state) => BookingScreen(),
      ),
      GoRoute(
        path: AppRoutes.rescheduleScreen,
        builder: (context, state) {
          final bookingId = state.extra as String?;
          return RescheduleView(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: AppRoutes.paymentWebView,
        builder: (context, state) {
          final paymentUrl = state.uri.queryParameters['url'] ?? '';
          final doctorName = state.uri.queryParameters['doctorName'];
          final dateStr = state.uri.queryParameters['date'];
          final time = state.uri.queryParameters['time'];

          DateTime? selectedDate;
          if (dateStr != null && dateStr.isNotEmpty) {
            try {
              selectedDate = DateTime.parse(dateStr);
            } catch (e) {
              print('Error parsing date: $e');
            }
          }

          return PaymentWebViewScreen(
            paymentUrl: paymentUrl,
            doctorName: doctorName,
            selectedDate: selectedDate,
            selectedTime: time,
          );
        },
      ),
    ],
  );
}
