import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';

class SearchResultsList extends StatelessWidget {
  final List<DoctorModel> results;

  const SearchResultsList({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: results.map((doctor) => DoctorCard(doctor: doctor)).toList(),
    );
  }
}
