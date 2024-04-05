import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

part 'image_analyzer_event.dart';

part 'image_analyzer_state.dart';

class ImageAnalyzerBloc extends Bloc<ImageAnalyzerEvent, ImageAnalyzerState> {
  ImageAnalyzerBloc() : super(ImageAnalyzerInitial()) {
    on<ImageAnalyzerEvent>((event, emit) {});
    on<InitializeGemini>(_initializeGeminiHandler);

    on<CompareTwoImages>(_compareTwoImageHandler);
  }

  String? apiKey;

  // For text-and-image input (multimodal), use the gemini-pro-vision model
  GenerativeModel? model;

  Future<void> _initializeGeminiHandler(
    InitializeGemini event,
    Emitter<ImageAnalyzerState> emit,
  ) async {
    apiKey = "YOUR_API_KEY";
    model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey!);
  }

  Future<void> _compareTwoImageHandler(
      CompareTwoImages event, Emitter<ImageAnalyzerState> emit) async {
    try {
      if (event.image1 == null || event.image2 == null) {
        emit(CompareTwoImagesError("Please select two images"));
        return;
      }

      if (model == null) {
        emit(CompareTwoImagesError("Model not initialized"));
        return;
      }

      final prompt = TextPart("What's different between these pictures?."
          "If it is dog, give more info about dogs");

      final firstImage = event.image1!;
      final secondImage = event.image2!;

      final imageParts = [
        DataPart('image/jpeg', firstImage),
        DataPart('image/jpeg', secondImage),
      ];

      emit(CompareTwoImagesLoading());
      final GenerateContentResponse response = await model!.generateContent([
        Content.multi([prompt, ...imageParts])
      ]);

      if (response.text == null) {
        emit(CompareTwoImagesError("Something went wrong"));
        return;
      }
      emit(CompareTwoImagesResponse(response.text!));
    } catch (e) {
      emit(CompareTwoImagesError(e.toString()));
      return;
    }
  }
}
