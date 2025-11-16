class DoctorDetailsEntity{
  final int doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorLocation;
  final String doctorImage;
  final String doctorAbout;
  final num patients;
  final num experience;
  final num rating;
  final num reviews;
  final num doctorPrice;

  DoctorDetailsEntity(
      this.doctorId,
      this.doctorName,
      this.doctorSpecialty,
      this.doctorLocation,
      this.doctorImage,
      this.doctorAbout,
      this.patients,
      this.experience,
      this.rating,
      this.reviews,
      this.doctorPrice
      );
}