import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/mode_pay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyFacture extends StatefulWidget {
  final int idReservation;

  const MyFacture({Key key, this.idReservation}) : super(key: key);
  @override
  _MyFactureState createState() => _MyFactureState();
}

class _MyFactureState extends State<MyFacture> {
  TextEditingController cMontantTotal = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //_chargerModePay();
    _getMontantTot();
  }

  //var _designMode = [""];
  var _montanPay = [""];
  var _nom=[""];
  var _prix=[""];
  var _dateV=[""];
  var _depAller = [""];
  var _arriveAller = [""];
  var _heureDepAller = [""];
  var _heureArriveAller = [""];
  var _designationClasse=[""];
  var _enginAller = [""];
  var _nomAgence=[""];
  Future<List> _getMontantTot() async {
    try{
    final response = await http.post(PubCon.cheminPhp + "GetTotalPaie.php",
        body: {
          "refReservation":"${widget.idReservation}"
         // "refReservation":"16"
          });
    print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
    } else {
      _montanPay.clear();
      _nom.clear();
      _dateV.clear();
      _prix.clear();
       _depAller.clear();
   _arriveAller.clear();
   _heureDepAller.clear();
   _heureArriveAller.clear();
   _designationClasse.clear();
   _enginAller.clear();
   _nomAgence.clear();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          _montanPay.add(datauser[h]['MontantTotal'].toString());
          _nom.add(datauser[h]['nomClient_billet'].toString()+" "+datauser[h]['LastNameClient_billet'].toString());
          _dateV.add(datauser[h]['dateVoyage'].toString());
          _prix.add(datauser[h]['prixClasse'].toString());
          _depAller.add(datauser[h]['LieuDepart'].toString());
        _arriveAller.add(datauser[h]['LieuArret'].toString());
        _heureDepAller.add(datauser[h]['heureDepart'].toString());
        _heureArriveAller.add(datauser[h]['heureArrive'].toString());
        _enginAller.add(datauser[h]['designationEngin'].toString());
         _nomAgence.add(datauser[h]['nomagence'].toString());
         _designationClasse.add(datauser[h]['designationClasse'].toString());
        }
        // if(ClsReservation.idReservation2!=null){
          cMontantTotal.text='${(double.parse(_montanPay[0]))*CritereSelect.course} \$';
        // }else{
        //   cMontantTotal.text='${_montanPay[0]} \$';
        // }
        
      });
    }
    return datauser;
    }catch(ex){
print("====================================================================\n $ex");
    }
  }

  // Future<List> _chargerModePay() async {
  //   final response =
  //       await http.post(PubCon.cheminPhp + "GetmodePaiement.php", body: {});
  //   //print(response.body);
  //   var datauser = json.decode(response.body);
  //   if (datauser.length == 0) {
  //     setState(() {});
  //   } else {
  //     _designMode.clear();
  //     //clearItems();
  //     setState(() {
  //       for (int h = 0; h < datauser.length; h++) {
          
  //         _designMode.add(datauser[h]['designationMode'].toString());
  //       }
  //     });
  //   }
  //   return datauser;
  // }

  //fx insertReservation
  //create listView MontantPay
  // Widget _createListView() {
  //   return new Flexible(
  //     child: new ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       itemCount: _designMode.length == null ? 0 : _designMode.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         //return new Text(_view[index]);
  //         return Card(
  //           color: Colors.white,
  //           elevation: 5.0,
  //           child: new Column(
  //             children: <Widget>[
  //               ListTile(
  //                 title: Text('${_designMode[index]}'),
  //                 onTap: () {},
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

 Widget _createListViewDet() {
    return new Container(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _nom.length == null ? 0 : _nom.length,
        itemBuilder: (BuildContext context, int index) {
          //return new Text(_view[index]);
          return Card(
            color: Colors.white,
            elevation: 5.0,
            child: new Column(
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
                                title: Text("${_nomAgence[index]==null? "" : _nomAgence[index]}"),
                                subtitle: Text("${_enginAller[index]}",style: TextStyle(color: Colors.blue),),
                                leading: Text("${_designationClasse[index]}"),
                              )
                            ],
                          ),),
                ListTile(
                  title: Text('${_nom[index]}'),
                  subtitle: Text('${_dateV[index]}'),
                  leading: Text('${_prix[index]} \$'),
                  onTap: () {},
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
          'Paiement',
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.payment), onPressed: () {
Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ModePay(
                                                          )));
          },)
        ],
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
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.red,
                        fontSize: 30.0),
                    enabled: false,
                    keyboardType: TextInputType.number,
                    focusNode: FocusNode(),
                    maxLines: 1,
                    controller: cMontantTotal,
                    decoration: new InputDecoration(
                        labelText: "Montant TOTAL :",
                        hintText: "",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0))),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.red,
          ),
            _createListViewDet()
         //_createListView(),
        ],
      ),
    );
  }
}
