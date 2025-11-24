import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/about_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info_details.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_and_rate.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorDetailsBody extends StatelessWidget {
  final String? fallbackImageUrl;
  const DoctorDetailsBody({super.key, this.fallbackImageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsState>(
      listener: (context, state) {
        if (state is DoctorDetailsLoaded) {
          context.read<AppointmentCubit>().setDoctorDetails(state.doctorDetails);
        }
      },
      builder: (context, state) {
        
        if (state is DoctorDetailsLoading) {
          return const DoctorDetailsSkeleton();
        }
        if (state is DoctorDetailsError) {

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<DoctorDetailsCubit>();
                    if (cubit.currentDoctorId != null) {
                      cubit.fetchDoctorDetails(cubit.currentDoctorId!);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (state is DoctorDetailsLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorInfo(
                  doctorDetails: state.doctorDetails,
                  fallbackImageUrl: fallbackImageUrl,
                ),
                const SizedBox(height: 24),
                DoctorInfoDetails(doctorDetails: state.doctorDetails),
                const SizedBox(height: 40),
                AboutDoctor(doctorDetails: state.doctorDetails),
                const SizedBox(height: 24),
                ReviewAndRate(doctorDetails: state.doctorDetails),
                const SizedBox(height: 24),
                ReviewCard(doctorDetails: state.doctorDetails),
                PriceOfDoctor(doctorDetails: state.doctorDetails),
                const SizedBox(height: 12),
                CustomButton(
                  text: AppStrings.bookAppointment,
                  onPressed: () {
                    // Get the AppointmentCubit before navigation
                    final appointmentCubit = context.read<AppointmentCubit>();
                    context.push(
                      AppRoutes.confirmAppointmentScreen,
                      extra: appointmentCubit,
                    );
                  },
                ),
                const SizedBox(height: 29),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class DoctorDetailsSkeleton extends StatelessWidget {
  const DoctorDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xffA19FAB),
        highlightColor: Colors.white,
        duration: Duration(milliseconds: 1500),
      ),
      containersColor: const Color(0xffD8D6E2),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SkeletonHeader(),
            const SizedBox(height: 24),
            const _SkeletonInfoTiles(),
            const SizedBox(height: 32),
            _SkeletonSection(
              titleWidth: 140,
              lines: const [1.0, 0.85, 0.9],
            ),
            const SizedBox(height: 24),
            _SkeletonSection(
              titleWidth: 120,
              lines: const [0.95, 0.85, 0.75],
            ),
            const SizedBox(height: 24),
            Column(
              children: List.generate(2, (_) => const _SkeletonReviewCard()),
            ),
            const SizedBox(height: 16),
            Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SkeletonHeader extends StatelessWidget {
  const _SkeletonHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonCircle(diameter: 92),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _SkeletonLine(widthFactor: 0.8, height: 18),
                SizedBox(height: 6),
                _SkeletonLine(widthFactor: 0.55, height: 16),
                SizedBox(height: 6),
                _SkeletonLine(widthFactor: 0.45, height: 14),
                SizedBox(height: 6),
                _SkeletonLine(widthFactor: 0.6, height: 14),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const _SkeletonCircle(diameter: 44),
        ],
      ),
    );
  }
}

class _SkeletonInfoTiles extends StatelessWidget {
  const _SkeletonInfoTiles();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SkeletonInfoRow(),
        SizedBox(height: 12),
        _SkeletonInfoRow(),
      ],
    );
  }
}

class _SkeletonInfoRow extends StatelessWidget {
  const _SkeletonInfoRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _InfoTilePlaceholder()),
        SizedBox(width: 12),
        Expanded(child: _InfoTilePlaceholder()),
      ],
    );
  }
}

class _InfoTilePlaceholder extends StatelessWidget {
  const _InfoTilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _SkeletonLine(widthFactor: 0.35, height: 16),
          SizedBox(height: 8),
          _SkeletonLine(widthFactor: 0.5, height: 14),
        ],
      ),
    );
  }
}

class _SkeletonSection extends StatelessWidget {
  final double titleWidth;
  final List<double> lines;
  const _SkeletonSection({
    required this.titleWidth,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: titleWidth,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 12),
        ...lines.map(
          (factor) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SkeletonLine(widthFactor: factor, height: 14),
          ),
        ),
      ],
    );
  }
}

class _SkeletonReviewCard extends StatelessWidget {
  const _SkeletonReviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _SkeletonCircle(diameter: 60),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonLine(widthFactor: 0.45, height: 16),
                    SizedBox(height: 6),
                    _SkeletonLine(widthFactor: 0.35, height: 14),
                  ],
                ),
              ),
              _SkeletonLine(widthFactor: 0.15, height: 24),
            ],
          ),
          const SizedBox(height: 12),
          const _SkeletonLine(widthFactor: 0.95, height: 14),
          const SizedBox(height: 6),
          const _SkeletonLine(widthFactor: 0.9, height: 14),
        ],
      ),
    );
  }
}

class _SkeletonCircle extends StatelessWidget {
  final double diameter;
  const _SkeletonCircle({required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double widthFactor;
  final double height;
  const _SkeletonLine({
    required this.widthFactor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * widthFactor;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}


