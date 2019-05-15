import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyFacture extends StatefulWidget {
  @override
  _MyFactureState createState() => _MyFactureState();
}

class _MyFactureState extends State<MyFacture> {
  TextEditingController cMontantTotal = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _chargerModePay();
    _getMontantTot();
  }

  var _designMode = [""];
  var _montanPay = [""];
  Future<List> _getMontantTot() async {
    final response = await http.post(PubCon.cheminPhp + "GetTotalPaie.php",
        body: {
          "refReservation":'${ClsReservation.idReservation}'
          });
    print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
    } else {
      _montanPay.clear();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          _montanPay.add(datauser[h]['MontantTotal'].toString());
        }
        if(ClsReservation.idReservation2!=null){
          cMontantTotal.text='${(double.parse(_montanPay[0]))*2} \$';
        }else{
          cMontantTotal.text='${_montanPay[0]} \$';
        }
        
      });
    }
    return datauser;
  }

  Future<List> _chargerModePay() async {
    final response =
        await http.post(PubCon.cheminPhp + "GetmodePaiement.php", body: {});
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {});
    } else {
      _designMode.clear();
      //clearItems();
      setState(() {
        for (int h = 0; h < datauser.length; h++) {
          var designation = datauser[h]['designationMode'].toString();
          _designMode.add(designation);
        }
      });
    }
    return datauser;
  }

  //fx insertReservation
  //create listView MontantPay
  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _designMode.length == null ? 0 : _designMode.length,
        itemBuilder: (BuildContext context, int index) {
          //return new Text(_view[index]);
          return Card(
            color: Colors.white,
            elevation: 5.0,
            child: new Column(
              children: <Widget>[
                ListTile(
                  title: Text('${_designMode[index]}'),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }

// //create a list Widget
//   Widget _createListViewTot() {
//     return new Flexible(
//       child: new ListView.builder(
//         scrollDirection: Axis.vertical,

//         shrinkWrap: true,

//         itemCount: _montanPay.length == null ? 0 : _montanPay.length,
//         itemBuilder: (BuildContext context, int index) {
//           //return new Text(_view[index]);

//           return Card(
//             color: Colors.white,
//             elevation: 5.0,
//             child: new Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text('${_montanPay[index]} \$'),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(
          'Paiement',
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
//Chargement des classes ici
         // _createListViewTot(),
          _createListView(),
        ],
      ),
    );
  }
}
