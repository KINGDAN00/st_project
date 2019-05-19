import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/MyDesigns/Administration/categorie_charge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class DetailAgence extends StatefulWidget {
  final CategorieFull value;

  const DetailAgence({Key key, this.value}) : super(key: key);
  @override
  DetailAgenceState createState() {
    return new DetailAgenceState();
  }
}

class DetailAgenceState extends State<DetailAgence>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController 
cValidite=new TextEditingController()
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
  cValidite.text="";
}
//INSERTION CLASSE
Future saveDetAgence() async {
    var uri = Uri.parse(PubCon.cheminPhp + "insertDetailAgence.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['validite'] = cValidite.text;
    request.fields['refCategirieengin'] = '${widget.value.codeCatEngin}';
    request.fields['refAgence'] = PubCon.userIdAgence;
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
        title: Text('Detail',style:TextStyle(color: Colors.blue),),
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: (){
            saveDetAgence();

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
                  keyboardType: TextInputType.number,
                  controller: cValidite,
                  decoration: InputDecoration(
                    icon: Icon(Icons.timer, color: Colors.blue),
                    labelText: "Validité",
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
