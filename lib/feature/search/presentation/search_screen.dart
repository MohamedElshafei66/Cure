import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  int? selectedIndexSpecialist;
  int? selectedIndexHistory;

  final List<Map<String, dynamic>> specialties = [
    {'image': AppIcons.dentist, 'text': 'Dentist'},
    {'image': AppIcons.cardiologist, 'text': 'Cardiologist'},
    {'image': AppIcons.ent, 'text': 'ENT'},
    {'image': AppIcons.neurologist, 'text': 'Neurologist'},
    {'image': AppIcons.generalPractitioner, 'text': 'General Practitioner'},
    {'image': AppIcons.ophthalmologist, 'text': 'Ophthalmologist'},
    {'image': AppIcons.pulmonologist, 'text': 'Pulmonologist'},
    {'image': AppIcons.orthopedic, 'text': 'Orthopedic'},
    {'image': AppIcons.gastroenterologist, 'text': 'Gastroenterologist'},
    {'image': AppIcons.oncologist, 'text': 'Oncologist'},
    {'image': AppIcons.endocrinologist, 'text': 'Endocrinologist'},
    {'image': AppIcons.psychiatrist, 'text': 'Psychiatrist'},
  ];
  final List<Map<String, dynamic>> history = [
    {'image': null, 'text': 'Helwan'},
    {'image': null, 'text': 'physict'},
    {'image': null, 'text': 'Robert JohnsonNT'},
    {'image': null, 'text': 'Heart doctor'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Search', style: AppStyle.styleRegular20(context)),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(AppIcons.arrowBackPng),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(controller: searchController),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Search by your location',
                    style: AppStyle.styleRegular16(context),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: TextButton(
                    onPressed: () {
                      context.push(AppRoutes.map);
                    },
                    child: Text(
                      '129, El-Nasr Street, Cairo',
                      style: AppStyle.styleMedium14(context),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('All Specialties', style: AppStyle.styleRegular20(context)),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: [
                ...specialties.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return SpecialistCard(
                    image: item['image'],
                    text: item['text'],
                    selected: selectedIndexSpecialist == index,
                    onTap: () {
                      setState(() {
                        selectedIndexSpecialist =
                            selectedIndexSpecialist == index ? null : index;
                      });
                    },
                  );
                }),
              ],
            ),
            SizedBox(height: 16),
            Text('History', style: AppStyle.styleRegular20(context)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: [
                ...history.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return SpecialistCard(
                    image: item['image'],
                    text: item['text'],
                    selected: selectedIndexHistory == index,
                    onTap: () {
                      setState(() {
                        selectedIndexHistory = selectedIndexHistory == index
                            ? null
                            : index;
                      });
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
