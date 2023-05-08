import 'package:flutter/material.dart';
import 'package:qr_scanner2023/src/pages/home_page.dart';
import 'package:qr_scanner2023/src/pages/barcodespage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(8, 71, 152, 1.0),
      ),
      title: 'Qr&Barcode Scanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'barcodes': (BuildContext context) => BarcodesPage(),
      },
    );
  }
}
