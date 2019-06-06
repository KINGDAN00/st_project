import 'dart:async';
import 'dart:convert';
//import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyReport extends StatefulWidget {
  final String idEngin,idClasse,menuTrie;

  const MyReport({Key key, this.idEngin, this.idClasse, this.menuTrie}) : super(key: key);
  @override
  _MyReportState createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> {
  TextEditingController cMontantTotal = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  var _designMode = [""];
  var _montanPay = [""];
  var _nom = [""];
  var _prix = [""];
  var _dateV = [""];
  double montantTot = 0.0;
  Future<List> _getMontantTot1() async {
    try {
      final response = await http.post(
          PubCon.cheminPhp + "GetRapportJouranilerReservationEngin.php",
          body: {
            "date1": "${f.format(date1)}",
            "date2": "${f.format(date2)}",
            "CodeAgence": "${PubCon.userIdAgence}",
            "CodeEngin": "${widget.idEngin}"
          });
      print(response.body);
      var datauser = json.decode(response.body);
      if (datauser.length == 0) {
        _nom=["Aucune reservation trouvée"];
      } else {
        _montanPay.clear();
        _nom.clear();
        _dateV.clear();
        _prix.clear();
        montantTot = 0.0;
        setState(() {
          for (int h = 0; h < datauser.length; h++) {
            _montanPay.add(datauser[h]['MontantTotal'].toString());
            _nom.add(datauser[h]['nomClient_billet'].toString() +
                " " +
                datauser[h]['LastNameClient_billet'].toString());
            _dateV.add(datauser[h]['dateVoyage'].toString());
            _prix.add(datauser[h]['prixClasse'].toString());
           montantTot=montantTot+(double.parse(datauser[h]['prixClasse'])==null?0.0 : double.parse(datauser[h]['prixClasse']));
          }
        });
      }
      return datauser;
    } catch (ex) {
      print(
          "====================================================================\n $ex");
    }
  }
  Future<List> _getMontantTot2() async {
    try {
      final response = await http.post(
          PubCon.cheminPhp + "GetRapportJournalierReservationClasse.php",
          body: {
            "date1": "${f.format(date1)}",
            "date2": "${f.format(date2)}",
            "CodeAgence": "${PubCon.userIdAgence}",
            "refClasse" : "${widget.idClasse}"
          });
      print(response.body);
      var datauser = json.decode(response.body);
      if (datauser.length == 0) {
        _nom=["Aucune reservation trouvée"];
      } else {
        _montanPay.clear();
        _nom.clear();
        _dateV.clear();
        _prix.clear();
        montantTot = 0.0;
        setState(() {
          for (int h = 0; h < datauser.length; h++) {
            _montanPay.add(datauser[h]['MontantTotal'].toString());
            _nom.add(datauser[h]['nomClient_billet'].toString() +
                " " +
                datauser[h]['LastNameClient_billet'].toString());
            _dateV.add(datauser[h]['dateVoyage'].toString());
            _prix.add(datauser[h]['prixClasse'].toString());
           montantTot=montantTot+(double.parse(datauser[h]['prixClasse'])==null?0.0 : double.parse(datauser[h]['prixClasse']));
          }
        });
      }
      return datauser;
    } catch (ex) {
      print(
          "====================================================================\n $ex");
    }
  }
  Widget _createListViewDet() {
    return Container(
      child: new Column(
        //direction: Axis.vertical,
        children: <Widget>[
          new ListView.builder(
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
                    ListTile(
                      title: Text('${_nom[index]}'),
                      subtitle: Text('${_dateV[index]}'),
                      leading: Text('${_prix[index]}'),
                      onTap: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  final f = new DateFormat('yyyy-MM-dd');
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );
    setState(() {
      date1 = picked;
      //CritereSelect.datedep=date1==null? '':f.format(date1).toString();
    });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );
    setState(() {
      date2 = picked;
      //CritereSelect.dateRet=date2==null? '':f.format(date2).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: new Text(
          '$montantTot \$',
          style: TextStyle(color: Colors.black),
        ),
      ),

      //body here
      body: ListView(
        children: <Widget>[
          Divider(),
          Container(
            color: Colors.white12,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.date_range, color: Colors.blue),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextField(
                          maxLines: 2,
                          //controller: datedep,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.date_range,color: Colors.grey,),
                            hintText: 'Du :\n' +
                                (date1 == null
                                    ? ''
                                    : f.format(date1).toString()),
                          ),
                          onTap: () {
                            _selectDate1(context);
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                    Icon(Icons.navigate_next),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextField(
                          maxLines: 2,
                          //controller: datedep,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.date_range,color: Colors.grey,),
                            hintText: 'Au :\n' +
                                (date2 == null
                                    ? ''
                                    : f.format(date2).toString()),
                          ),
                          onTap: () {
                            _selectDate2(context);
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                IconButton(
                  onPressed: () {
                    if(widget.menuTrie=='engin'){
_getMontantTot1();
                    }
                    
                  },
                  icon: Icon(Icons.sort),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.red,
          ),
          _createListViewDet()
        ],
      ),
    );
  }
}
