import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/provider/name/name_state_provider.dart';
import 'package:suitmedia_test/ui/widgets/my_app_bar.dart';

class SecondScreen extends ConsumerWidget {
  static const routePath = "/second-screen";
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameRef = ref.watch(nameProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: myAppBar(context, "Second Screen"),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: textTheme.labelLarge,
            ),
            Text(nameRef,
                textAlign: TextAlign.start,
                style: textTheme.bodyLarge!.apply(
                    color: Colors.black87,
                    fontWeightDelta: 2,
                    fontSizeDelta: 6)),
            const Spacer(),
            Center(
              child: Text(
                "Selected User Name",
                style: textTheme.headlineLarge!.apply(fontWeightDelta: 2),
              ),
            ),
            const Spacer(),
            InkWell(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      "Choose a User",
                      style: textTheme.bodyLarge!
                          .apply(color: Colors.white, fontWeightDelta: 2),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}