import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/models/user_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/domain/repositories/user_repository.dart';

class UserReposotryImpl implements UserRepo {
  ApiServices apiServices;
  UserReposotryImpl(this.apiServices);

  @override
  Future<UserModel> getUser() async {
    final response = await apiServices.get(
      endPoint: ApiEndpoints.getUserProfile,
    );
    final data = response['data'];

    return UserModel.fromJson(data);
  }
}
