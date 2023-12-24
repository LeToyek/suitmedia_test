import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstScreen extends ConsumerStatefulWidget {
  static const routePath = "/first-screen";
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("First Screen"),
        ),
        body: Container());
  }
}
