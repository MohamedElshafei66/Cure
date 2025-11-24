class SearchModel {
  final String keyword;
  final int? specialityId;
  final int? gender;
  final String? sortBy;
  final int? pageNumber;
  final int? pageSize;

  SearchModel({
    required this.keyword,
    this.specialityId,
    this.gender,
    this.sortBy,
    this.pageNumber,
    this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'keyword': keyword,
      if (specialityId != null) 'specialityId': specialityId,
      if (gender != null) 'gender': gender,
      if (sortBy != null) 'sortBy': sortBy,
      'pageNumber': pageNumber ?? 1,
      'pageSize': pageSize ?? 10,
    };
  }
}
