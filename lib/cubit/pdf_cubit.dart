import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_combiner/responses/pdf_combiner_status.dart';
import 'package:pdf_combiner_demo/repository/pdf_repository.dart';

class PdfCubit extends Cubit<String?> {
  final PdfRepository repository;
  PdfCubit(this.repository) : super(null);

  Future<String> getOutputPath(String fileName) async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/$fileName';
  }

  Future<void> mergePdfs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      String outputPath = await getOutputPath("merged.pdf");
      var response = await repository.mergePDFs(
          result.paths.whereType<String>().toList(), outputPath);
      if (response.status == PdfCombinerStatus.success) {
        emit(response.response);
        OpenAppFile.open(response.response!);
      }
    }
  }

  Future<void> createPdfFromImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isEmpty) {
      print("No se seleccionaron imágenes.");
      return;
    }

    List<String> imagePaths = images.map((image) => image.path).toList();
    print("Imágenes seleccionadas: $imagePaths");

    String outputPath = await getOutputPath("images.pdf");

    var response = await repository.createPdfFromImages(imagePaths, outputPath);
    if (response.status == PdfCombinerStatus.success) {
      emit(response.response);
      OpenAppFile.open(response.response!);
    } else {
      print("Error al crear PDF: ${response.status}");
    }
  }

  Future<void> extractImagesFromPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null && result.files.isNotEmpty) {
        String outputPath = await getOutputPath("extracted_images");
        Directory(outputPath).createSync(recursive: true);
        var response = await repository.extractImagesFromPdf(
            result.files.first.path!, outputPath);
        if (response.status == PdfCombinerStatus.success) {
          emit(response.response?.join("\n"));
          OpenAppFile.open(outputPath);
        }
      }
    } catch (e) {
      print('error ; $e');
    }
  }
}
