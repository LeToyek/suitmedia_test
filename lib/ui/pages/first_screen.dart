import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/provider/name/name_state_provider.dart';

class FirstScreen extends ConsumerStatefulWidget {
  static const routePath = "/first-screen";
  const FirstScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  bool isPalindrome(String input) {
    final text = input.toLowerCase();
    final textLength = text.length;
    for (int i = 0; i < textLength / 2; i++) {
      if (text[i] != text[textLength - i - 1]) {
        return false;
      }
    }
    return true;
  }

  void showIsPalindrome() {
    if (isPalindrome(_palindromeController!.text)) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("isPalindrome"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("not palindrome"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"))
                ],
              ));
    }
  }

  void goToNextPage() {
    ref.read(nameProvider.notifier).state = _nameController!.text;
    Navigator.pushNamed(context, "/second-screen");
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? _nameController;
  TextEditingController? _palindromeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _palindromeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController?.dispose();
    _palindromeController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
              child: const Center(
                  child: Icon(
                Icons.person_add_alt_1,
                size: 32,
                color: Colors.white,
              )),
            ),
            const SizedBox(height: 40),
            _buildTextField(label: "Name", controller: _nameController),
            const SizedBox(height: 16),
            _buildTextField(
                label: "Palindrome", controller: _palindromeController),
            const SizedBox(height: 40),
            _buildButton(context, label: "Check", onPressed: showIsPalindrome),
            const SizedBox(
              height: 16,
            ),
            _buildButton(context, label: "Next", onPressed: goToNextPage),
          ],
        ),
      ),
    ));
  }

  Widget _buildTextField(
      {required String label, TextEditingController? controller}) {
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

  Widget _buildButton(BuildContext context,
      {required String label, required VoidCallback? onPressed}) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: colorScheme.primary),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
