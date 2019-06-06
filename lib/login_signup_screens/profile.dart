import 'dart:io';
import 'dart:math' as Math;
import 'package:async/async.dart';
import 'package:image/image.dart' as Img;
import 'package:http/http.dart' as http;
import 'package:flights_app/MyClasses/components.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
@override
void initState() { 
  _selection = _items.first;
  super.initState();
  
}

  TextEditingController user= new TextEditingController(),
      pass = new TextEditingController(),
      sexe = new TextEditingController(),
      solde = new TextEditingController(),
      email = new TextEditingController(),
      numPhone = new TextEditingController(),
      nationalite = new TextEditingController(),
      dateNaissance = new TextEditingController(),
      codePostale = new TextEditingController(),
      numPassport = new TextEditingController(),
      adresse = new TextEditingController(),
      prenom = new TextEditingController(),
      nom = new TextEditingController();
      //=================================================================================================
      File _image;

final f=new DateFormat('yyyy-MM-dd');
DateTime date=DateTime.now();
DateTime dateExP=DateTime.now();
void _selectDate(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   date =picked;
                  });
}
      //==================
      Future getImageGallery() async{
  try{
var imageFile=await ImagePicker.pickImage(source: ImageSource.gallery);

final tempDir=await getTemporaryDirectory();
final path=tempDir.path;
//String title=ctitle.text;
int rand=new Math.Random().nextInt(1000000);
Img.Image image=Img.decodeImage(imageFile.readAsBytesSync());
Img.Image smallerImg=Img.copyResize(image, 500);
var compressImg=new File("$path/image_$rand.jpg")
..writeAsBytesSync(Img.encodeJpg(smallerImg,quality: 85));

setState(() {
 _image=compressImg; 
});
  }catch(ex){
    print('Erreur $ex');
  }

}
Future getImageCamera() async{
try{
var imageFile=await ImagePicker.pickImage(source: ImageSource.camera);
final tempDir=await getTemporaryDirectory();
final path=tempDir.path;
//String title=ctitle.text;
int rand=new Math.Random().nextInt(1000000);
Img.Image image=Img.decodeImage(imageFile.readAsBytesSync());
Img.Image smallerImg=Img.copyResize(image, 500);
var compressImg=new File("$path/image_$rand.jpg")
..writeAsBytesSync(Img.encodeJpg(smallerImg,quality: 85));

setState(() {
 _image=compressImg; 
});
}catch(ex){
  print('Erreur $ex');
}
}
bool _autoValidate = false;

  //void _value1Changed(bool value) => setState(() => _value1 = value);

  void _validateInputs(File imageFile, BuildContext ctx) {
    if(PubCon.userId=='-1'){
      Fluttertoast.showToast(msg:'Vous n\'etes pas connecté svp!!!',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.red);
    }else{
       if (_formKey.currentState.validate()) {
      //    If all data are correct then save data to out variables
      _formKey.currentState.save();
      //save user in the database
      updateProfile(imageFile, ctx);
    } else {
      //    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
    }
   
  }

  String validateEmail(String value) {
    if (!value.isEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 4)
      return 'Password doit avoir au minimum 4 caracteres';
    else
      return null;
  }
  final List<String> _items = ['Masculin', 'Feminin'].toList();
  String _selection;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
//procedure for update
Future updateProfile(File imageFile, BuildContext ctx) async {
    try{
      var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(PubCon.cheminPhp + "updateCompte.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['codeCompte'] =PubCon.userId;
    request.fields['nomClient'] = nom.text;
    request.fields['prenom'] = prenom.text;
    request.fields['adresseClient'] = adresse.text;
    request.fields['contactClient'] = numPhone.text;
    request.fields['usernameClient'] = user.text;
    request.fields['passwordClient'] = pass.text;
    request.fields['code_postal'] = codePostale.text;
    request.fields['Nationnalite'] = nationalite.text;
    request.fields['NumeroPasseport'] = numPassport.text;
    request.fields['DateExpirationPasseport'] =dateExP.toString();
    request.fields['sexe'] = ''+_selection;
    request.fields['datenaissance'] =date.toString();
    request.fields['email'] = email.text;

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      //print("Modification reussi");
      Fluttertoast.showToast(msg:'Modification reussie',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.black);
      Navigator.pop(ctx);
    } else {
      //print("Echec de Modification");
      Fluttertoast.showToast(msg:'Echec Modification',toastLength:Toast.LENGTH_SHORT,
                              backgroundColor:Colors.white,textColor:Colors.red);
    }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = _items
        .map((String item) =>
            new DropdownMenuItem<String>(value: item, child: new Text(item)))
        .toList();
        solde.text=PubCon.userSolde;
    user.text=PubCon.userName;
    nom.text=PubCon.userNomComplet;
    prenom.text=PubCon.userPrenom;
    _selection=PubCon.userSexe==""? "Masculin" : PubCon.userSexe;
    _image=new File("${PubCon.cheminPhoto}${PubCon.userImage}");
    //pass.text=PubCon.userPass;
    nationalite.text=PubCon.userNationalite;
    sexe.text=PubCon.userNationalite;
    dateNaissance.text=PubCon.userDateNaissance;
    //date=PubCon.userDateNaissance==null? null : Datetime.parse(PubCon.userDateNaissance);
    codePostale.text=PubCon.userCodePostale;
    numPassport.text=PubCon.userNumeroPassport;
    email.text=PubCon.userEmail;
    numPhone.text=PubCon.userPhone;
    //dateExP=PubCon.userDateExpPass==null? null :DateTime.parse(PubCon.userDateExpPass);
        return Scaffold(
      appBar: AppBar(centerTitle: true,
        title:new Text("Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.blue,),
    body:
      Form(
              key: _formKey,
              autovalidate: _autoValidate,
      child: ListView(
        children: <Widget>[
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[
                  Expanded(
child:Column(
                            children: <Widget>[
                              RaisedButton(
                                elevation: 5.0,
                                color: Colors.white,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.blue,
                                ),
                                onPressed: getImageGallery,
                              ),
                              RaisedButton(
                                elevation: 5.0,
                                color: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                ),
                                onPressed: getImageCamera,
                              ),
                            ],
                          ),

                  ),
                  Expanded(
                    // height: 150,
                    // width: 150,
                    child: Componentss.manageImage(context, PubCon.userImage)
                    // CircleAvatar(
                    //   radius: 40,
                      
                    //             child: new FlatButton(
                    //               onPressed: () {
                    //               },
                    //               child: null,
                    //             ),
                                
                    //           ),
                  ),
                  Expanded(
                    child: SizedBox(
                            height: 100.0,
                            child: Align(
                              alignment: Alignment.center,
                                child: _image == null
                                    ? 
                                    Componentss.manageImage(context, PubCon.userImage)
                                    // new Text(
                                    //     "No image selected!",
                                    //     textAlign: TextAlign.center,
                                    //   )
                                    : new Image.file(_image,fit:BoxFit.cover,)),
                          ),

                  )
                  
                ],
              ),
            Divider(),
            Padding(
                      padding: EdgeInsets.all(2.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                       controller:solde ,
                       enabled: false,
                       decoration: InputDecoration(
                         icon: Icon(Icons.monetization_on,color: Colors.grey,),
                         hintText: 'Solde',
                         labelText: 'Solde',
                          border: new OutlineInputBorder(
                       borderRadius: new BorderRadius.circular(20.0)
                   ),
                       ),
                      
                   ),
                    ),
                     Divider(),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: nom,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.verified_user,color: Colors.grey,),
                         hintText: 'Nom',
                         labelText: 'Nom'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: prenom,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.verified_user,color: Colors.grey,),
                         hintText: 'Prenom',
                         labelText: 'Prenom'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),
                    ),
                    Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: user,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.text_fields,color: Colors.grey,),
                         fillColor: Colors.red,
                         hintText: 'username',
                         labelText: 'username'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),
                    ),
                    Padding(padding: EdgeInsets.all(2.0),
                    child: TextFormField(
                    validator: validatePassword,
                    onSaved: (String val) {
                      _password = val;
                    },
                    //focusNode: focusNode3,
                    obscureText: true,
                    controller: pass,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_open),
                      labelText: "Password *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(25)),
                      // ),
                    ),
                  ),
                    ),
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
                            ),
                      //       border: new OutlineInputBorder(
                      //  borderRadius: new BorderRadius.circular(20.0)),
                            hintText: '       ---Sexe---',
                          ),
                        ),
                      ),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                                         maxLines: 2,
                                       controller: dateNaissance,
                                       decoration: InputDecoration(
                                         icon: Icon(Icons.date_range,color: Colors.grey,),
                                         labelText: 'Date de Naissance',
                                         hintText: 'Date Naissance :\n'+(date==null? '':f.format(date).toString()),
                                         
                                       ),
                                       onTap:(){_selectDate(context);
                                  
                                       },
                                      ),),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: nationalite,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.person,color: Colors.grey,),
                         hintText: 'Nationalite',
                         labelText: 'Nationalite'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: codePostale,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.local_post_office,color: Colors.grey,),
                         hintText: 'CodePostale',
                         labelText: 'Code Postale'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: numPhone,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.contact_phone,color: Colors.grey,),
                         hintText: 'Tel',
                         labelText: 'Numero Telephone'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextFormField(
                    validator: validateEmail,
                    onSaved:(value) {
                      if (value.isEmpty) {
                        return 'Entrez votre Adresse Mail';
                      }
                    },
                    obscureText: false,
                    controller: email,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Adresse Mail *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(25)),
                      // ),
                    ),
                    // onFieldSubmitted: (String value) {
                    //   FocusScope.of(context).requestFocus(focusNode1);
                    // },
                  ),),
                   Padding(padding: EdgeInsets.all(2.0),
                    child: TextField(
                       controller: numPassport,
                       enabled: true,
                       decoration: InputDecoration(
                         icon: Icon(Icons.confirmation_number,color: Colors.grey,),
                         hintText: 'NumPassport',
                         labelText: 'Numero Passport'
                  //         border: new OutlineInputBorder(
                  //      borderRadius: new BorderRadius.circular(20.0)
                  //  ),
                       ),
                      
                   ),),
                   RaisedButton(
                     child: Text("MODIFIER"),
                     onPressed: (){
                       _validateInputs(_image, context);
                     },
                   )

        ],
      ),
    )
    
    );
    
  }
}