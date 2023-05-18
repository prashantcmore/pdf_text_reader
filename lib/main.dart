import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pdf_text/pdf_text.dart';
import 'package:pdf_text_scanner/upload_pdf_file.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Text Reader',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: UploadPdf(),
    );
  }
}
