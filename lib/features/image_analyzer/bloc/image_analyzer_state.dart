part of 'image_analyzer_bloc.dart';

@immutable
sealed class ImageAnalyzerState {}

final class ImageAnalyzerInitial extends ImageAnalyzerState {}

final class CompareTwoImagesResponse extends ImageAnalyzerState {
  final String response;

  CompareTwoImagesResponse(this.response);
}

final class CompareTwoImagesError extends ImageAnalyzerState {
  final String error;

  CompareTwoImagesError(this.error);
}
final class CompareTwoImagesLoading extends ImageAnalyzerState {}