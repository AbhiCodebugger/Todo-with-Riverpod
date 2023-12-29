import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final TextEditingController controller;

  const TextFieldWidget({
    required this.hintText,
    required this.maxLine,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText,
          ),
          maxLines: maxLine,
        ));
  }
}
