import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

Future<bool> callPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.locationAlways,
    Permission.storage,
  ].request();

  if (statuses.values.every((element) => element.isGranted)) {
    return true;
  }

  return false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '권한을 주세요',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: callPermissions(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data) {
                
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
