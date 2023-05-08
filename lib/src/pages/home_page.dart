import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:qr_scanner2023/src/bloc/scanns_bloc.dart';
import 'package:qr_scanner2023/src/pages/qrcodes.dart';
import 'package:qr_scanner2023/src/pages/maps_page.dart';

import 'package:qr_scanner2023/src/models/scan_model.dart';
import 'package:qr_scanner2023/src/pages/other_page.dart';
import 'package:qr_scanner2023/src/pages/qr_generator_page.dart';
import 'package:qr_scanner2023/src/utils/extensions.dart';
import 'package:qr_scanner2023/src/utils/utils.dart' as utils;

import '../../utils/constnants.dart';
import 'barcodespage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                SizedBox(
                  width: context.width * 0.5,
                ),
                Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.plus),
                          Text("Generate a Barcode"),
                        ],
                      ),
                    )),
              ],
            )),
            Expanded(flex: 10, child: _callpage(currentPage)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBtnNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed: currentPage == 0
            ? _scanBarcode
            : () {
                print("Test");
              },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(AppConstnants.appName),
      elevation: 0,
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                child: Text("Hello"),
                value: '/hello',
              ),
              PopupMenuItem(
                child: Text("About"),
                value: '/about',
              ),
              PopupMenuItem(
                child: Text("Contact"),
                value: '/contact',
              )
            ];
          },
        ),
      ],
    );
  }

  _scanBarcode() async {
    String futureString;

    try {
      String scanned = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.BARCODE);
      futureString = scanned;
    } catch (e) {
      futureString = e.toString();
      return () {};
    }

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scansBloc.addScan(scan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
    }
  }

  Widget _callpage(int currentPage) {
    switch (currentPage) {
      case 0:
        return BarcodesPage();
      case 1:
        return QrCodesPage();

      default:
        return MapsPage();
    }
  }

  Widget _buildBtnNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      //   selectedLabelStyle: TextStyle(color: Colors.amber),
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      unselectedItemColor: Theme.of(context).primaryColor,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.barcode,
            color: Theme.of(context).primaryColor,
          ),
          label: "Barcodes",
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.qrcode,
                color: Theme.of(context).primaryColor),
            label: "Qr Codes"),
      ],
    );
  }
}
