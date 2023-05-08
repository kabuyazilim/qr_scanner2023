import 'package:flutter/material.dart';
import 'package:qr_scanner2023/src/models/scan_model.dart';

import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    if (await canLaunchUrl(Uri.parse(scan.value!))) {
      await launchUrl(Uri.parse(scan.value!));
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else if (scan.type == 'geo') {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
