import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/provider/name/name_state_provider.dart';
import 'package:suitmedia_test/ui/widgets/base_alert_dialog.dart';
import 'package:suitmedia_test/ui/widgets/base_button_bar.dart';
import 'package:suitmedia_test/ui/widgets/base_text_field.dart';

class FirstScreen extends ConsumerStatefulWidget {
  static const routePath = "/first-screen";
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  late final GlobalKey<ScaffoldMessengerState> smState;

  bool checkEmptyField(String input, String label) {
    if (input.isEmpty) {
      smState.currentState!.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(label),
      ));

      return false;
    }
    return true;
  }

  bool isPalindrome(String input) {
    final text = input.toLowerCase().replaceAll(" ", "");
    final textLength = text.length;
    for (int i = 0; i < textLength / 2; i++) {
      if (text[i] != text[textLength - i - 1]) {
        return false;
      }
    }
    return true;
  }

  void showIsPalindrome() {
    if (!checkEmptyField(_palindromeController!.text, "fill the palindrome")) {
      return;
    }
    if (isPalindrome(_palindromeController!.text)) {
      showDialog(
          context: context,
          builder: (context) => const BaseAlertDialog(title: "isPalindrome"));
      return;
    }
    showDialog(
        context: context,
        builder: (context) => const BaseAlertDialog(title: "not palindrome"));
    return;
  }

  void goToNextPage() {
    final nameText = _nameController!.text.replaceAll(" ", "");
    if (!checkEmptyField(nameText, "fill the name")) {
      return;
    }
    ref.read(nameProvider.notifier).state = nameText;
    Navigator.pushNamed(context, "/second-screen");
  }

  TextEditingController? _nameController;
  TextEditingController? _palindromeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _palindromeController = TextEditingController();
    smState = GlobalKey<ScaffoldMessengerState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController?.dispose();
    _palindromeController?.dispose();
    smState.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: smState,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(48),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.5)),
                          child: const Center(
                              child: Icon(
                            Icons.person_add_alt_1,
                            size: 32,
                            color: Colors.white,
                          )),
                        ),
                        const SizedBox(height: 40),
                        BaseTextField(
                            label: "Name", controller: _nameController),
                        const SizedBox(height: 16),
                        BaseTextField(
                            label: "Palindrome",
                            controller: _palindromeController),
                        const SizedBox(height: 40),
                        BaseButtonBar(
                            label: "CHECK", onPressed: showIsPalindrome),
                        const SizedBox(
                          height: 16,
                        ),
                        BaseButtonBar(label: "NEXT", onPressed: goToNextPage),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
