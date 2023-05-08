import 'dart:async';

import 'package:qr_scanner2023/src/models/scan_model.dart';

class Validator {
  final getGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.type == 'geo').toList();
    sink.add(geoScans);
  });

  final getHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.type == 'http').toList();
    sink.add(geoScans);
  });

  final getOther =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.toList();
    sink.add(geoScans);
  });
}
