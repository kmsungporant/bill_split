import 'dart:ui';

import 'package:bill_split/api/request.dart';
import 'package:bill_split/models/Bill.dart';
import 'package:bill_split/pages/Contacts.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../models/Item.dart';
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
  late Bill newBill;

  @override
  Widget build(BuildContext context) {
    if (!textScanning && imageFile == null) {}
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: BaseAppBar(headerStr: "Upload Receipt")),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (!textScanning && imageFile == null)
            Container(
              width: 100,
              height: 100,
            ),
          if (imageFile != null)
            Image.file(
              File(imageFile!.path),
              height: 500,
              width: 500,
            ),
          const Text("Select Your Receipt",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightGreen,
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Column(
                      children: [
                        const Icon(Icons.image, size: 50),
                        Text(
                          "Browse Photos",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )),
              if (imageFile != null)
                Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreen,
                        shadowColor: Colors.black,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Contacts(currBill: newBill)),
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.send, size: 50),
                          const Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ))
            ],
          )
        ]));
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognizedText(pickedImage);
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
    // Creates bill given line map
    newBill = createBill(lineMap);
    request.postBill(newBill);
    // request.getBill();
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

  // Parses line into Item object
  Item createItem(String line) {
    final splitString = line.split(";");
    if (splitString.length == 2) {
      return Item(1, splitString[0], double.parse(splitString[1]));
    } else if (splitString.length == 3) {
      return Item(int.parse(splitString[1]), splitString[2],
          double.parse(splitString[0]));
    }
    return Item(1, "Error, please try again", 0.0);
  }

  Bill createBill(Map<int, String> lineMap) {
    List<Item> itemList = [];
    double tax = 0, subTotal = 0;
    for (String line in lineMap.values) {
      final Item item = createItem(line);
      if (line.toUpperCase().contains("TAX")) {
        tax = item.price;
        break;
      } else if (line.toUpperCase().contains("SUBTOTAL")) {
        subTotal = item.price;
      } else if (RegExp(r'(\d+)\.(\d{2})', caseSensitive: false)
          .hasMatch(line)) {
        itemList.add(item);
      }
    }
    return Bill(itemList, tax, subTotal);
  }

  @override
  void initState() {
    super.initState();
  }
}
