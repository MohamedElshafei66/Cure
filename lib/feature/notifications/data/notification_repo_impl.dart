import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/model/notification_model.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/domain/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final SecureStorageService secureStorage;
  final AuthProvider authProvider;

  NotificationRepositoryImpl({required this.secureStorage, required this.authProvider});

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final api = ApiServices(authProvider: authProvider);
    final response = await api.get(
      endPoint: ApiEndpoints.getUserNotifications,
    );

    final List<dynamic> data = response['data'];
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<void> markAsRead(int id) async {
    final api = ApiServices(authProvider: authProvider);
    await api.post(
      endPoint: '${ApiEndpoints.putMarkAsRead}$id',
      body: {},
    );
  }
}
