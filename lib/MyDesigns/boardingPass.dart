import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/boardingPers.dart';
import 'package:flights_app/MyDesigns/detailBoarding.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoardingPass extends StatefulWidget {
  @override
  BoardingPassState createState() {
    return new BoardingPassState();
  }
}

class BoardingPassState extends State<BoardingPass> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Boarding_Pass"),
      ),
      body: 
      //ListView(
      //   padding: EdgeInsets.all(0.0),
      //   children: <Widget>[
      //     ColoredCard(
      //       padding: 0.0,
      //       headerColor: Colors.blue,
      //       footerColor: Colors.blueAccent,
      //       cardHeight: 180,
      //       elevation: 2,
      //       bodyColor: Colors.lightBlueAccent,
      //       showFooter: true,
      //       showHeader: true,
            
      //       bodyGradient: LinearGradient(
      //         colors: [
      //           Color(0xFF55affd).withOpacity(1),
      //           Color(0xFF6b8df8),
      //           Color(0xFF887ef1),
      //         ],
      //         begin: Alignment.bottomLeft,
      //         end: Alignment.topRight,
      //         stops: [0, 0.2, 1],
      //       ),
      //       headerBar: HeaderBar(
      //           title: Text(
      //             "MES BILLETS",
      //             style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 16,
      //                 fontFamily: "Poppins"),
      //           ),
      //           leading: IconButton(
      //             icon: Icon(
      //               Icons.refresh,
      //               color: Colors.white,
      //             ),
      //             onPressed: () {
      //               Scaffold.of(context).showSnackBar(SnackBar(
      //                 content: Text('Hello!'),
      //               ));
      //             },
      //           ),
      //           action: PopupMenuButton<String>(
      //             icon: Icon(Icons.menu),
      //             onSelected: choiceAction,
      //             itemBuilder: (BuildContext context) {
      //               return Constants.choices.map((String choice) {
      //                 return PopupMenuItem<String>(
      //                   value: choice,
      //                   child: Text(choice),
      //                 );
      //               }).toList();
      //             },
      //           )),
      //       bodyContent: Padding(
      //         padding: const EdgeInsets.all(
      //         10.0
               
      //         ),
      //         child: ListView(
      //           // mainAxisAlignment: MainAxisAlignment.start,
      //           // crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             Text(
      //               "Consulter mes billets pour les prochains voyages",
      //               style: TextStyle(
      //                   fontWeight: FontWeight.w500,
      //                   fontSize: 17,
      //                   color: Colors.white,
      //                   fontFamily: "Poppins"),
      //             ),
      //             SizedBox(
      //               height: 30,
      //             ),
                  
      //           ],
      //         ),
      //       ),
      //       footerBar: FooterBar(
      //         title: Text(
      //           "VOYAGES A VENIR",
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 16,
      //               fontFamily: "Poppins"),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
          new Container(
          child: new FutureBuilder<List<BilletsFull>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BilletsFull> billetsFull = snapshot.data;

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

class BilletsFull {
  final String refReservation;
  final String lieuDepart,
      lieuArret,
      heureDepart,
      heureArrive,
      nombrePersonne,
      dateVoyage;

  BilletsFull({
    Key key,
    this.refReservation,
    this.lieuDepart,
    this.lieuArret,
    this.heureDepart,
    this.heureArrive,
    this.nombrePersonne,
    this.dateVoyage,
  });
  factory BilletsFull.fromJson(Map<String, dynamic> jsonData) {
    return BilletsFull(
        refReservation: jsonData['refRservation'],
        lieuDepart: jsonData['LieuDepart'],
        lieuArret: jsonData['LieuArret'],
        heureDepart: jsonData['heureDepart'],
        heureArrive: jsonData['heureArrive'],
        nombrePersonne: jsonData['nombrePersonne'],
        dateVoyage: jsonData['dateVoyage'],
        );
  }
}

class CustomListView extends StatelessWidget {
  final List<BilletsFull> billetFull;
  CustomListView(this.billetFull);
  Widget build(context) {
    return ListView.builder(
        itemCount: billetFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(billetFull[currentIndex], context);
        });
  }

  Widget createViewItem(BilletsFull billetFull, BuildContext context) {
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
                              child:Text("${billetFull.dateVoyage}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,) ,
                            ),
                            Expanded(
                              child: Text("# ${billetFull.refReservation}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
      child: Column(
        children: <Widget>[
              Text('${billetFull.lieuDepart}', style: TextStyle(fontSize: 16.0),),
              SizedBox(height: 8.0,),
              Text('${billetFull.heureDepart}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),
    Icon(Icons.navigate_next),
                            //Text("--->"),
Expanded(
      child: Column(
        children: <Widget>[
              
              Text('${billetFull.lieuArret}', style: TextStyle(fontSize: 16.0),),
              SizedBox(height: 8.0,),
              Text('${billetFull.heureArrive}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),

                          ],
                        ),
                        ListTile(
                          title: Text("${billetFull.nombrePersonne} passager(s)",style: TextStyle(color: Colors.blue),),
                          leading: Icon(Icons.person)
                        )
                      ],
                    ),),
           
            ],
          ),
        ),
      ),
      onTap: () {
        //create a detail page
        //
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new BoardingPassPers(refReservation: billetFull.refReservation
              ),
        );

        Navigator.of(context).push(route);
      },
    );
  }
}

Future<List<BilletsFull>> downloadJSON() async {
  //final jsonEndpoint = PubCon.cheminPhp + "GetHistoriqueVoyageFuture.php";
  final response = await http.post(PubCon.cheminPhp + "GetHistoriqueVoyageFuture.php",body:{
    "refCompte":PubCon.userId.toString()
  });
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List billetsFull = json.decode(response.body);
    return billetsFull
        .map((billetsFull) => new BilletsFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
