import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/models/specialist_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/domain/repositories/specialist_repo.dart';

class SpecialistRepoImpl implements SpecialistRepo {
  final ApiServices apiServices;

  SpecialistRepoImpl(this.apiServices);

  @override
  Future<List<SpecialistModel>> getSpecialists() async {
    final response = await apiServices.get(
      endPoint: 'Customer/Specialists/GetAllSpecialists',
    );

    final List data = response['data'];

    return data.map((json) => SpecialistModel.fromJson(json)).toList();
  }
}
