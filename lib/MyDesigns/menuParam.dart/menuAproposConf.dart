import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuAproposConf extends StatefulWidget {
  @override
  MenuAproposConfState createState() {
    return new MenuAproposConfState();
  }
}

class MenuAproposConfState extends State<MenuAproposConf> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Terme de Confidentialité"),
      ),
      body: 
          new Container(
          child: new FutureBuilder<List<AproposConfFull>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AproposConfFull> billetsFull = snapshot.data;

                  return CustomListView(billetsFull);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return new Align(
  
                          alignment: Alignment.center,
  
                          child: new CircularProgressIndicator());
              })),
          
       
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Settings,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.Subscribe) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Subscribe,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.SignOut) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 200),
        content: Text(
          Constants.SignOut,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
  }
}

class Constants {
  static const String Subscribe = 'Go Home Page';
  static const String Settings = 'Go Another Page';
  static const String SignOut = 'Refresh Page';

  static const List<String> choices = <String>[Subscribe, Settings, SignOut];
}

class AproposConfFull {
  final String 
      messageConf;

  AproposConfFull({
    Key key,
    this.messageConf,
  });
  factory AproposConfFull.fromJson(Map<String, dynamic> jsonData) {
    return AproposConfFull(
        messageConf: jsonData['confidentialite'],
        );
  }
}

class CustomListView extends StatelessWidget {
  final List<AproposConfFull> alertFull;
  CustomListView(this.alertFull);
  Widget build(context) {
    return ListView.builder(
        itemCount: alertFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(alertFull[currentIndex], context);
        });
  }

  Widget createViewItem(AproposConfFull confFull, BuildContext context) {
    return new ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: new Card(
        elevation: 3.0,
        child: Container(   
          child: 
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical:15.0),
         child:
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:Text("SMART_TICKET",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,) ,
                            ),
                          ],
                        ),
                        Divider(),
                        
                        ListTile(
                          title: Text("${confFull.messageConf}\n",style: TextStyle(color: Colors.black),),
                          //leading: Icon(Icons.person)
                        )
                      ],
                    ),),
           
            ],
          ),
        ),
      ),
      onTap: () {
      },
    );
  }
}

Future<List<AproposConfFull>> downloadJSON() async {
  final response = await http.post(PubCon.cheminPhp + "GetConfidentialiteEse.php",body:{
  });
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List descFull = json.decode(response.body);
    return descFull
        .map((billetsFull) => new AproposConfFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
