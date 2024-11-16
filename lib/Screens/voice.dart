import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:calculator/Constants/colors.dart'; // Import your color file here
import 'package:calculator/Provider/Cal_Provider.dart';

import '../Widgets/appbar.dart';

class MicrophonePermissionScreen extends StatefulWidget {
  @override
  _MicrophonePermissionScreenState createState() =>
      _MicrophonePermissionScreenState();
}

class _MicrophonePermissionScreenState
    extends State<MicrophonePermissionScreen> {
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  double confidenceLevel = 0.0;
  final TextEditingController textController = TextEditingController();

  final GenerativeModel geminiModel = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: AppConstants.GEMINI_API_KEY,
  );

  bool isLoading = false; // Track loading state
  String geminiResponse = ''; // Store Gemini AI response

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  // Initialize SpeechToText
  void initSpeech() async {
    speechEnabled = await speechToText.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );
    setState(() {});
  }

  // Start listening to the microphone
  void startListening() async {
    if (speechEnabled && !speechToText.isListening) {
      await speechToText.listen(
        onResult: onSpeechResult,
        listenMode: ListenMode.dictation,
      );
      setState(() {});
    }
  }

  // Stop listening
  void stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
      setState(() {});
    }
  }

  // Callback to capture the spoken words
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      textController.text = result.recognizedWords;
      confidenceLevel = result.confidence;
    });
  }

  // Send text to Google Gemini AI for processing
  Future<void> sendTextToGemini() async {
    final userInput = textController.text.trim();
    if (userInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter some text")),
      );
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
      geminiResponse = ''; // Reset previous response
    });

    try {
      final prompt = 'Please analyze: $userInput';
      final content = [Content.text(prompt)];
      final response = await geminiModel.generateContent(content);

      setState(() {
        geminiResponse = response?.text ?? "Error in AI response";
      });
    } catch (e) {
      setState(() {
        geminiResponse = "Error: $e";
      });
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<CalculatorProvider>(context).isDarkTheme;

    return Scaffold(
      backgroundColor: context.watch<CalculatorProvider>().isDarkTheme
          ? AppColors.darkPrimaryColor
          : Colors.lightBlueAccent,
      appBar: CommonAppBar(isHomeScreen: false),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                speechToText.isListening
                    ? "Listening..."
                    : speechEnabled
                    ? "Tap the mic to start listening..."
                    : "Speech recognition not available",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              // Editable text field for transcribed text
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: textController,
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Transcribed text will appear here...",
                  ),
                ),
              ),
              // Confidence level display
              if (speechToText.isNotListening && confidenceLevel > 0)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Confidence: ${(confidenceLevel * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: startListening,
                    icon: Icon(
                      speechToText.isListening ? Icons.mic : Icons.mic_off,
                      color: speechToText.isListening ? Colors.red : Colors.deepPurple,
                    ),
                    label: const Text("Speak"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: sendTextToGemini,
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
              const SizedBox(height: 20),
              // Loading indicator or result display
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
                  geminiResponse.isNotEmpty
                      ? "Result: $geminiResponse"
                      : "No result from Gemini AI.",
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
