import 'dart:convert';

import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/facture_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class IdentitePassager extends StatefulWidget {
  final int code1, code2;

  const IdentitePassager({Key key, this.code1, this.code2}) : super(key: key);
  @override
  IdentitePassagerState createState() {
    return new IdentitePassagerState();
  }
}

class IdentitePassagerState extends State<IdentitePassager>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
  TextEditingController cNom = new TextEditingController(),
      cPrenom = new TextEditingController(),
      cGenre = new TextEditingController(),
      cAdresse = new TextEditingController(),
      cContactPhone = new TextEditingController(),
      cContactMail = new TextEditingController(),
      cCodePostal = new TextEditingController(),
      cNationnalite = new TextEditingController(),
      cDateNaiss = new TextEditingController();
  final f = new DateFormat('yyyy-MM-dd');
  DateTime dateNaiss = DateTime.now();
  DateTime dateExp = DateTime.now();
  final List<String> _items = ['Masculin', 'Feminin'].toList();
  int compteur = 0;
  String _selection;
  Future<Null> _selectDateNaiss(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );
    setState(() {
      dateNaiss = picked;
    });
  }

  Future<List> _getCode() async {
    final response =
        await http.post(PubCon.cheminPhp + "GetidEncours.php", body: {});
    //print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
    } else {
      if (mounted) {
        setState(() {
          for (int h = 0; h < datauser.length; h++) {
            ClsReservation.idReservation =
                datauser[h]['IdEncours'].toString() == null
                    ? 0
                    : int.parse(datauser[h]['IdEncours'].toString());
          }
        });
      }
    }
    return datauser;
  }

  @override
  void initState() {
    
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
        _selection = _items.first;
    _getCode();
    if (CritereSelect.course == 2) {
                                          
                                              setState(() {
                                                CritereSelect.nbrePassager=CritereSelect.nbrePassager+CritereSelect.nbrePassager;
                                              });
                                          
                                        }
  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }

//initialisation
  void innitialiser() {
    cNom.text = "";
    cPrenom.text = "";
    cDateNaiss.text = "";
    cAdresse.text = "";
    cContactMail.text = "";
    cContactPhone.text = "";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;

  bool _value1 = false;
  bool _autoValidate = false;

  //void _value1Changed(bool value) => setState(() => _value1 = value);

  void _validateInputs(int id, BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      //    If all data are correct then save data to out variables
      _formKey.currentState.save();
      //save user in the database
      saveUser(id, ctx);
    } else {
      //    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

//INSERTION IDENTITE DU PASSAGER
  Future saveUser(int idReservation, BuildContext ctx) async {
    try {
      var uri = Uri.parse(PubCon.cheminPhp + "insertDetailReservation.php");
      var request = new http.MultipartRequest("POST", uri);
      request.fields['nomClient_billet'] = cNom.text;
      request.fields['LastNameClient_billet'] = cPrenom.text;
      request.fields['Genre'] = '' + _selection;
      request.fields['dateNaissance'] = dateNaiss.toString();
      request.fields['adresseClient_billet'] = cAdresse.text;
      request.fields['contactClient_billet'] = cContactPhone.text;
      request.fields['refRservation'] = '$idReservation';
      request.fields['Mail_client'] = cContactMail.text;
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Enregistrement reussi");
        Fluttertoast.showToast(
            msg: 'Passager Enregistré',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,
            textColor: Colors.black);
        innitialiser();
        //if(mounted){
        // setState(() {
        //   compteur++;
        // });
        //}
        //PubCon.showDialogcz(ctx, "Confirm", "Enregistrement reussi");
      } else {
        print("Echec d'enregistrement");
        Fluttertoast.showToast(
            msg: 'Echec Enregistrement',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          textColor: Colors.black);
      innitialiser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = _items
        .map((String item) =>
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Passager $compteur/${CritereSelect.nbrePassager} \n ${widget.code1 == null ? "" : widget.code1} ${widget.code2 == null ? "" : widget.code2}'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                //___on passe au paiement___
                if (compteur == 0) {
                  Fluttertoast.showToast(
                      msg: 'veillez enregistrer vos identités SVP!!!',
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.white,
                      textColor: Colors.black);
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyFacture(
                            idReservation: widget.code1,
                          )));
                }
              })
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Column(children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: viewportConstraints.maxHeight - 48.0,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextField(
                              controller: cNom,
                              decoration: InputDecoration(
                                icon:
                                    Icon(Icons.text_fields, color: Colors.blue),
                                labelText: "Nom",
                              ),
                              onChanged: (text) {}),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextField(
                              controller: cPrenom,
                              decoration: InputDecoration(
                                icon:
                                    Icon(Icons.text_fields, color: Colors.blue),
                                labelText: "Prenom",
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: new DropdownButtonFormField(
                            value: _selection,
                            items: dropdownMenuOptions,
                            onChanged: (s) {
                              setState(() {
                                _selection = s;
                              });
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.people,
                                color: Colors.blue,
                              ),
                              //       border: new OutlineInputBorder(
                              //  borderRadius: new BorderRadius.circular(20.0)),
                              hintText: '       ---Sexe---',
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextField(
                            maxLines: 2,
                            controller: cDateNaiss,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.blue,
                              ),
                              hintText: 'Date Naissance :\n' +
                                  f.format(dateNaiss).toString(),
                            ),
                            onTap: () {
                              _selectDateNaiss(context);
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextField(
                              controller: cAdresse,
                              decoration: InputDecoration(
                                icon: Icon(Icons.map, color: Colors.blue),
                                labelText: "Adresse ou Ville de residence",
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: cContactPhone,
                              decoration: InputDecoration(
                                icon: Icon(Icons.phone, color: Colors.blue),
                                labelText: "Tel.",
                              )),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                          child: TextFormField(
                              validator: validateEmail,
                              onSaved: (value) {
                                if (value.isEmpty) {
                                  return 'Entrez votre Adresse Mail';
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: cContactMail,
                              decoration: InputDecoration(
                                icon: Icon(Icons.mail, color: Colors.blue),
                                labelText: "Mail",
                              )),
                        ),
                        Expanded(child: Container()),
                        Divider(
                          color: Colors.blue,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, top: 8.0),
                                child: RaisedButton(
                                    onPressed: () {
                                      if (CritereSelect.nbrePassager >
                                          compteur) {
                                        //appel fx d
                                        _validateInputs(widget.code1, context);
                                        setState(() {
                                         compteur++; 
                                        });
                                        //meme id pour le retour
                                        if (CritereSelect.course == 2) {
                                          _validateInputs(
                                              widget.code2, context);
                                              // setState(() {
                                              //   compteur--;
                                              // });
                                          
                                        }
                                        if (compteur ==
                                            CritereSelect.nbrePassager) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MyFacture(
                                                            idReservation:
                                                                widget.code1,
                                                          )));
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Vous avez atteint votre limite de nombre de passager',
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black);
                                      }
                                    },
                                    child: Text("AJOUTER")
                                    // Icon(Icons.verified_user, size: 36.0),
                                    ),
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                            //     child: RaisedButton(
                            //       color: Colors.blue,
                            //       textColor: Colors.white,
                            //       onPressed: () {
                            //                //___on passe au paiement___
                            //                if(compteur==0)
                            //                Fluttertoast.showToast(msg:'veillez enregistrer vos identités SVP!!!',toastLength:Toast.LENGTH_LONG,
                            //           backgroundColor:Colors.white,textColor:Colors.black);
                            //           else
                            //                Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //       builder: (BuildContext context) =>
                            //           MyFacture()));
                            //       },
                            //       child: Text("TERMINER")
                            //       //Icon(Icons.navigate_next, size: 36.0),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Divider(
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
        ]);
      }),
    );
  }

  String validateEmail(String value) {
    if (value.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  CurvedAnimation _buildInputAnimation({double begin, double end}) {
    return new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(begin, end, curve: Curves.linear));
  }
}
