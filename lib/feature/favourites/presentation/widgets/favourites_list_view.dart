import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';

class FavouritesListView extends StatelessWidget {
  final List<DoctorModel> doctors;

  const FavouritesListView({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) => DoctorCard(doctor: doctors[index]),
    );
  }
}

