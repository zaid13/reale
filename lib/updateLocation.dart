import 'package:geolocator/geolocator.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "dart:async";


CameraPosition currentLoc;
List<Marker> updatedMarkersList=[Marker(markerId: MarkerId("testing"))];



CameraPosition pakistan = CameraPosition(
  target: LatLng(30,69),
  zoom: 6.4746,
);




fetchYourLocation() async{

  Position position;
  try{
    print("FETCHING");
    LocationPermission permission = await requestPermission();
    position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  catch(e){
    print(e);
  }

  print("FETCHED");
  return position;
}

Completer<GoogleMapController> _controller = Completer();


class updateLocation extends StatefulWidget {

  final x;
  final y;
  updateLocation(this.x,this.y);

  @override
  _updateLocationState createState() => _updateLocationState();
}

class _updateLocationState extends State<updateLocation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: fetchYourLocation(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Container(
              height: 400,
              child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                         double.parse(widget.x),
                         double.parse(widget.y)
                    ),
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller){
                    setState(() {
                      updatedMarkersList=[
                        Marker(
                            markerId: MarkerId("location"),
                          position: LatLng(
                              double.parse(widget.x),
                              double.parse(widget.y)
                          ),
                        )
                      ];
                    });
                    _controller.complete(controller);
                  },
                  onTap: (location){
                    setState(() {
                      updatedMarkersList=[];
                      updatedMarkersList.add(
                          Marker(markerId: MarkerId("location"), position: location)
                      );
                    });

                  },
                  markers: Set.from(updatedMarkersList)

              ),
            );
          }
          else{
            return Text("LOADING");
          }
        }
    );
  }
}
