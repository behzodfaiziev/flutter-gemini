part of 'image_analyzer_bloc.dart';

@immutable
sealed class ImageAnalyzerEvent {}

final class InitializeGemini extends ImageAnalyzerEvent {}

final class CompareTwoImages extends ImageAnalyzerEvent {
  CompareTwoImages({required this.image1, required this.image2});

  final Uint8List? image1;
  final Uint8List? image2;
}
