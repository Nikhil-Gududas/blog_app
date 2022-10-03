import 'package:blog_app/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/blog.dart';

class UserScreen extends StatelessWidget {
  CollectionReference getBlogs = FirebaseFirestore.instance.collection('blogs');
  UserScreen({super.key});
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Blogs'),
      ),
      body: Stack(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: getBlogs.snapshots().asBroadcastStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    final blogs = snapshot.data;
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...blogs!.docs
                            .where((element) => element['uMail']
                                .toString()
                                .contains(user!.email.toString()))
                            .map((e) {
                          final blogM = BlogModal(
                              uId: e.get('uId'),
                              title: e.get('title'),
                              imageUrl: e.get('imageUrl'),
                              uMail: e.get('uMail'),
                              description: e.get('description'));
                          return buildBlog(blogM);
                        })
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.greenAccent, elevation: 40),
                onPressed: () {
                  _auth.signOut().then((value) =>
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName));
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
