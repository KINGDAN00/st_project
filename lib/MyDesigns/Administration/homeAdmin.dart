import 'package:flights_app/Home/home_screen.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/categorie_charge.dart';
import 'package:flights_app/MyDesigns/Administration/codeArgent.dart';
import 'package:flights_app/MyDesigns/Administration/engin_charge.dart';
import 'package:flights_app/MyDesigns/Administration/publicationAdm.dart';
//import 'package:flights_app/MyDesigns/Administration/rapportAgence.dart';
import 'package:flights_app/MyDesigns/Administration/reservationAg.dart';
import 'package:flights_app/MyDesigns/Administration/updateAgence.dart';
import 'package:flights_app/MyDesigns/scanQR.dart';
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
        buildTile(context, 3, "HORAIRE", null, Icons.calendar_view_day,
            "0 items", Colors.red, Colors.red[50]),
        buildTile(
            context,
            5,
            "RESERVATION",
            null,
            Icons.transfer_within_a_station,
            "0 items",
            Colors.red,
            Colors.red[50]),
        buildTile(context, 6, "RAPPORTS", null, Icons.report, "0 items",
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
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(menu: "agence")));

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateAgence()));
            } else if (_selectedIndex == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories(menu: "engin")));
            } else if (_selectedIndex == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NosEngins(
                            menu: "classe",
                          )));
            } else if (_selectedIndex == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NosEngins(
                            menu: "horaire",
                          )));
            } else if (_selectedIndex == 5) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePageScreenAg()));
            } else if (_selectedIndex == 6) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NosEngins(
                            menu: 'rapport',
                          )));

              // showDialog(
              //     context: context,
              //     builder: (context) => new AlertDialog(
              //           title: new Text("Trier par :"),
              //           content: new Container(
              //               height: MediaQuery.of(context).size.height / 2,
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   Card(
              //                     child: ListTile(
              //                       title: Text("Engin"),
              //                       subtitle: Text("gains par engin"),
              //                       leading: Icon(Icons.sort),
              //                       onTap: () {
              //                         Navigator.push(
              //                             context,
              //                             MaterialPageRoute(
              //                                 builder: (context) => NosEngins(
              //                                       menu: 'rapport',
              //                                     )));
              //                         //Navigator.pop(context);
              //                       },
              //                     ),
              //                   ),
              //                   Divider(),
              //                   Card(
              //                     child: ListTile(
              //                       title: Text("Classe"),
              //                       subtitle: Text("gains par classe"),
              //                       leading: Icon(Icons.sort),
              //                       onTap: () {},
              //                     ),
              //                   )
              //                 ],
              //               )),
              //         ));
            }
          });
          //print("tapped");
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
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          "${PubCon.userNomComplet}",
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: <Widget>[
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.chat,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => MyPublication()));
                  }),
              // new CircleAvatar(
              //   radius: 8.0,
              //   backgroundColor: Colors.blue,
              //   child: new Text(
              //     "0",
              //     style: new TextStyle(color: Colors.white, fontSize: 12.0),
              //   ),
              // )
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onPressed: () {
              PubCon.userPrivilege = '0';
              Navigator.of(context).pushReplacement(
                new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return new MyHomePageScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
//============================================================================================================
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        //aller à Scanner

                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => QRscanner()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              'QrCode',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 45),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                              child: Icon(
                            Icons.scanner,
                            textDirection: TextDirection.ltr,
                            color: Colors.white,
                            size: 30.0,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //=============================NFC=====================================
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        //aller NFC

                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (ctx) => QRscanner()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              'NFS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 45),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                              child: Icon(
                            Icons.nfc,
                            textDirection: TextDirection.ltr,
                            color: Colors.white,
                            size: 32.0,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //=======================================================================================
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        //aller à Scanner

                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => CodeArgent()));
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Code Argent',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 45),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                              child: Icon(
                            Icons.credit_card,
                            textDirection: TextDirection.ltr,
                            color: Colors.white,
                            size: 32.0,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //SizedBox(height: 100),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
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
