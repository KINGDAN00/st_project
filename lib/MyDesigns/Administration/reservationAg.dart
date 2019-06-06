//import 'dart:io';

import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyDesigns/tab_aller_retour.dart';
import 'package:flutter/material.dart';

class MyHomePageScreenAg extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<MyHomePageScreenAg> {
//MyPreferences _myPreferences=MyPreferences();

  @override
  Widget build(BuildContext context) {
    //initialisation par les donnees en memoire
//     PubCon.userId=_myPreferences.iduser==""? '-1' :_myPreferences.iduser;
//     PubCon.userName=_myPreferences.user==""? 'sTicket' : _myPreferences.user;
// PubCon.userNomComplet=_myPreferences.nomcomplet==""?'Smart Ticket':_myPreferences.nomcomplet;
// PubCon.userPass=_myPreferences.password;
// PubCon.userPrivilege=_myPreferences.privilege==""?'0': _myPreferences.privilege;
// PubCon.userImage=_myPreferences.image==""?"":_myPreferences.image;
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: GestureDetector(
            child: new Text("SMART TICKET"),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          
        ),
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: buildGrid(context),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue[600],
                                Colors.blue[500],
                                Colors.blue,
                                Colors.blue[400],
                                Colors.blue[300]
                              ])),
                      margin: EdgeInsets.only(left: 12, right: 12),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget buildGrid(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (MediaQuery.of(context).size.width - 60 / 3) / 300,
      children: <Widget>[
        buildTile(context, 0, "BATEAU", null, Icons.directions_boat, "O items",
            Colors.orange, Colors.orange[50]),
        buildTile(context, 1, "BUS", null, Icons.directions_bus, "O items",
            Colors.blue, Colors.blue[50]),
        buildTile(context, 2, "AVION", null, Icons.local_airport, "0 items",
            Colors.purple, Colors.purple[50]),
        buildTile(context, 3, "TAXI", null, Icons.local_taxi, "0 items",
            Colors.red, Colors.red[50]),
      ],
    );
  }

  int _selectedIndex = -1;

  Widget buildTile(BuildContext context, int index, String heading, Image image,
      IconData icon, String itemCount, Color color, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.only(
          left: index == 0 || index == 2 || index == 4 ? 12 : 5,
          top: 0,
          right: index == 1 || index == 3 || index == 5 ? 12 : 5,
          bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              CritereSelect.refCatEngin = 1;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabAllerRetour()));
            } else if (_selectedIndex == 1) {
              CritereSelect.refCatEngin = 2;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabAllerRetour()));
            } else if (_selectedIndex == 2) {
              CritereSelect.refCatEngin = 3;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabAllerRetour()));
            } else if (_selectedIndex == 3) {
              CritereSelect.refCatEngin = 4;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabAllerRetour()));
            }
          });
          print("tapped");
        },
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: _selectedIndex == index && color != null
                        ? color
                        : Colors.white),
                borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    index == 4
                        ? IconButton(
                            icon: image,
                            onPressed: () {},
                          )
                        : Icon(
                            icon,
                            color: color,
                            size: 30.0,
                          ),
                    index != 1
                        ? SizedBox(
                            height: 4,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
                Text(
                  heading,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  itemCount,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                )
              ],
            ))),
      ),
//      ),
    );
  }
}
