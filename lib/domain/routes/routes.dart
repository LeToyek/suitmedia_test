import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/pages/first_screen.dart';

final routeProvider =
    Provider<Map<String, Widget Function(BuildContext)>>((ref) {
  return {
    "/first-screen": (context) => const FirstScreen(),
  };
});
