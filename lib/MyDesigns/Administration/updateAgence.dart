import 'dart:io';
import 'package:async/async.dart';
import 'package:flights_app/MyClasses/clsAgence.dart';
import 'package:flights_app/MyClasses/components.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UpdateAgence extends StatefulWidget {
  @override
  _UpdateAgenceState createState() => _UpdateAgenceState();
}

class _UpdateAgenceState extends State<UpdateAgence> {

TextEditingController cNomAgence = new TextEditingController(),
      cContactMail = new TextEditingController(),
      cContactPhone = new TextEditingController(),
      // cUsername = new TextEditingController(),
      cpassword = new TextEditingController();
  File _image;
  FocusNode focusNode1;
  FocusNode focusNode2;
  FocusNode focusNode3;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;


  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
  }

void populateAg(){
  cNomAgence.text=PubCon.userNomComplet;
  cContactMail.text=AgenceCls.adresseMail;
  cContactPhone.text=AgenceCls.numTel;
  cpassword.text="";

}

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    populateAg();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueAccent[300],
                  ),
                  clipper: RoundedClipper(60),
                ),
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueAccent,
                  ),
                  clipper: RoundedClipper(50),
                ),
                Positioned(
                    top: -50,
                    left: -30,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Colors.blueAccent.withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blueAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.20) / 2),
                          color: Colors.blue[300].withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blueAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: 80,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Colors.deepOrange[300].withOpacity(0.3)),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15 - 50),
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Update Info",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        '#00${PubCon.userIdAgence}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.80) - 22,
            margin: EdgeInsets.fromLTRB(20, 12, 20, 10),
            child: 
          Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: 
              ListView(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez le nom';
                      }
                    },
                    obscureText: false,
                    controller: cNomAgence,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Noms *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(focusNode1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    onSaved:(value) {
                      if (value.isEmpty) {
                        return 'Entrez votre Adresse Mail';
                      }
                    },
                    obscureText: false,
                    controller: cContactMail,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Adresse Mail *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(focusNode1);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez votre Numéro de Telephone';
                      }
                    },
                    obscureText: false,
                    controller: cContactPhone,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Telephone *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(focusNode1);
                    },
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return 'Entrez votre username ';
                  //     }
                  //   },
                  //   obscureText: false,
                  //   controller: cUsername,
                  //   keyboardType: TextInputType.text,
                  //   style: TextStyle(fontSize: 16, color: Colors.black),
                  //   textInputAction: TextInputAction.next,
                  //   decoration: InputDecoration(
                  //     labelText: "Username *",
                  //     contentPadding: new EdgeInsets.symmetric(
                  //         vertical: MediaQuery.of(context).size.height * 0.022,
                  //         horizontal: 15.0),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(25)),
                  //     ),
                  //   ),
                  //   onFieldSubmitted: (String value) {
                  //     FocusScope.of(context).requestFocus(focusNode1);
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: validatePassword,
                    onSaved: (String val) {
                      _password = val;
                    },
                    focusNode: focusNode3,
                    obscureText: true,
                    controller: cpassword,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Password *",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
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
                  SizedBox(
                    height: 10,
                  ),
                  
                  
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          //print("pressed");
                          _validateInputs(_image, context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Text(
                              "UPDATE",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          //print("pressed");
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle),
                            child:
                                Icon(Icons.arrow_back, color: Colors.white))),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  
                ],
              ),
            ),
          )
      ],
       ),
    );
  }

 // bool _value1 = false;
  bool _autoValidate = false;

  //void _value1Changed(bool value) => setState(() => _value1 = value);

  void _validateInputs(File imageFile, BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      //    If all data are correct then save data to out variables
      _formKey.currentState.save();
      //save user in the database
      updateAgence(imageFile, ctx);
    } else {
      //    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
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

//procedure for update
Future updateAgence(File imageFile, BuildContext ctx) async {
    try{
      var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(PubCon.cheminPhp + "updateAgence.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['codeAgence'] =PubCon.userIdAgence;
    request.fields['nomAgence'] = cNomAgence.text;
    request.fields['email'] = cContactMail.text;
    request.fields['contactAgence'] = cContactPhone.text;
    request.fields['passwordAgence'] = cpassword.text;
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      //print("Modification reussi");
      Fluttertoast.showToast(msg:'Agence Modifié',toastLength:Toast.LENGTH_SHORT,
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



}

class RoundedClipper extends CustomClipper<Path> {
  var differenceInHeights = 0;

  RoundedClipper(int differenceInHeights) {
    this.differenceInHeights = differenceInHeights;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
