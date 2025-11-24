import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/home/domain/repositories/specialist_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';

class SpecialistCubit extends Cubit<SpecialistState> {
  final SpecialistRepo repo;

  SpecialistCubit(this.repo) : super(SpecialistInitial());

  Future<void> loadSpecialists() async {
    emit(SpecialistLoading());

    try {
      final list = await repo.getSpecialists();
      emit(SpecialistLoaded(list));
    } catch (e) {
      emit(SpecialistError(e.toString()));
    }
  }
}
