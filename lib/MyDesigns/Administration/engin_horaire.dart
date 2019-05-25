
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/engin_horaireList.dart';
import 'package:flights_app/MyDesigns/DialogComponents/lieu_to_select.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class Horaire extends StatefulWidget {
  final NosHorairesFull value;
  final String action,refEngin;

  const Horaire({Key key, this.value, this.action, this.refEngin}) : super(key: key);
  @override
  HoraireState createState() {
    return new HoraireState();
  }
}

class HoraireState extends State<Horaire>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController 
cLieuDepart=new TextEditingController(),
cLieuArret=new TextEditingController(),
cHeureDepart=new TextEditingController(),
cHeureArrive=new TextEditingController()
;
final List<String> _items1 = ['LUNDI', 'MARDI','MERCREDI','JEUDI','VENDREDI','SAMEDI','DIMANCHE'].toList();
  String _selectionJours;
final List<String> _items2 = ['aller', 'retour'].toList();
  String _selectionTypeCourse;
  @override
  void initState() {
    _selectionJours = _items1.first;
    _selectionTypeCourse = _items2.first;
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
  cHeureArrive.text="";
  cLieuDepart.text="";
  cHeureDepart.text="";
  cLieuArret.text="";
}
void populate(){
  if(widget.action=='update'){
    _selectionJours='${widget.value.jourH}';
    _selectionTypeCourse='${widget.value.typeCourseH}';
    cLieuDepart.text='${widget.value.lieuDepH}';
    CritereSelect.depart='${widget.value.lieuDepH}';
    cLieuArret.text='${widget.value.lieuArriveH}';
    CritereSelect.arrive='${widget.value.lieuArriveH}';
    cHeureDepart.text='${widget.value.heureDepH}';
    cHeureArrive.text='${widget.value.heureArriveH}';
  }
}
//INSERTION HORAIRE
Future saveHoraire() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertHoraire.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['Jours'] =''+_selectionJours;
    request.fields['typeCourse'] =''+_selectionTypeCourse;
    request.fields['LieuDepart'] = CritereSelect.depart;
    request.fields['LieuArret'] = CritereSelect.arrive;
    request.fields['heureDepart'] = cHeureDepart.text;
    request.fields['heureArrive'] = cHeureArrive.text;
    request.fields['refEngin'] = '${widget.refEngin}';
    request.fields['refAgence'] = '${PubCon.userIdAgence}';
    
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Enregistrement reussi");
      Fluttertoast.showToast(msg:'Horaire Enregistré',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
                              innitialiser();
      //PubCon.showDialogcz(ctx, "Confirm", "Enregistrement reussi");
    } else {
      print("Echec d'enregistrement");
      Fluttertoast.showToast(msg:'Echec Enregistrement',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
    }
  }
//MODIFICATION HORAIRE
Future updateHoraire() async {
  try{
    var uri = Uri.parse(PubCon.cheminPhp + "updateHoraire.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['codeHoraire'] ='${widget.value.codeH}';
    request.fields['Jours'] =''+_selectionJours;
    request.fields['typeCourse'] =''+_selectionTypeCourse;
    request.fields['LieuDepart'] = CritereSelect.depart;
    request.fields['LieuArret'] = CritereSelect.arrive;
    request.fields['heureDepart'] = cHeureDepart.text;
    request.fields['heureArrive'] = cHeureArrive.text;
    request.fields['refEngin'] = '${widget.refEngin}';
    request.fields['refAgence'] = '${PubCon.userIdAgence}';
    
    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg:'Horaire Modifié',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
                              innitialiser();
      //PubCon.showDialogcz(ctx, "Confirm", "Enregistrement reussi");
    } else {
      Fluttertoast.showToast(msg:'Echec de Modification',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
    }
  }catch(e){
    throw new Exception("");
  }
  }

void testActionDo(){
  if(widget.action=="insert"){saveHoraire();}
  else if(widget.action=="update"){updateHoraire();}
}

  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = _items1
        .map((String item) =>
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
        final dropdownMenuOptions2 = _items2
        .map((String item) =>
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();

        populate();
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('action: ${widget.action}',style:TextStyle(color: Colors.blue),),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: (){
            testActionDo();

          },
        )
      ],
      ),
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
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                        child: new DropdownButtonFormField(
                          value: _selectionJours,
                          items: dropdownMenuOptions,
                          onChanged: (s) {
                            setState(() {
                              _selectionJours = s;
                            });
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.calendar_view_day,
                              color: Colors.blue,
                            ),
                      //       border: new OutlineInputBorder(
                      //  borderRadius: new BorderRadius.circular(20.0)),
                            //hintText: '       ---Sexe---',
                          ),
                        ),
                      ),
                  Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                        child: new DropdownButtonFormField(
                          value: _selectionTypeCourse,
                          items: dropdownMenuOptions2,
                          onChanged: (s) {
                            setState(() {
                              _selectionTypeCourse = s;
                            });
                          },
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.directions,
                              color: Colors.blue,
                            ),
                      //       border: new OutlineInputBorder(
                      //  borderRadius: new BorderRadius.circular(20.0)),
                            //hintText: '       ---Sexe---',
                          ),
                        ),
                      ),
                      Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
              child: TextField(
                maxLines: 2,
                controller: cLieuDepart,
                decoration: InputDecoration(
                  icon: Icon(
                              Icons.directions,
                              color: Colors.blue,
                            ),
                  //labelText: "Depart",
                  hintText: 'Depart:\n'+CritereSelect.depart.toString()
                ),
                onTap: (){
                  CritereSelect.est_Depart_Ou_Arrive=1;
                  showMyDialog("Depart");
                  
                },
              ),
            ),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                child: TextField(
                  controller: cHeureDepart,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer, color: Colors.blue),
                    labelText: "Heure de Depart",
                  )),),
                  Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
              child: TextField(
                maxLines: 2,
                controller: cLieuArret,
                decoration: InputDecoration(
                  icon: Icon(
                              Icons.directions,
                              color: Colors.blue,
                            ),
                  //labelText: "Destination",
                  hintText: 'destination:\n ${CritereSelect.arrive}'
                ),
                onTap: (){
                  CritereSelect.est_Depart_Ou_Arrive=2;
                  showMyDialog('Destination');
                                  },
                                  
                                ),
                              ),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: cHeureArrive,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer_off, color: Colors.blue),
                    labelText: "Heure d'Arrivé",
                  )),),
              Expanded(child: Container()),
              // Divider(color: Colors.blue,),
              //   Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
              //           child: RaisedButton(
              //             onPressed: () {
                            
              //             },
              //             child:Text("AJOUTER")
              //             // Icon(Icons.verified_user, size: 36.0),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),

              // Divider(color: Colors.blue,),
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
void showMyDialog(String title) {
                      showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                          title: new Text("$title",textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                              )),
                          content:
                              new Container(
                                  height: MediaQuery.of(context).size.height, 
                                  width: MediaQuery.of(context).size.width,
                                  child: LieuSelect()),
                           
                        ));
                    }




}
