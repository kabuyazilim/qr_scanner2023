import 'dart:async';

import 'package:qr_scanner2023/src/bloc/validator.dart';
import 'package:qr_scanner2023/src/models/scan_model.dart';
import 'package:qr_scanner2023/src/provider/db_provider.dart';

class ScansBloc with Validator {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream =>
      _scansController.stream.transform(getGeo);
  Stream<List<ScanModel>> get scanStreamHttp =>
      _scansController.stream.transform(getHttp);
  Stream<List<ScanModel>> get scanStreamOther =>
      _scansController.stream.transform(getOther);

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  deletScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  // deleteAll() async {
  //   DBProvider.db.deleteAllScan();
  //   getScans();
  // }
}
