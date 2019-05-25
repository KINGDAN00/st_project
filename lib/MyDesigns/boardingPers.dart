import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/detailBoarding.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoardingPassPers extends StatefulWidget {
  final String refReservation;

  const BoardingPassPers({Key key, this.refReservation}) : super(key: key);
  @override
  BoardingPassPersState createState() {
    return new BoardingPassPersState();
  }
}

class BoardingPassPersState extends State<BoardingPassPers> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Detail Boarding_Pass"),
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
          child: new FutureBuilder<List<BilletsPersFull>>(
              future: downloadJSON(widget.refReservation),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<BilletsPersFull> billetsFull = snapshot.data;

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

class BilletsPersFull {
  final String refDetReserv;
  final String 
      nomsPers,
      dateVoyage;

  BilletsPersFull({
    Key key,
    this.refDetReserv,
    this.nomsPers,
    this.dateVoyage,
  });
  factory BilletsPersFull.fromJson(Map<String, dynamic> jsonData) {
    return BilletsPersFull(
        refDetReserv: jsonData['codeDetailRes'],
        nomsPers: jsonData['nomClient_billet']+' '+jsonData['LastNameClient_billet'],
        dateVoyage: jsonData['dateVoyage'],
        );
  }
}

class CustomListView extends StatelessWidget {
  final List<BilletsPersFull> billetFull;
  CustomListView(this.billetFull);
  Widget build(context) {
    return ListView.builder(
        itemCount: billetFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(billetFull[currentIndex], context);
        });
  }

  Widget createViewItem(BilletsPersFull billetFull, BuildContext context) {
    return new ListTile(
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
                              child: Text("# ${billetFull.refDetReserv}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                        Divider(),
                        
                        ListTile(
                          title: Text("${billetFull.nomsPers}",style: TextStyle(color: Colors.blue),),
                          leading: Icon(Icons.person)
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
              new DetailBoarding(refDetReserv: billetFull.refDetReserv
              ),
        );

        Navigator.of(context).push(route);
      },
    );
  }
}

Future<List<BilletsPersFull>> downloadJSON(String refReservation1) async {
  final response = await http.post(PubCon.cheminPhp + "GetDetailSelonReservation.php",body:{
    "refRservation":refReservation1
  });
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List billetsFull = json.decode(response.body);
    return billetsFull
        .map((billetsFull) => new BilletsPersFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
