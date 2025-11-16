class ReviewEntity{
  final String personName;
  final String personImage;
  final String commentReview;
  final num ratingReview;
  final num numberOfReviews;
  final num timeReview;
  ReviewEntity(
      this.personName,
      this.commentReview,
      this.ratingReview,
      this.personImage,
      this.numberOfReviews,
      this.timeReview
      );
}