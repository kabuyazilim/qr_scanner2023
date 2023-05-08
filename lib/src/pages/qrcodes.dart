import 'package:flutter/material.dart';
import 'package:qr_scanner2023/src/bloc/scanns_bloc.dart';
import 'package:qr_scanner2023/src/models/scan_model.dart';

import 'package:qr_scanner2023/src/utils/utils.dart' as utils;

class QrCodesPage extends StatelessWidget {
  final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scanBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scanStreamHttp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No information'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Center(
                child: Text('Delete',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0)),
              ),
            ),
            onDismissed: (direction) => scanBloc.deletScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.http, color: Theme.of(context).primaryColor),
              title: Text(scans[i].value),
              subtitle: Text('ID DB: ${scans[i].id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => utils.openScan(context, scans[i]),
            ),
          ),
        );
      },
    );
  }
}
