import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/detailAlert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAlert extends StatefulWidget {
  @override
  MyAlertState createState() {
    return new MyAlertState();
  }
}

class MyAlertState extends State<MyAlert> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Alert"),
      ),
      body: 
          new Container(
          child: new FutureBuilder<List<AlertFull>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AlertFull> billetsFull = snapshot.data;

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

class AlertFull {
  final String idAlert;
  final String 
      messageAlert,
      date_pub,
      nomAgence;

  AlertFull({
    Key key,
    this.idAlert,
    this.messageAlert,
    this.date_pub,
    this.nomAgence,
  });
  factory AlertFull.fromJson(Map<String, dynamic> jsonData) {
    return AlertFull(
        idAlert: jsonData['id'],
        messageAlert: jsonData['message'],
        nomAgence: jsonData['nomAgence'],
        date_pub: jsonData['date_pub']
        );
  }
}

class CustomListView extends StatelessWidget {
  final List<AlertFull> alertFull;
  CustomListView(this.alertFull);
  Widget build(context) {
    return ListView.builder(
        itemCount: alertFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(alertFull[currentIndex], context);
        });
  }

  Widget createViewItem(AlertFull alertFull, BuildContext context) {
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
                              child:Text("AGENCE ${alertFull.nomAgence}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,) ,
                            ),
                             Text("# ${alertFull.idAlert}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                            
                          ],
                        ),
                        Divider(),
                        
                        ListTile(
                          title: Text("${alertFull.messageAlert}\n",style: TextStyle(color: Colors.black),),
                          subtitle: Text("${alertFull.date_pub}"),
                          //leading: Icon(Icons.person)
                        )
                      ],
                    ),),
           
            ],
          ),
        ),
      ),
      onTap: () {
        //create a new page
        //
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Commentaires(refAlert: alertFull.idAlert
              ),
        );

        Navigator.of(context).push(route);
      },
    );
  }
}

Future<List<AlertFull>> downloadJSON() async {
  final response = await http.post(PubCon.cheminPhp + "GetAlerteAgence.php",body:{
  });
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List billetsFull = json.decode(response.body);
    return billetsFull
        .map((billetsFull) => new AlertFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
