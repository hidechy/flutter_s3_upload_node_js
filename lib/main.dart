import 'package:flutter/material.dart';

import 's3_upload_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: S3UploadPage());
  }
}
