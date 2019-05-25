import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/engin_charge.dart';
import 'package:flights_app/MyDesigns/Administration/engin_horaire.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'dart:convert';

class NosHoraires extends StatefulWidget {
  final NosEnginsFull value;

  const NosHoraires({Key key, this.value}) : super(key: key);

  @override
  NosHorairesState createState() {
    return new NosHorairesState();
  }
}

class NosHorairesState extends State<NosHoraires> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("${widget.value.designationEngin}"),
      ),


floatingActionButton: new FloatingActionButton(
        onPressed: (){
          var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Horaire(action: "insert",refEngin: "${widget.value.codeEngin}",),
        );
        Navigator.of(context).push(route);
        },
        tooltip: 'Ajouter',
        child: Icon(Icons.playlist_add),
      ),



      body: new Container(
          child: new FutureBuilder<List<NosHorairesFull>>(
              future: downloadJSON('${widget.value.codeEngin}'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NosHorairesFull> billetsFull = snapshot.data;

                  return CustomListView(billetsFull,'${widget.value.codeEngin}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Align(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator());
              })),
    );
  }
}

class NosHorairesFull {
  final String codeH;
  final String jourH,
      typeCourseH,
      lieuDepH,lieuArriveH,
      heureDepH,heureArriveH,
      refEngin
      ;

  NosHorairesFull({
    Key key,
    this.codeH,
    this.jourH,
    this.typeCourseH,
    this.heureArriveH,
    this.heureDepH,
    this.lieuArriveH,
    this.lieuDepH,
    this.refEngin
  });
  factory NosHorairesFull.fromJson(Map<String, dynamic> jsonData) {
    return NosHorairesFull(
      codeH: jsonData['codeHoraire'],
      jourH: jsonData['Jours'],
      typeCourseH: jsonData['typeCourse'],
      lieuDepH: jsonData['LieuDepart'],
      lieuArriveH: jsonData['LieuArret'],
      heureDepH: jsonData['heureDepart'],
      heureArriveH: jsonData['heureArrive'],
      refEngin: jsonData['refEngin']
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<NosHorairesFull> horaireFull;
  final String codeEngin;
  CustomListView(this.horaireFull, this.codeEngin);
  Widget build(context) {
    return ListView.builder(
        itemCount: horaireFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(horaireFull[currentIndex], context,codeEngin);
        });
  }

  Widget createViewItem(NosHorairesFull horaireFull, BuildContext context,String codeEngin) {
    return new ListTile(
      contentPadding: EdgeInsets.all(1.0),
      title: 
      Card(
        elevation: 3.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
      child: Column(
        children: <Widget>[
              Text('${horaireFull.lieuDepH}', style: TextStyle(fontSize: 16.0),),
              SizedBox(height: 8.0,),
              Text('${horaireFull.heureDepH}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),
    Icon(Icons.navigate_next),
                            //Text("--->"),
Expanded(
      child: Column(
        children: <Widget>[
              
              Text('${horaireFull.lieuArriveH}', style: TextStyle(fontSize: 16.0),),
              SizedBox(height: 8.0,),
              Text('${horaireFull.heureArriveH}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),

                          ],
                        ),
                        ListTile(
                          title: Text("${horaireFull.typeCourseH} : ${horaireFull.jourH}",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                          
                        )
                      ],
                    ),),
      
            
            ],
          ),
            
        ),
      ),
      onTap: () {
var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Horaire(value: horaireFull,action: "update",refEngin: "$codeEngin",),
        );
        Navigator.of(context).push(route);
         

        
      },
    );
  }
}

Future<List<NosHorairesFull>> downloadJSON(String refEngin) async {
  //final jsonEndpoint = PubCon.cheminPhp + "GetHistoriqueVoyageFuture.php";
  final response = await http.post(
      PubCon.cheminPhp + "GetHoraireSelonEngin.php",
      body: {"refEngin": refEngin});
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List horaireFull = json.decode(response.body);
    return horaireFull
        .map((horairesFull) => new NosHorairesFull.fromJson(horairesFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
