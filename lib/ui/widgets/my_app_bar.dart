import 'package:flutter/material.dart';

AppBar myAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.2),
      child: Divider(
        height: 0.2,
        color: Colors.grey.shade300,
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: Color(0xFF554AF0),
      ),
    ),
    // elevation: 0.5,

    title: Text(
      title,
      style:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    ),
    centerTitle: true,
  );
}
