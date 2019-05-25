import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/engin_classes.dart';
import 'package:flights_app/MyDesigns/Administration/engin_horaireList.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'dart:convert';

class NosEngins extends StatefulWidget {
  final String menu;

  const NosEngins({Key key, this.menu}) : super(key: key);
  @override
  NosEnginsState createState() {
    return new NosEnginsState();
  }
}

class NosEnginsState extends State<NosEngins> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Nos Engins"),
      ),
      body: new Container(
          child: new FutureBuilder<List<NosEnginsFull>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NosEnginsFull> billetsFull = snapshot.data;

                  return CustomListView(billetsFull,widget.menu);
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

class NosEnginsFull {
  final String codeEngin;
  final String designationEngin,
      matriculeEngin;

  NosEnginsFull({
    Key key,
    this.codeEngin,
    this.designationEngin,
    this.matriculeEngin,
  });
  factory NosEnginsFull.fromJson(Map<String, dynamic> jsonData) {
    return NosEnginsFull(
      codeEngin: jsonData['codeEngin'],
      designationEngin: jsonData['designationEngin'],
      matriculeEngin: jsonData['matriculeEngin'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<NosEnginsFull> billetFull;
  final String menu;
  CustomListView(this.billetFull, this.menu);
  Widget build(context) {
    return ListView.builder(
        itemCount: billetFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(billetFull[currentIndex], context,menu);
        });
  }

  Widget createViewItem(NosEnginsFull enginFull, BuildContext context,String menu) {
    return new ListTile(
      contentPadding: EdgeInsets.all(1.0),
      title: new Card(
        elevation: 3.0,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  title: Text(
                                    "${enginFull.designationEngin}",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  subtitle: Text("${enginFull.matriculeEngin}"),
                                  leading: Text("#00${enginFull.codeEngin}")
                            
                          ),])
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if(menu=='classe'){
var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new ClasseEngin(value: enginFull),
        );
        Navigator.of(context).push(route);
        }else if(menu=='horaire'){
var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new NosHoraires(value: enginFull),
        );
        Navigator.of(context).push(route);
        } 

        
      },
    );
  }
}

Future<List<NosEnginsFull>> downloadJSON() async {
  //final jsonEndpoint = PubCon.cheminPhp + "GetHistoriqueVoyageFuture.php";
  final response = await http.post(
      PubCon.cheminPhp + "GetEngins.php",
      body: {"id_agence": PubCon.userIdAgence.toString()});
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List billetsFull = json.decode(response.body);
    return billetsFull
        .map((billetsFull) => new NosEnginsFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
