import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_combiner/responses/pdf_combiner_status.dart';
import 'package:pdf_combiner_demo/repository/pdf_repository.dart';

class PdfCubit extends Cubit<String?> {
  final PdfRepository repository;
  PdfCubit(this.repository) : super(null);

  Future<void> mergePdfs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      String outputPath = "/path/to/output/merged.pdf";
      var response = await repository.mergePDFs(
          result.paths.whereType<String>().toList(), outputPath);
      if (response.status == PdfCombinerStatus.success) emit(response.response);
    }
  }

  Future<void> createPdfFromImages() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      String outputPath = "/path/to/output/images.pdf";
      var response = await repository.createPdfFromImages(
          result.paths.whereType<String>().toList(), outputPath);
      if (response.status == PdfCombinerStatus.success) emit(response.response);
    }
  }

  Future<void> extractImagesFromPdf() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      String outputPath = "/path/to/output/images/";
      var response = await repository.extractImagesFromPdf(
          result.files.first.path!, outputPath);
      if (response.status == PdfCombinerStatus.success) {
        emit(response.response?.join("\n"));
      }
    }
  }
}
