import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdoctor/main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';

class VideoRecord extends StatefulWidget {
  @override
  _VideoRecordState createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
  File videoFile;
  String _locationMessage = "";
  String address = "";
  DateTime now = DateTime.now();
  String formattedDate = "";
  //DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

  _record() async {
    File theVid = await ImagePicker.pickVideo(source: ImageSource.camera);
    if (theVid != null) {
      if (!mounted) {
        return;
      }

      setState(() {
        videoFile = theVid;
      });
    }
  }

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    var placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    address =
        '${placemarks.first.name.isNotEmpty ? placemarks.first.name + ', ' : ''}${placemarks.first.thoroughfare.isNotEmpty ? placemarks.first.thoroughfare + ', ' : ''}${placemarks.first.subLocality.isNotEmpty ? placemarks.first.subLocality + ', ' : ''}${placemarks.first.locality.isNotEmpty ? placemarks.first.locality + ', ' : ''}${placemarks.first.subAdministrativeArea.isNotEmpty ? placemarks.first.subAdministrativeArea + ', ' : ''}${placemarks.first.postalCode.isNotEmpty ? placemarks.first.postalCode + ', ' : ''}${placemarks.first.administrativeArea.isNotEmpty ? placemarks.first.administrativeArea : ''}';
    formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
    setState(() {
      _locationMessage = "${position.latitude},${position.longitude}";
      address;
      formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Container(
                color: Colors.brown,
                height: MediaQuery.of(context).size.height * (50 / 100),
                width: MediaQuery.of(context).size.width * (100 / 100),
                child: videoFile == null
                    ? Center(
                        child: Icon(
                          Icons.videocam,
                          color: Colors.red,
                          size: 50.0,
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: mounted
                            ? Stack(children: <Widget>[
                                Chewie(
                                  controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(videoFile),
                                    aspectRatio: 2 / 2,
                                    autoPlay: true,
                                    looping: true,
                                  ),
                                ),
                                Positioned(
                                    bottom: 10, left: 4, child: Text(address))
                              ])
                            : Container(),
                      ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                _locationMessage,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(14.0),
                child: Text(
                  address,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(12.0),
                child: Text(
                  formattedDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Record'),
                    Icon(Icons.videocam),
                  ],
                ),
                onPressed: () {
                  _getCurrentLocation();
                  _record();
                },
              ),
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                color: Colors.red,
                child: Text("Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
