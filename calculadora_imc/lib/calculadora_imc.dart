import 'package:calculadora_imc/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//stl
class CalculadoraImc extends StatelessWidget {
  const CalculadoraImc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 9, 151, 16)),
            useMaterial3: true,
            textTheme: GoogleFonts.robotoMonoTextTheme()),
        home: const MainPage());
  }
}
