
import 'package:flights_app/MyClasses/clsReservation.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/facture_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class IdentitePassager extends StatefulWidget {
  @override
  IdentitePassagerState createState() {
    return new IdentitePassagerState();
  }
}

class IdentitePassagerState extends State<IdentitePassager>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController cNom=new TextEditingController(),
cPrenom=new TextEditingController(),
cGenre=new TextEditingController(),
cAdresse=new TextEditingController(),
cContactPhone=new TextEditingController(),
cContactMail=new TextEditingController(),
cCodePostal=new TextEditingController(),
cNationnalite=new TextEditingController(),
cNumeroPassport=new TextEditingController(),
cDateExp=new TextEditingController(),
cDateNaiss=new TextEditingController()
;
final f=new DateFormat('yyyy-MM-dd');
DateTime dateNaiss=DateTime.now();
DateTime dateExp=DateTime.now();
final List<String> _items = ['M', 'F'].toList();

  String _selection;
Future<Null> _selectDateNaiss(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   dateNaiss =picked;
                  });
}
Future<Null> _selectDateExp(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   dateNaiss =picked;
                  });
}
  @override
  void initState() {
    _selection = _items.first;
    super.initState();
    textInputAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));

  }

  @override
  void dispose() {
    textInputAnimationController.dispose();
    super.dispose();
  }
//initialisation
void innitialiser(){
  cNom.text="";
  cPrenom.text="";
  cDateNaiss.text="";
  cDateExp.text="";
  cAdresse.text="";
  cContactMail.text="";
  cContactPhone.text="";
  cCodePostal.text="";
  cNationnalite.text="";
  cNumeroPassport.text="";
}
//INSERTION IDENTITE DU PASSAGER
Future saveUser() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertDetailReservation.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['nomClient_billet'] = cNom.text;
    request.fields['LastNameClient_billet'] = cPrenom.text;
    request.fields['Genre'] =''+_selection;
    request.fields['dateNaissance'] =dateNaiss.toString() ;
    request.fields['adresseClient_billet'] = cAdresse.text;
    request.fields['contactClient_billet'] = cContactPhone.text;
    request.fields['refRservation'] = '${ClsReservation.idReservation}';
    request.fields['Mail_client'] = cContactMail.text;
    request.fields['codePostal_client'] = cCodePostal.text;
    request.fields['Nationnalite_client'] = cNationnalite.text;
    request.fields['NumeroPasseport'] = cNumeroPassport.text;
    request.fields['DateExpirationPassport'] = dateExp.toString();
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Enregistrement reussi");
      Fluttertoast.showToast(msg:'Passager Enregistré',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
                              innitialiser();
      //PubCon.showDialogcz(ctx, "Confirm", "Enregistrement reussi");
    } else {
      print("Echec d'enregistrement");
      Fluttertoast.showToast(msg:'Echec Enregistremznt',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
    }
  }



  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = _items
        .map((String item) =>
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
    return 
    
    Scaffold(
      appBar: AppBar(title: Text('Reservation ID. ${ClsReservation.idReservation}'),),
      body: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Column(
                children: <Widget>[
    Expanded(
      child:
      SingleChildScrollView(child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: viewportConstraints.maxHeight - 48.0,
          ),
        child: IntrinsicHeight(child:
        Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cNom,
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields, color: Colors.red),
                    labelText: "Nom",
                  ),
                  onChanged:(text){
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cPrenom,
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields, color: Colors.red),
                    labelText: "Prenom",
                  )),),
                  Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
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
                              color: Colors.red,
                            ),
                      //       border: new OutlineInputBorder(
                      //  borderRadius: new BorderRadius.circular(20.0)),
                            hintText: '       ---Sexe---',
                          ),
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                      child: TextField(
                         maxLines: 2,
                       controller: cDateNaiss,
                       decoration: InputDecoration(
                        icon: Icon(Icons.date_range,color: Colors.red,),
                         hintText: 'Date Naissance :\n'+f.format(dateNaiss).toString(),
                         
                       ),
                       onTap:(){_selectDateNaiss(context);
                  
                       },
                      ),
                    ),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cAdresse,
                  decoration: InputDecoration(
                    icon: Icon(Icons.map, color: Colors.red),
                    labelText: "Adresse de residence",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: cContactPhone,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.red),
                    labelText: "Tel.",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: cContactMail,
                  decoration: InputDecoration(
                    icon: Icon(Icons.mail, color: Colors.red),
                    labelText: "Mail",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cNationnalite,
                  decoration: InputDecoration(
                    icon: Icon(Icons.location_city, color: Colors.red),
                    labelText: "Nationalite",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cCodePostal,
                  decoration: InputDecoration(
                    icon: Icon(Icons.local_post_office, color: Colors.red),
                    labelText: "Code Postal",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cNumeroPassport,
                  decoration: InputDecoration(
                    icon: Icon(Icons.card_travel, color: Colors.red),
                    labelText: "Numero Passport",
                  )),),
              Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                      child: TextField(
                         maxLines: 2,
                       controller: cDateExp,
                       decoration: InputDecoration(
                        icon: Icon(Icons.date_range,color: Colors.red,),
                         hintText: 'Date Expiration :\n'+f.format(dateExp).toString(),
                         
                       ),
                       onTap:(){_selectDateExp(context);
                  
                       },
                      ),
                    ),
              Expanded(child: Container()),
              Divider(color: Colors.red,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                                   //appel fx d
                                   saveUser();
                          },
                          child: Icon(Icons.verified_user, size: 36.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                        child: RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                                   //___on passe au paiement___
                                   Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyFacture()));
                          },
                          child: Icon(Icons.navigate_next, size: 36.0),
                        ),
                      ),
                    ),
                  ],
                ),

              Divider(color: Colors.red,),
            ],
          ),
        ),
      ),
        
        ),),)
       
    )]);}),
      
    );
  }

  CurvedAnimation _buildInputAnimation({double begin, double end}) {
    return new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(begin, end, curve: Curves.linear)
    );
  }

}
