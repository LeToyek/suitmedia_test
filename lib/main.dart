import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/domain/routes/routes.dart';
import 'package:suitmedia_test/ui/theme/main_theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesRef = ref.watch(routeProvider);
    final themeRef = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suitmedia Test',
      theme: themeRef,
      themeMode: ThemeMode.light,
      routes: routesRef,
      initialRoute: routesRef.keys.first,
    );
  }
}
