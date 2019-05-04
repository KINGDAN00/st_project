import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/components.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/identite_passager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MyClasses extends StatefulWidget {
  @override
  _MyClassesState createState() => _MyClassesState();
}

class _MyClassesState extends State<MyClasses> {
  TextEditingController cNbrePlace = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _getCode();
    _charger();
    //_view.sort();
    cNbrePlace.text = "1";
  }

  var _designClasse = [""];
  var _prixClasse = [""];
  var _detailID = [""];
  Future<List> _getCode() async {
    final response =
        await http.post(PubCon.cheminPhp + "GetidEncours.php", body: {
    });
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
    } else {
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
         
          ClsReservation.idReservation =datauser[h]['IdEncours'].toString() == null ? 1 : 1+int.parse(datauser[h]['IdEncours'].toString());
        }
      });
    }
    return datauser;
  }
  Future<List> _charger() async {
    final response = await http.post(PubCon.cheminPhp + "GetDetailEngin.php",
        body: {"refEngin": ClsReservation.idEnginToSelect.toString()});
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {});
    } else {
      _designClasse.clear();
      _prixClasse.clear();
      _detailID.clear();
      //clearItems();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          var designation = datauser[h]['designationClasse'].toString();
          var prix = datauser[h]['prixClasse'].toString();
          var idDetail = datauser[h]['codeDetailEngin'].toString();
          _designClasse.add(designation);
          _prixClasse.add(prix);
          _detailID.add(idDetail);
        }
      });
    }
    return datauser;
  }

  //fx insertReservation
  Future addReservation() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertReservation.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['refCompte'] = ClsReservation.refCompte;
    request.fields['refAgence'] = ClsReservation.refAgence;
    request.fields['refHoraire'] = ClsReservation.refHoraire;
    request.fields['refDetailEngin'] = ClsReservation.refDetailEngin;
    request.fields['dateVoyage'] = ClsReservation.dateVoyage;
    var response = await request.send();
    if (response.statusCode == 200) {
      _getCode();
      print("Enregistrement reussi ${ClsReservation.idReservation}");
      Fluttertoast.showToast(msg:'Enregistré',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IdentitePassager()));
      
    } else {
      print("Echec d'enregistrement");
    }
  }

//create a list Widget
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _designClasse.length == null ? 0 : _designClasse.length,
        itemBuilder: (BuildContext context, int index) {
          //return new Text(_view[index]);
          return Card(
            color: Colors.white,
            elevation: 5.0,
            child: new Column(
              children: <Widget>[
                ListTile(
                  title: Text('${_designClasse[index]}'),
                  leading: Text(
                    '${_prixClasse[index]} \$',
                  ),
                  subtitle: Text('\n Place(s):'),
                  onTap: () {
                    ClsReservation.refDetailEngin = _detailID[index].toString();
                    if (CritereSelect.course == 1) {
                      ClsReservation.dateVoyage = CritereSelect.datedep.toString();
                      //appel fx insert Reservation
                      addReservation();
                      
                    } else if (CritereSelect.course == 2) {
                      ClsReservation.dateVoyage = CritereSelect.datedep;
                      //appel fx insert Reservation
                      addReservation();
                      ClsReservation.dateVoyage = CritereSelect.dateRet;
                      //appel fx insert Reservation
                      addReservation();
                      //passer a l'identification des passagers
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(
          'Select Class',
        ),
      ),

      //body here
      body: Column(
        children: <Widget>[
          Divider(),
          Container(
            color: Colors.white12,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: FocusNode(),
                    maxLines: 1,
                    controller: cNbrePlace,
                    decoration: new InputDecoration(
                        labelText:
                            "Nombre de Places\n precisez le nombre des passagers ici:",
                        hintText: "Preciser le nombre de place ici",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0))),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
//Chargement des classes ici
          _createListView(),
        ],
      ),
    );
  }
}
