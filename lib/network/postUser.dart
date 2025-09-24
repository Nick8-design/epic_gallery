import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../data/provider.dart';


  final Dio dio = Dio();


  Future<void> submitData(String fullName, String email, String password, String favorite, BuildContext context,ref) async {
  // Show loader dialog
  showDialog(
    context: context,
    barrierDismissible: false, // prevent closing by tapping outside
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  try {
    final response = await dio.post(
      'https://jsonplaceholder.typicode.com/posts',
      data: {
        "fullName": fullName,
        "email": email,
        "password": password,
        "favorite": favorite,
      },
    );

    Navigator.of(context).pop(); // close loader

    if (response.statusCode == 201) {
      ref.read(userCreated.notifier).state = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Success! Data sent")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed: ${response.statusCode}")),
      );
    }
  } catch (e) {
    Navigator.of(context).pop(); // close loader
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}
