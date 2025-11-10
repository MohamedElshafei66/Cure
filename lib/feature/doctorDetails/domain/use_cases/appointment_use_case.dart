import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/appointment_Entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/appointment_repo.dart';

class FetchAvailableSlotsUseCase extends UseCase<String,String>{
  final AppointmentRepo appointmentRepo;
  FetchAvailableSlotsUseCase(this.appointmentRepo);
  @override
  Future<Either<Failure, String>> call(String doctorId)async{
    return await appointmentRepo.fetchAvailableSlots(doctorId);
  }

}


class BookAppointmentUseCase extends UseCase<AppointmentEntity,AppointmentEntity>{
  final AppointmentRepo appointmentRepo;
  BookAppointmentUseCase(this.appointmentRepo);

  @override
  Future<Either<Failure, AppointmentEntity>> call(AppointmentEntity appointmentEntity)async{
    return await appointmentRepo.bookAppointment(appointmentEntity);
  }

}