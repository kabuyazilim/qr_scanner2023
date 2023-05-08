import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:qr_scanner2023/src/models/scan_model.dart';

class BarcodesPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<BarcodesPage> {
  final map = new MapController();
  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordinates QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 14);
            },
          )
        ],
      ),
      body: bFlutterMap(scan),
      floatingActionButton: _bBtnFloting(context),
    );
  }

  _bBtnFloting(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // streets, dark, light, outdoors, satellite
        if (mapType == 'streets') {
          mapType = 'dark';
        } else if (mapType == 'dark') {
          mapType = 'light';
        } else if (mapType == 'light') {
          mapType = 'outdoors';
        } else if (mapType == 'outdoors') {
          mapType = 'satellite';
        } else {
          mapType = 'streets';
        }

        setState(() {});
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget bFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 13.5),
      children: [
        _bMap(),
        _markets(scan),
      ],
    );
  }

  _bMap() {
    return TileLayer(
        urlTemplate: "https://api.mapbox.com/v4/"
            "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
        additionalOptions: {
          'accessToken': 'your token ',
          'id': 'mapbox.$mapType',
        });
  }

  _markets(ScanModel scan) {
    return MarkerLayer(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 45.9,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }
}
