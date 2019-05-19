import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/categorie_charge.dart';
import 'package:flights_app/MyDesigns/Administration/engin_charge.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
Widget buildGrid(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (MediaQuery.of(context).size.width - 60 / 2) / 300,
      children: <Widget>[
        buildTile(context, 0, "AGENCE", null, Icons.terrain, "O items",
            Colors.orange, Colors.orange[50]),
        buildTile(context, 1, "ENGIN", null, Icons.pan_tool, "O items",
            Colors.blue, Colors.blue[50]),
        buildTile(context, 2, "CLASSES", null, Icons.sort, "0 items",
            Colors.purple, Colors.purple[50]),
        buildTile(context, 3, "HORAIRE", null, Icons.calendar_view_day, "0 items",
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(menu: "agence")));
            }
            else if (_selectedIndex == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(menu: "engin")));
            }
            else if (_selectedIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NosEngins(menu: "classe",)));
            }
            else if (_selectedIndex == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NosEngins(menu: "horaire",)));
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text("${PubCon.userNomComplet}",style: TextStyle(color: Colors.blueAccent),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
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
        ),
    );
  }
}