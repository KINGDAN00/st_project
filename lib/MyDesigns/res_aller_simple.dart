import 'dart:convert';

import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/components.dart';
//import 'package:flights_app/MyClasses/components.dart';
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
  var _logoAg=[""];
  var _nomAgence=[""];
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
    try{
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      if(mounted){
      setState(() {
        _enginAller=["Aucun resultat"];
      });}
    } else {
      
      clearItems();
            if(mounted){
            setState(() {
              for (int h = 0; h < datauser.length; h++) {
                _depAller.add(datauser[h]['LieuDepart'].toString());
        _arriveAller.add(datauser[h]['LieuArret'].toString());
        _heureDepAller.add(datauser[h]['heureDepart'].toString());
        _heureArriveAller.add(datauser[h]['heureArrive'].toString());
        _enginAller.add(datauser[h]['designationEngin'].toString());
        _idEngin.add(datauser[h]['refEngin'].toString());
        _agenceID.add(datauser[h]['codeAgence'].toString());
        _horaireID.add(datauser[h]['codeHoraire'].toString());
        _logoAg.add(datauser[h]['logoAgence'].toString());
         _nomAgence.add(datauser[h]['nomAgence'].toString());
              }
            });}
          }
          return datauser;
          }catch(ex){
            print('==========================================\nerror $ex');
          }
        }
      //create a listView
       Widget maListeDetail(BuildContext context,String refEngin1){
         
           _chargerDetail(refEngin1);
      
        return ListView.builder(itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: 
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('${Detail.designClasse[index]}',textAlign: TextAlign.center,),
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
            //if(mounted)
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
              title: Text("${CritereSelect.depart} -> ${CritereSelect.arrive}\n ${CritereSelect.datedep}",
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
             if(mounted){
               setState(() {
                 ClsReservation.dateVoyage='${CritereSelect.datedep}';
              ClsReservation.refAgence='${_agenceID[index]}';
              ClsReservation.refHoraire='${_horaireID[index]}';
              ClsReservation.idEnginToSelect='${_idEngin[index]}'; 
               });
             }else{
                ClsReservation.dateVoyage='${CritereSelect.datedep}';
              ClsReservation.refAgence='${_agenceID[index]}';
              ClsReservation.refHoraire='${_horaireID[index]}';
              ClsReservation.idEnginToSelect='${_idEngin[index]}';
             }
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context)
                      => MyClasses(
                      )
                  )
              );
            },
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
                    Text('${_depAller[index]}', style: TextStyle(fontSize: 16.0),),
                    SizedBox(height: 8.0,),
                    Text('${_heureDepAller[index]}', style: TextStyle(color: Colors.grey, fontSize: 16.0),)
              ],
            ),
          ),
          Icon(Icons.navigate_next),
                                  //Text("--->"),
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
                                title: Text("Agence: ${_nomAgence[index]}"),
                                subtitle: Text("${_enginAller[index]}",style: TextStyle(color: Colors.blue),),
                                leading: Componentss.manageImage(context,"${_logoAg[index]}")
                                // CircleAvatar(
                                //   backgroundColor: Colors.blue
                                // ),
                              )
                            ],
                          ),),
                  Divider(color: Colors.blue,),
            Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text('Class',textAlign: TextAlign.center,),
                                    ),
                                    Expanded(
                                      child:Text("Prix",textAlign: TextAlign.center,), 
                                    )
                                    
                                  ],
                                ),
                                Divider(color: Colors.blue,),
                    //Text('Entete $index',style: Theme.of(context).textTheme.body2),
                    maListeDetail(context, _idEngin[index]),
                  
                  ],
                ),
                      
                ),
              ),
            ),
            
                    
                  ],
                ),
              );
            },
            itemCount: _idEngin.length == null ? 0 : _idEngin.length,
            ),
          );
        }
      
        void clearItems() {
          _depAller.clear();
  _arriveAller.clear();
  _heureDepAller.clear();
  _heureArriveAller.clear();
  _enginAller.clear();
  _idEngin.clear();
  _agenceID.clear();
  _horaireID.clear();
  _logoAg.clear();
  _nomAgence.clear();
        }
}