import 'package:flights_app/MyClasses/components.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/detail_agence.dart';
import 'package:flights_app/MyDesigns/Administration/engin.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' show get;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories extends StatefulWidget {
  final String menu;

  const Categories({Key key, this.menu}) : super(key: key);
  @override
  CategoriesState createState() {
    return new CategoriesState();
  }
}

class CategoriesState extends State<Categories> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text("Categories"),
      ),
      body: new Container(
          child: new FutureBuilder<List<CategorieFull>>(
              future: downloadJSON(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CategorieFull> billetsFull = snapshot.data;

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

class CategorieFull {
  final String codeCatEngin;
  final String designeCatEngin;

  CategorieFull({
    Key key,
    this.codeCatEngin,
    this.designeCatEngin,
  });
  factory CategorieFull.fromJson(Map<String, dynamic> jsonData) {
    return CategorieFull(
      codeCatEngin: jsonData['codeCatEngin'],
      designeCatEngin: jsonData['designeCatEngin'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<CategorieFull> billetFull;
  final String menu;
  CustomListView(this.billetFull, this.menu);
  Widget build(context) {
    
    return ListView.builder(
        itemCount: billetFull.length,
        itemBuilder: (context, int currentIndex) {
          return createViewItem(billetFull[currentIndex], context,menu);
        });
  }

  Widget createViewItem(CategorieFull catFull, BuildContext context,String menu) {
    return new ListTile(
      title: new Card(
        elevation: 3.0,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  title: Text(
                                    "${catFull.designeCatEngin}",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  subtitle: Text("#00${catFull.codeCatEngin}",textAlign: TextAlign.right,),
                                  leading: Componentss.iconaddconsCat(context,"${catFull.codeCatEngin}")
                            
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
        if(menu=='agence'){
var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new DetailAgence(value: catFull),
        );
        Navigator.of(context).push(route);
        }else if(menu=='engin'){
var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Engin(value: catFull),
        );
        Navigator.of(context).push(route);
        }
        

        
      },
    );
  }
}

Future<List<CategorieFull>> downloadJSON() async {
  //final jsonEndpoint = PubCon.cheminPhp + "GetHistoriqueVoyageFuture.php";
  final response = await http.post(
      PubCon.cheminPhp + "GetCategorieEngin.php",
      body: {});
  //var data = json.decode(response.body);
  if (response.statusCode == 200) {
    //if(data.length != 0){
    List billetsFull = json.decode(response.body);
    return billetsFull
        .map((billetsFull) => new CategorieFull.fromJson(billetsFull))
        .toList();
  } else {
    throw Exception('Nous n\'avons pas pu telecharger toutes les donnees.');
  }
}
