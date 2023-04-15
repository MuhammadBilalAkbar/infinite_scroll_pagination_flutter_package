import 'package:flutter/material.dart';

class PostItemWidget extends StatelessWidget {
  final String title;
  final String body;
  final int id;

  const PostItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.amber,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$id: $title',
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(body, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      );
}
