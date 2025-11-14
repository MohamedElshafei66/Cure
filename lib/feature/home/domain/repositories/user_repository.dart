import 'package:round_7_mobile_cure_team3/feature/home/data/models/user_model.dart';

abstract class UserRepo {
  Future<UserModel> getUser();
}
