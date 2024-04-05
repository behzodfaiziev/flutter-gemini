part of 'image_analyzer_view.dart';

mixin ImageAnalyzerMixin on State<ImageAnalyzerView> {
  Uint8List? firstImageBytes;
  Uint8List? secondImageBytes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ImageAnalyzerBloc>().add(InitializeGemini());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void pickSecondImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      secondImageBytes = await pickedFile.readAsBytes();
      setState(() {});
    }
  }

  void pickFirstImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      firstImageBytes = await pickedFile.readAsBytes();
      setState(() {});
    }
  }
}
