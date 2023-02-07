import 'package:blog_app/screens/new_blog_screen.dart';
import 'package:blog_app/widgets/blog_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/blog.dart';
import 'blog_detail_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  Stream<List<BlogModal>> getBlogs() => FirebaseFirestore.instance
      .collection('blogs')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => BlogModal.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog App')),
      body: StreamBuilder(
        stream: getBlogs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.hasData) {
            final blogs = snapshot.data;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: blogs!
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogDetailScreen(
                              blogModal: e,
                            ),
                          )),
                      child: BlogCard(blogModal: e),
                    ),
                  )
                  .toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewBlogScreen(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
