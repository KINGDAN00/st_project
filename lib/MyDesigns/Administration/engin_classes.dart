import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/engin_charge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class ClasseEngin extends StatefulWidget {
  final NosEnginsFull value;

  const ClasseEngin({Key key, this.value}) : super(key: key);
  @override
  ClasseEnginState createState() {
    return new ClasseEnginState();
  }
}

class ClasseEnginState extends State<ClasseEngin>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController cClasse=new TextEditingController(),
cNombrePlace=new TextEditingController(),
cPrix=new TextEditingController()
;

  @override
  void initState() {
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
  cClasse.text="";
  cNombrePlace.text="";
  cPrix.text="";
}
//INSERTION CLASSE
Future saveClass() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertDetailEngin.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['refClasse'] = cClasse.text;
    request.fields['nombrePlace'] = cNombrePlace.text;
    request.fields['prixClasse'] = cPrix.text;
    request.fields['refEngin'] = '${widget.value.codeEngin}';
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Enregistrement reussi");
      Fluttertoast.showToast(msg:'Class Enregistré',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
                              innitialiser();
      //PubCon.showDialogcz(ctx, "Confirm", "Enregistrement reussi");
    } else {
      print("Echec d'enregistrement");
      Fluttertoast.showToast(msg:'Echec Enregistrement',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
    }
  }



  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Engin: ${widget.value.designationEngin}',style:TextStyle(color: Colors.blue),),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: (){
            saveClass();

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
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  controller: cClasse,
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields, color: Colors.blue),
                    labelText: "Classe",
                  ),
                  onChanged:(text){
                  }
                ),
              ),
                 
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: cNombrePlace,
                  decoration: InputDecoration(
                    icon: Icon(Icons.more, color: Colors.blue),
                    labelText: "Nombre de Places",
                  )),),
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: cPrix,
                  decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on, color: Colors.blue),
                    labelText: "Prix",
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
              //               saveClass();
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

}
