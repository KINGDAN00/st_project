import 'dart:convert';

import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/det.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/class_to_select.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetHoraireAller extends StatefulWidget {
  @override
  _GetHoraireAllerState createState() => _GetHoraireAllerState();
}

class _GetHoraireAllerState extends State<GetHoraireAller> {
  var _depAller = [""];
  var _arriveAller = [""];
  var _heureDepAller = [""];
  var _heureArriveAller = [""];
  var _enginAller = [""];
  List<String> _agenceID=[""];
  var _horaireID=[""];
  var _idEngin = [""];
  //tableau pour les details:
  
  // definition des fonctions de chargements
  Future<List> _chargerEntete() async {
    final response =
        await http.post(PubCon.cheminPhp + "getHoraireAllerSimple.php", body: {
      "depart": CritereSelect.depart.toString(),
      "arrive": CritereSelect.arrive.toString(),
      "datedep": CritereSelect.datedep.toString(),
      "refCatEngin": CritereSelect.refCatEngin.toString(),
    });
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        _enginAller=["Aucun resultat"];
      });
    } else {
      _depAller.clear();
  _arriveAller.clear();
  _heureDepAller.clear();
  _heureArriveAller.clear();
  _enginAller.clear();
  _idEngin.clear();
  _agenceID.clear();
  _horaireID.clear();
      //clearItems();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          var depart = datauser[h]['LieuDepart'].toString();
          var arrive = datauser[h]['LieuArret'].toString();
          var heureDep = datauser[h]['heureDepart'].toString();
          var heureArrive = datauser[h]['heureArrive'].toString();
          var engin = datauser[h]['designationEngin'].toString();
          var idEngin = datauser[h]['refEngin'].toString();
          var idAgence = datauser[h]['codeAgence'].toString();
          var idHoraire = datauser[h]['codeHoraire'].toString();
          _depAller.add(depart);
  _arriveAller.add(arrive);
  _heureDepAller.add(heureDep);
  _heureArriveAller.add(heureArrive);
  _enginAller.add(engin);
  _idEngin.add(idEngin);
  _agenceID.add(idAgence);
  _horaireID.add(idHoraire);
        }
      });
    }
    return datauser;
  }
//create a listView
 Widget maListeDetail(BuildContext context,String refEngin1){
   
     _chargerDetail(refEngin1);

  return ListView.builder(itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: 
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('${Detail.designClasse[index]}'),
                              ),
                              
                              Expanded(
                                child:Text("${Detail.prixClasse[index]} \$",textAlign: TextAlign.center,), 
                              )
                              
                            ],
                          ),
                        
                    );
              },itemCount: Detail.designClasse.length == null ? 0 : Detail.designClasse.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              );
}


  //charger Detail
Future<List> _chargerDetail(var refEngin1) async {
    final response =
        await http.post(PubCon.cheminPhp + "GetDetailEngin.php", body: {
      "refEngin": refEngin1
    });
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      //setState(() {

      //});
    } else {
      Detail.designClasse.clear();
      Detail.prixClasse.clear();
      //clearItems();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          var designation = datauser[h]['designationClasse'].toString();
          var prix = datauser[h]['prixClasse'].toString();
          Detail.designClasse.add(designation);
          Detail.prixClasse.add(prix);
        }
      });
    }
    return datauser;
  }
@override
  void initState() {
    super.initState();
    _chargerEntete();
    //_chargerBienDet(_idEngin);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${CritereSelect.depart} --> ${CritereSelect.arrive}\n ${CritereSelect.datedep}",
        style: TextStyle(fontSize: 14.0),),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Card(
        elevation: 3.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(   
          child: 
           GestureDetector(
      onTap: (){
        ClsReservation.dateVoyage='${CritereSelect.datedep}';
        ClsReservation.refAgence='${_agenceID[index]}';
        ClsReservation.refHoraire='${_horaireID[index]}';
        ClsReservation.idEnginToSelect='${_idEngin[index]}';
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)
                => MyClasses(
                )
            )
        );
      },
          child:
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical:20.0),
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
          Text('${_depAller[index]}', style: TextStyle(fontSize: 16.0),),
          SizedBox(height: 8.0,),
          Text('${_heureDepAller[index]}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),
                        Text("--->"),
Expanded(
      child: Column(
        children: <Widget>[
          
          Text('${_arriveAller[index]}', style: TextStyle(fontSize: 16.0),),
          SizedBox(height: 8.0,),
          Text('${_heureArriveAller[index]}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
        ],
      ),
    ),

                      ],
                    ),
                    ListTile(
                      title: Text("${_enginAller[index]}"),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),),
                
          ),
        ),
      ),
      Divider(),
      Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Class'),
                              ),
                              Expanded(
                                child:Text("Prix",textAlign: TextAlign.center,), 
                              )
                              
                            ],
                          ),
                          Divider(),
              //Text('Entete $index',style: Theme.of(context).textTheme.body2),
              maListeDetail(context, _idEngin[index]),
              
            ],
          ),
        );
      },
      itemCount: _idEngin.length == null ? 0 : _idEngin.length,
      ),
    );
  }
}