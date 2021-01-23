import 'package:geolocator/geolocator.dart';
import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "dart:async";


CameraPosition currentLoc;
List<Marker> markersList=[Marker(markerId: MarkerId("testing"))];



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


class selectLocation extends StatefulWidget {


  @override
  _selectLocationState createState() => _selectLocationState();
}

class _selectLocationState extends State<selectLocation> {

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
                  target: LatLng(snapshot.data.latitude,snapshot.data.longitude),
                  zoom: 10,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller){
                  setState(() {
                    markersList=[Marker(markerId: MarkerId("location"), position: LatLng(snapshot.data.latitude,snapshot.data.longitude) )];
                  });
                  _controller.complete(controller);
                },
                onTap: (location){
                  setState(() {
                    markersList=[];
                    markersList.add(
                        Marker(markerId: MarkerId("location"), position: location)
                    );
                  });

                },
                markers: Set.from(markersList)

            ),
          );
        }
        else{
          return SafeArea(child: Scaffold(body: Center(child: Text("LOADING"))));
        }
      }
    );
  }
}
