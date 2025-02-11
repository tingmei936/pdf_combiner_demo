import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_combiner_demo/cubit/pdf_cubit.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Combiner Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<PdfCubit>().mergePdfs(),
              child: Text('Merge PDFs'),
            ),
            ElevatedButton(
              onPressed: () => context.read<PdfCubit>().createPdfFromImages(),
              child: Text('Create PDF from Images'),
            ),
            ElevatedButton(
              onPressed: () => context.read<PdfCubit>().extractImagesFromPdf(),
              child: Text('Extract Images from PDF'),
            ),
            BlocBuilder<PdfCubit, String?>(
              builder: (context, state) {
                return state != null ? Text('Output: $state') : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
