import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/categorie_charge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class Engin extends StatefulWidget {
  final CategorieFull value;

  const Engin({Key key, this.value}) : super(key: key);
  @override
  EnginState createState() {
    return new EnginState();
  }
}

class EnginState extends State<Engin>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController cDesignationEngin=new TextEditingController(),
cMatriculeEngin=new TextEditingController()
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
  cDesignationEngin.text="";
  cMatriculeEngin.text="";
}
//INSERTION CLASSE
Future saveEngin() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertEngin.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['designationEngin'] = cDesignationEngin.text;
    request.fields['matriculeEngin'] = cMatriculeEngin.text;
    request.fields['refAgence'] = PubCon.userIdAgence;
    request.fields['refCategorieEngin'] = '${widget.value.codeCatEngin}';
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Enregistrement reussi");
      Fluttertoast.showToast(msg:'Engin Enregistré',toastLength:Toast.LENGTH_SHORT,
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
        title: Text('Categorie: ${widget.value.designeCatEngin}',style:TextStyle(color: Colors.blue),),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: (){
            saveEngin();

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                child: TextField(
                  controller: cDesignationEngin,
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields, color: Colors.blue),
                    labelText: "Nom de l'Engin",
                  ),
                  onChanged:(text){
                  }
                ),
              ),
                 
                  Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 32.0, 8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: cMatriculeEngin,
                  decoration: InputDecoration(
                    icon: Icon(Icons.code, color: Colors.blue),
                    labelText: "Matricule",
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
