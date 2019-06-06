import 'dart:convert';

import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

class CodeArgent extends StatefulWidget {
  @override
  _CodeArgentState createState() => _CodeArgentState();
}

class _CodeArgentState extends State<CodeArgent> {
  int diff;
  TextEditingController nomClient_billet = new TextEditingController(),
      lastNameClient_billet = new TextEditingController(),
      dateNaissance = new TextEditingController(),
      designationClasse = new TextEditingController(),
      designationEngin = new TextEditingController(),
      dateVoyage = new TextEditingController(),
      lieuArret = new TextEditingController(),
      lieuDepart = new TextEditingController(),
      codeDetailReserv = new TextEditingController(),
      heureDepart = new TextEditingController();
  int resQr;
  Widget identite() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                      enabled: false,
                      controller: designationEngin,
                      decoration: InputDecoration(labelText: "Engin"),
                    ),
                    TextField(
                      enabled: false,
                      controller: designationClasse,
                      decoration: InputDecoration(labelText: "classe"),
                    ),
                    TextField(
                      enabled: false,
                      controller: dateVoyage,
                      decoration: InputDecoration(labelText: "Date de Voyage"),
                    ),
                    Divider(),
Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: lieuDepart,
                            decoration: InputDecoration(labelText: "Depart"),
                          ),
                        ),
                        Icon(Icons.navigate_next),
                        Expanded(
                          child: TextField(
                            enabled: false,
                            controller: lieuArret,
                            decoration: InputDecoration(labelText: "Destination"),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      enabled: false,
                      controller: heureDepart,
                      decoration: InputDecoration(labelText: "Heure Depart"),
                    ),

Divider(),

                  
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                    enabled: false,
                    controller: nomClient_billet,
                    decoration: InputDecoration(labelText: "Nom"),
                  ),
                  TextField(
                    enabled: false,
                    controller: lastNameClient_billet,
                    decoration: InputDecoration(labelText: "Prenom"),
                  ),
                  TextField(
                    enabled: false,
                    controller: dateNaissance,
                    decoration: InputDecoration(labelText: "Date Naissance"),
                  ),
                    
                  ],
                ),
              )),
        )
      ],
    );
  }

  Future<List> _charger(String qr) async {
    final response = await http.post(PubCon.cheminPhp + "GetValiditeBillet.php",
        body: {"codeDetailRes": qr});
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        diff = null;
      });
    } else {
      if (mounted)
        setState(() {
          for (int h = 0; h < datauser.length; h++) {
            diff = int.parse(datauser[h]['DayDiff'].toString());
            nomClient_billet.text=datauser[h]['nomClient_billet'].toString();
            lastNameClient_billet.text=datauser[h]['LastNameClient_billet'].toString();
            dateNaissance.text=datauser[h]['dateNaissance'].toString();
            designationEngin.text=datauser[h]['designationEngin'].toString();
            designationClasse.text=datauser[h]['designationClasse'].toString();
            dateVoyage.text=datauser[h]['dateVoyage'].toString();
            lieuDepart.text=datauser[h]['LieuDepart'].toString();
            lieuArret.text=datauser[h]['LieuArret'].toString();
            heureDepart.text=datauser[h]['heureDepart'].toString();
          }
        });
    }
    return datauser;
  }

  Future<String> _codeString;
  Widget getTest(int _diff) {
    if (_diff == null) {
      return new Center(
                          child: Text("...Aucun elemenent..."));
    } else {
      if (_diff >= 0) {
        return Column(
          children: <Widget>[
            Divider(),
            ListTile(
              title: Text(
                "Billet Valide",
                textAlign: TextAlign.justify,
              ),
              leading: Icon(
                Icons.verified_user,
                color: Colors.blue,
              ),
            ),
            Divider(),
            QrImage(
              data: "Valide",
              foregroundColor: Colors.blue,
              size: 100.0,
            ),
            Divider(),
            identite(),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Divider(),
            ListTile(
              title: Text(
                "Billet Invalide",
                textAlign: TextAlign.justify,
              ),
              leading: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            Divider(),
            QrImage(
              data: "Invalide",
              foregroundColor: Colors.red,
              size: 100.0,
            ),
            Divider(),
            identite()
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner QR_Code'),
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // new FutureBuilder<String>(
            //   future: _codeString,
            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //     if (snapshot.data == null) {
            //     } else {
            //       _charger(snapshot.data);
            //     }
            //     return Text(
            //         snapshot.data != null ? '' : 'Scanner le Qr_Code...');
            //   },
            // ),
            //Text("$diff"),
            TextFormField(
              controller: codeDetailReserv,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Entrer le code",
                labelText: "Code"
              ),
            ),
            RaisedButton(
              child:Text("VERIFIER"),
              onPressed: (){

              _charger(codeDetailReserv.text);
            }),
           Divider(),
            getTest(diff)
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: (){getCodeArgent(codeDetailReserv.text,diff);},
      //   tooltip: 'Scanner',
      //   child: Icon(Icons.scanner),
      // ),
    );
  }

  Widget getCodeArgent(String codeDet,int dif) {
    try {
      _charger(codeDet);
      getTest(dif);
    } catch (e) {}
  }
}
