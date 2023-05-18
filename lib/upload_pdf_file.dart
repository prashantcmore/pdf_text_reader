import 'package:flutter/material.dart';

import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

import 'package:pdf_text/pdf_text.dart';

class UploadPdf extends StatefulWidget {
  UploadPdf({Key? key}) : super(key: key);

  @override
  State<UploadPdf> createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  PDFDoc? _pdfDoc;
  String _text = "";

  bool _buttonsEnabled = true;

  Future _pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      setState(() {});
    }
  }

  Future _readRandomPage() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc!.pageAt(Random().nextInt(_pdfDoc!.length) + 1).text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  Future _readWholeDoc() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc!.text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Text Example'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              TextButton(
                child: Text(
                  "Pick PDF document",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.all(5), backgroundColor: Colors.deepOrange),
                onPressed: _pickPDFText,
              ),
              TextButton(
                child: Text(
                  "Read Text",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.all(5), backgroundColor: Colors.deepOrange),
                onPressed: _buttonsEnabled ? _readRandomPage : () {},
              ),
              TextButton(
                child: Text(
                  "Read Complete Document Text",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.all(5), backgroundColor: Colors.deepOrange),
                onPressed: _buttonsEnabled ? _readWholeDoc : () {},
              ),
              Padding(
                child: Text(
                  _pdfDoc == null
                      ? "Pick a new PDF document and wait for it to load..."
                      : "PDF document loaded, ${_pdfDoc!.length} pages\n",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(15),
              ),
              Padding(
                child: Text(
                  _text == "" ? "" : "Text:",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(15),
              ),
              Text(_text),
            ],
          ),
        ));
  }
}
