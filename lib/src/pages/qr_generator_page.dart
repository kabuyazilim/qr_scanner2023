import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerator extends StatefulWidget {
  
  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  String data = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 16,),
            TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: 'Qr code generate',
              labelText: 'Insert or paste text ',
              suffixIcon: Icon(FontAwesomeIcons.textWidth),
              ),
             onChanged: (value) => setState(() {data = value;}),
    ),
            
            SizedBox(height: 8,),

            Center(
              child: QrImage(
                data: data,
                gapless: true,
                size: 250,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
              ),
            )
          ],
        ),
      
    );
  }
}