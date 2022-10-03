class BlogModal {
  final String uId;
  final String title;
  final String description;
  final String uMail;
  final String imageUrl;

  BlogModal(
      {required this.uId,
      required this.title,
      required this.imageUrl,
      required this.uMail,
      required this.description});
  static BlogModal fromJson(Map<String, dynamic> json) => BlogModal(
      uId: json['uId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      uMail: json['uMail'],
      description: json['description']);
}
