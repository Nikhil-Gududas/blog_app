import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/blog.dart';

class BlogEditingScreen extends StatelessWidget {
  BlogEditingScreen({super.key, required this.blogModal, required this.id});
  final BlogModal blogModal;
  final String id;
  late DocumentReference documentReference;
  late Reference storage;
  deleteBlog() async {
    documentReference = FirebaseFirestore.instance.collection('blogs').doc(id);
    storage = FirebaseStorage.instance.refFromURL(blogModal.imageUrl);
    await storage.delete();
    await documentReference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                deleteBlog();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                // color: Colors.red,
              ))
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 25,
                    child: Text(blogModal.uMail[0].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(blogModal.uMail,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        blogModal.createdOn!.toString().substring(0, 10),
                        style: TextStyle(
                            color: Colors.blueGrey.shade100, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text(
                blogModal.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                height: 250,
                width: double.infinity,
                // decoration:
                //     BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: blogModal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text(
                blogModal.description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
