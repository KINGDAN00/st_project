import 'package:flights_app/load/loader2.dart';
import 'package:flutter/material.dart';

class LoadersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loaders"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            LoaderTwo(),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}