import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'widget/BaseAppBar.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ImagePick());
  }
}

class ImagePick extends StatefulWidget {
  const ImagePick({Key? key}) : super(key: key);

  @override
  State<ImagePick> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePick> {
  bool textScanning = false;
  Map<int, String> lineMap = {};
  XFile? imageFile;
  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60), child: BaseAppBar()),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (!textScanning && imageFile == null)
            Container(
              width: 100,
              height: 100,
            ),
          if (imageFile != null) Image.file(File(imageFile!.path)),
          const Text("Select your receipt",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32)),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.brown,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.image,
                        size: 50,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ))
        ]));
  }

  void getImage(ImageSource source) async {
    try {
      // print("Getting image from gallery");
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        // print("Image path: " + "pickedImage.path");
        // getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognizedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final TextRecognizer textRecognizer =
        TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      // 'BOX COMBO'
      for (TextLine line in block.lines) {
        // if entry exists, will append to existing string. If not, will create new entry

        lineMap.update(
            handleCoordinateEstimation(lineMap, line.cornerPoints[0].y),
            (value) => line.text + ";" + value,
            ifAbsent: () => line.text);
      }
    }
    for (String line in lineMap.values) {
      if (line.toUpperCase().contains("TAX")) {
        scannedText += line + "\n\n";
        break;
      } else if (RegExp(r'(\d+)\.(\d{2})', caseSensitive: false)
          .hasMatch(line)) {
        scannedText += line + "\n\n";
      }
    }
    lineMap.clear();
    textScanning = false;
    setState(() {});
  }

  // Handles coordinate estimation for lineMap
  int handleCoordinateEstimation(Map<int, String> lineMap, int y) {
    for (int key in lineMap.keys) {
      if ((key - y).abs() < 15) {
        return key;
      }
    }

    return y;
  }

  @override
  void initState() {
    super.initState();
  }
}
