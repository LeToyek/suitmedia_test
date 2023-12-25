import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/pages/first_screen.dart';
import 'package:suitmedia_test/ui/pages/second_screen.dart';
import 'package:suitmedia_test/ui/pages/third_screen.dart';

final routeProvider =
    Provider<Map<String, Widget Function(BuildContext)>>((ref) {
  return {
    "/first-screen": (context) => const FirstScreen(),
    "/second-screen": (context) => const SecondScreen(),
    "/third-screen": (context) => const ThirdScreen(),
  };
});
