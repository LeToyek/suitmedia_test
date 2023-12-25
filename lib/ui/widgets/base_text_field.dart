import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseTextField extends ConsumerWidget {
  final TextEditingController? controller;
  final String label;

  const BaseTextField({super.key, this.controller, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          isDense: true),
      style: TextStyle(color: Colors.grey.shade800),
    );
  }
}
