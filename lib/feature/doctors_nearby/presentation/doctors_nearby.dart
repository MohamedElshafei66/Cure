import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class DoctorsNearby extends StatefulWidget {
  const DoctorsNearby({super.key});

  @override
  State<DoctorsNearby> createState() => _DoctorsNearbyState();
}

class _DoctorsNearbyState extends State<DoctorsNearby> {
  int selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> specialties = [
    {'image': null, 'text': 'All'},
    {'image': AppIcons.dentist, 'text': 'Dentist'},
    {'image': AppIcons.cardiologist, 'text': 'Cardiologist'},
    {'image': AppIcons.ent, 'text': 'ENT'},
    {'image': AppIcons.ophthalmologist, 'text': 'Ophthalmologist'},
    {'image': AppIcons.neurologist, 'text': 'Neurologist'},
    {'image': AppIcons.endocrinologist, 'text': 'Endocrinologist'},
    {'image': AppIcons.oncologist, 'text': 'Oncologist'},
    {'image': AppIcons.pulmonologist, 'text': 'Pulmonologist'},
    {'image': AppIcons.psychiatrist, 'text': 'Psychiatrist'},
    {'image': AppIcons.orthopedic, 'text': 'Orthopedic'},
    {'image': AppIcons.gastroenterologist, 'text': 'Gastroenterologist'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Doctors', style: AppStyle.styleRegular20(context)),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(AppIcons.arrowBackPng),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(controller: searchController),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialties.length,
                  itemBuilder: (context, index) {
                    final item = specialties[index];
                    return SpecialistCard(
                      image: item['image'],
                      text: item['text'],
                      selected: selectedIndex == index,
                      onTap: () {
                        setState(() => selectedIndex = index);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              DoctorCard(isFavourite: true),
              DoctorCard(isFavourite: false),
              DoctorCard(isFavourite: false),
              DoctorCard(isFavourite: false),
              DoctorCard(isFavourite: true),
              DoctorCard(isFavourite: false),
            ],
          ),
        ),
      ),
    );
  }
}
