import 'dart:convert';

import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ModePay extends StatefulWidget {
  @override
  _ModePayState createState() => _ModePayState();
}

class _ModePayState extends State<ModePay> {
 @override
  void initState() {
    super.initState();
    _chargerModePay();
  }

  var _designMode = [""];

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
          
          _designMode.add(datauser[h]['designationMode'].toString());
        }
      });
    }
    return datauser;
  }
  Widget _createListView() {
    return new Column(
      children: <Widget>[
    new ListView.builder(
  
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
],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mode de Paiement"),
      ),
      body: Container(
        child: _createListView(),
      )
    );
  }
}