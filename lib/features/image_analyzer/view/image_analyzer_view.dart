import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/core/extensions/context_extension.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/image_analyzer_bloc.dart';

part 'image_analyzer_mixin.dart';

class ImageAnalyzerView extends StatefulWidget {
  const ImageAnalyzerView({super.key});

  @override
  State<ImageAnalyzerView> createState() => _ImageAnalyzerViewState();
}

class _ImageAnalyzerViewState extends State<ImageAnalyzerView>
    with ImageAnalyzerMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Analyzer'),
      ),
      body: BlocListener<ImageAnalyzerBloc, ImageAnalyzerState>(
        listener: (context, state) {
          if (state is CompareTwoImagesError) {
            context.showSnackBar(state.error);
          }
        },
        child: Column(
          children: [
            if (firstImageBytes != null) imagePreview(firstImageBytes),
            if (secondImageBytes != null) imagePreview(secondImageBytes),
            Expanded(
              child: BlocBuilder<ImageAnalyzerBloc, ImageAnalyzerState>(
                builder: (context, state) {
                  if (state is CompareTwoImagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CompareTwoImagesResponse) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(state.response),
                    );
                  }
                  return const SizedBox(height: 20);
                },
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter, child: buildButtons()),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ImageAnalyzerBloc, ImageAnalyzerState>(
        builder: (context, state) {
          return FloatingActionButton(
            child: const Icon(Icons.compare),
            onPressed: () {
              context.read<ImageAnalyzerBloc>().add(CompareTwoImages(
                  image1: firstImageBytes, image2: secondImageBytes));
            },
          );
        },
      ),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 140),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: pickFirstImage,
              child: Text('Select First Image', style: buildTextStyle()),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: pickSecondImage,
              child: Text('Select Second Image', style: buildTextStyle()),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget imagePreview(Uint8List? imageBytes) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.memory(imageBytes!)),
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(color: Colors.black);
  }
}
