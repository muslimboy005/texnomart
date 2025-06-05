


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:texnomartoriginal/data/api/stores/stores_data.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'components/app_lat_long.dart';
import 'components/location_service.dart';



class AllStoresPage extends StatefulWidget {
  // const AllStoresPage({super.key});

  List<StoresData> list;


  AllStoresPage(this.list);

  @override
  State<AllStoresPage> createState() => _AllStoresPageState();
}

class _AllStoresPageState extends State<AllStoresPage> {

  final mapControllerCompleter = Completer<YandexMapController>();
  final List<MapObject> mapObjects = [];


  void getBranches() async {

    print('---------------------------------');
    print(widget.list.length);

    // for (int i = 0; i<widget.list.length;i++) {
    //
    //   mapObjects.add(PlacemarkMapObject(
    //       mapId: MapObjectId('${i}'),
    //       text: PlacemarkText(text: "${widget.list[i].name}",
    //           style: PlacemarkTextStyle(size: 12,placement: TextStylePlacement.bottom)),
    //
    //       point: Point(
    //           latitude: double.parse(widget.list[i].lat.toString()),
    //           longitude: double.parse(widget.list[i].long.toString()))));
    // }

    for (var o in widget.list) {
      mapObjects.add(PlacemarkMapObject(
          mapId: MapObjectId('${o.region}'),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              scale: 0.6,
              image: BitmapDescriptor.fromAssetImage('assets/images/location_icon.png')
          )),
          point: Point(
              latitude: double.parse(o.lat.toString()),
              longitude: double.parse(o.long.toString()))));
    }
  }





  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }
  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
  }

  @override
  void initState() {


    _initPermission();

    // _moveToCurrentLocation(  double.parse(widget.list[0].lat.toString()),
    //    double.parse(widget.list[0].long.toString()),);

    getBranches();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: YandexMap(
            onMapCreated: (controller) {
              mapControllerCompleter.complete(controller);
            },
            onMapTap: (point) {
              print(point.latitude);
            },

            onObjectTap: (geoObject) {
              print(geoObject.name);
            },
            zoomGesturesEnabled: true,


          mapObjects: mapObjects,
        )
    );
  }
}


