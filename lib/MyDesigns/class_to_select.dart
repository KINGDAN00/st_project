import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/clsReservation.dart';
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
    //_getCode();
    //_getCode2();
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
      if(mounted){
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
         
          ClsReservation.idReservation =datauser[h]['IdEncours'].toString() == null ? 0 : int.parse(datauser[h]['IdEncours'].toString());
        }
      });}
    }
    return datauser;
}

 Future<List> _getCode2() async {
    final response =
        await http.post(PubCon.cheminPhp + "GetidEncours.php", body: {
    });
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
    } else {
      if(mounted)
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
         
          ClsReservation.idReservation2 =datauser[h]['IdEncours'].toString() == null ? 0 : int.parse(datauser[h]['IdEncours'].toString());
        }
      });
    }
    return datauser;
}
  Future<List> _charger() async {
    final response = await http.post(PubCon.cheminPhp + "GetDetailEngin.php",
        body: {"refEngin": ClsReservation.idEnginToSelect});
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {});
    } else {
      _designClasse.clear();
      _prixClasse.clear();
      _detailID.clear();
      //clearItems();
      if(mounted){
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          _designClasse.add(datauser[h]['designationClasse'].toString());
          _prixClasse.add(datauser[h]['prixClasse'].toString());
          _detailID.add(datauser[h]['codeDetailEngin'].toString());
        }
      });}
    }
    return datauser;
  }

  //fx insertReservation
  Future addReservation() async {
    try{
    var uri = Uri.parse(PubCon.cheminPhp + "insertReservation.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['refCompte'] =ClsReservation.refCompte;
    request.fields['refAgence'] = ClsReservation.refAgence;
    request.fields['refHoraire'] = ClsReservation.refHoraire;
    request.fields['refDetailEngin'] = ClsReservation.refDetailEngin;
    request.fields['dateVoyage'] = ClsReservation.dateVoyage;
    request.fields['usersession']=PubCon.userAgent;
    var response = await request.send();
    if (response.statusCode == 200) {
      // if(CritereSelect.course==1)_getCode();
      // else if(CritereSelect.course==2) {_getCode();_getCode2();}
      print("Enregistrement reussi ${ClsReservation.idReservation}");
      Fluttertoast.showToast(msg:'Enregistré ${ClsReservation.idReservation}',toastLength:Toast.LENGTH_LONG,
                              backgroundColor:Colors.white,textColor:Colors.black);
                      
      
    } else {
      print("Echec d'enregistrement");
    }
    }catch(ex){
      Fluttertoast.showToast(msg:'$ex',toastLength:Toast.LENGTH_LONG,
                              backgroundColor:Colors.white,textColor:Colors.black);
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
                      _getCode();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IdentitePassager(code1: ClsReservation.idReservation,)));
                      
                    } else if (CritereSelect.course == 2) {
                      ClsReservation.dateVoyage = CritereSelect.datedep;
                      //appel fx insert Reservation
                      addReservation();
                      _getCode();
                      ClsReservation.dateVoyage = CritereSelect.dateRet;
                      //appel fx insert Reservation
                      addReservation();
                      _getCode2();
                      //passer a l'identification des passagers
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IdentitePassager(code1: ClsReservation.idReservation,code2: ClsReservation.idReservation2,)));
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
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    controller: cNbrePlace,
                    decoration: new InputDecoration(
                        labelText:
                            "Nombre de Places\n precisez le nombre des passagers ici:",
                        hintText: "Preciser le nombre de place ici",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0))
                            ),
                            onChanged: (text){
                              setState(() {
                               CritereSelect.nbrePassager=int.parse(text); 
                              });
                            },
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
