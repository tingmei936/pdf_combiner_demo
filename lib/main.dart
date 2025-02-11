import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_combiner_demo/cubit/pdf_cubit.dart';
import 'package:pdf_combiner_demo/repository/pdf_repository.dart';
import 'package:pdf_combiner_demo/view/pdf_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Combiner Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => PdfCubit(PdfRepository()),
        child: PdfScreen(),
      ),
    );
  }
}
