import 'package:pdf_combiner/pdf_combiner.dart';
import 'package:pdf_combiner/responses/image_from_pdf_response.dart';
import 'package:pdf_combiner/responses/merge_multiple_pdf_response.dart';
import 'package:pdf_combiner/responses/pdf_from_multiple_image_response.dart';

class PdfRepository {
  Future<MergeMultiplePDFResponse> mergePDFs(
      List<String> filesPath, String outputPath) async {
    return await PdfCombiner.mergeMultiplePDFs(
        inputPaths: filesPath, outputPath: outputPath);
  }

//
  Future<PdfFromMultipleImageResponse> createPdfFromImages(
      List<String> imagePaths, String outputPath) async {
    return await PdfCombiner.createPDFFromMultipleImages(
        inputPaths: imagePaths,
        outputPath: outputPath,
        maxWidth: 480,
        maxHeight: 640,
        needImageCompressor: false);
  }

  Future<ImageFromPDFResponse> extractImagesFromPdf(
      String pdfPath, String outputPath) async {
    return await PdfCombiner.createImageFromPDF(
      inputPath: pdfPath,
      outputPath: outputPath,
      createOneImage: false,
    );
  }
}
