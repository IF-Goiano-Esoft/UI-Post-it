import 'package:flutter/material.dart';
import 'package:post_it/models/post_it.dart';

// ignore: must_be_immutable
class CardPostIt extends StatelessWidget {
  PostIt post;

  CardPostIt(
    this.post, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: post.color,
        child: Column(
          children: [
            ListTile(
              title: Text(
                post.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                post.description,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Prazo: ',
                  style: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                ),
                Text(
                  "${post.date.day}/${post.date.month}/${post.date.year}",
                  style: const TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
