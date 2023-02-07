import 'package:blog_app/models/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blogModal});
  final BlogModal blogModal;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey.shade800, width: 2),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 15,
                        child: Text(blogModal.uMail[0].toUpperCase()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(blogModal.uMail,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    blogModal.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    blogModal.createdOn!.toString().substring(0, 10),
                    style: TextStyle(
                        color: Colors.blueGrey.shade100, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            height: 80,
            width: 80,
            color: Colors.grey,
            child: CachedNetworkImage(
              imageUrl: blogModal.imageUrl,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
