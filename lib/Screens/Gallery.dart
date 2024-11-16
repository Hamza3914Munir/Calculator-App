import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:calculator/Constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:calculator/Provider/Cal_Provider.dart';

import '../Widgets/appbar.dart';

class GalleryCaptureScreen extends StatefulWidget {
  @override
  GalleryCaptureScreenState createState() => GalleryCaptureScreenState();
}

class GalleryCaptureScreenState extends State<GalleryCaptureScreen> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String extractedText = "";
  bool isLoading = false;
  String calculationResult = "";

  // Initialize Google Gemini model instance
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: AppConstants.GEMINI_API_KEY,
  );

  // Controller for the extracted text
  final TextEditingController textController = TextEditingController();

  // Method to pick a picture from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      await _extractTextFromImage(imageFile!);
    }
  }


  // Extract text using Google ML Kit
  Future<void> _extractTextFromImage(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    setState(() {
      extractedText = recognizedText.text;
      textController.text = extractedText; // Populate the controller
    });
    textRecognizer.close();
  }

  // Method to perform calculation using the Google Gemini API
  Future<void> _performCalculation() async {
    setState(() {
      isLoading = true;
      calculationResult = "";
    });

    try {
      final userInput = textController.text.trim();
      if (userInput.isEmpty) {
        setState(() {
          calculationResult = "Please enter a valid expression.";
        });
      } else {
        final prompt = 'Please solve this mathematical expression: $userInput';
        final content = [Content.text(prompt)];
        final response = await _model.generateContent(content);
        setState(() {
          calculationResult = response?.text ?? "Unable to calculate.";
        });
      }
    } catch (e) {
      setState(() {
        calculationResult = "Error: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<CalculatorProvider>(context);
    final isDarkTheme = value.isDarkTheme;

    return Scaffold(
      backgroundColor: context.watch<CalculatorProvider>().isDarkTheme
          ? AppColors.darkPrimaryColor
          : Colors.lightBlueAccent,
      appBar: CommonAppBar(isHomeScreen: false),
      body: imageFile == null
          ? Center(
        child: ElevatedButton.icon(
          onPressed: _pickImageFromGallery,
          icon: Icon(Icons.camera_alt_rounded),
          label: Text("Pick Image from Gallery"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imageFile != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    imageFile!,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkAccentColor
                      : Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextField(
                  controller: textController,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Extracted text will appear here...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: Icon(Icons.camera_alt_rounded),
                    label: Text("Retake"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _performCalculation,
                    icon: Icon(Icons.calculate),
                    label: Text("Calculate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkAccentColor
                      : Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Text(
                  calculationResult.isNotEmpty
                      ? "Result: $calculationResult"
                      : "No calculation performed.",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
