import 'package:flutter/material.dart';

showSnackBarMessenger(
    {required BuildContext context,
    required String message,
    required Color color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(20),
      backgroundColor: color,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    ),
  );
}
