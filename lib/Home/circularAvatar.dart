// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  String? image;
  String text;
  IconData? icon;
  CircularAvatar({super.key, this.image, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            height: 70,
            width: 70,
            color: Colors.black,
            child: image == null
                ? Icon(
                    icon!,
                    color: Colors.white,
                    size: 35,
                  )
                : Image.asset(
                    image!,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(text),
      ],
    );
  }
}
