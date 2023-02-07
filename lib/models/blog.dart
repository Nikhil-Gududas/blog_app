import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModal {
  final String uId;
  final String title;
  final String description;
  final String uMail;
  final String imageUrl;
  DateTime? createdOn;
  BlogModal({
    required this.uId,
    required this.title,
    required this.imageUrl,
    required this.uMail,
    required this.description,
    this.createdOn,
  });
  static BlogModal fromJson(Map<String, dynamic> json) => BlogModal(
        uId: json['uId'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        uMail: json['uMail'],
        description: json['description'],
        createdOn: (json['createdOn'] as Timestamp).toDate(),
      );
}
