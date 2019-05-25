import 'package:flights_app/MyClasses/components.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController user= new TextEditingController(),
      pass = new TextEditingController(),
      nom = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    user.text=PubCon.userName;
    nom.text=PubCon.userNomComplet;
    pass.text=PubCon.userPass;
        return Scaffold(
      appBar: AppBar(centerTitle: true,
        title:new Text("Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.blue,),
    body:ListView(
      children: <Widget>[
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
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
              ],
            ),
          
                //   Padding(padding: EdgeInsets.all(4.0),),
                //   Divider(),
                //   Padding(padding: EdgeInsets.all(2.0),
                //   child: TextField(
                //      controller: solde,
                //      enabled: false,
                //      decoration: InputDecoration(
                //        icon: Icon(Icons.attach_money,color: Colors.grey,),
                //        hintText: 'Solde',
                //        labelText: 'Solde'
                // //         border: new OutlineInputBorder(
                // //      borderRadius: new BorderRadius.circular(20.0)
                // //  ),
                //      ),
                    
                //  ),
                //   ),
                   Divider(),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: nom,
                     enabled: false,
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
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: user,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.text_fields,color: Colors.grey,),
                       hintText: 'username',
                       labelText: 'username'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: pass,
                     enabled: false,
                     obscureText: true,
                     decoration: InputDecoration(
                       icon: Icon(Icons.security,color: Colors.grey,),
                       hintText: 'Password',
                       labelText: 'Password'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),

      ],
    )
    
    );
    
  }
}