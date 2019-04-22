import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController user= new TextEditingController(),
      pass = new TextEditingController(),
      nom = new TextEditingController(),
      sexe = new TextEditingController(),
      date = new TextEditingController(),
      contact = new TextEditingController(),
      solde = new TextEditingController(),
      adress = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    user.text="xxx";
    sexe.text="xxx";
    date.text="xxx";
    contact.text="xxx";
    solde.text="0";
        return Scaffold(
      appBar: AppBar(centerTitle: true,
        title:new Text("Profile",style: TextStyle(color: Color(0xFFC90000),fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.white12,),
    body:ListView(
      children: <Widget>[
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    radius: 40,
                    
                              child: new FlatButton(
                                onPressed: () {
                                },
                                child: null,
                              ),
                              
                            ),
                ),
              ],
            ),
          
                  Padding(padding: EdgeInsets.all(4.0),),
                  Divider(),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: solde,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.attach_money,color: Colors.grey,),
                       hintText: 'Solde',
                       labelText: 'Solde'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Divider(),
                  Padding(padding: EdgeInsets.all(2.0),
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
                     controller: sexe,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.text_rotation_down,color: Colors.grey,),
                       hintText: 'sexe',
                       labelText: 'sexe'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: date,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.date_range,color: Colors.grey,),
                       hintText: 'Date de Naissance',
                       labelText: 'Date de Naissance'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: adress,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.map,color: Colors.grey,),
                       hintText: 'Adresse',
                       labelText: 'Adresse'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: contact,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.contact_mail,color: Colors.grey,),
                       hintText: 'Email',
                       labelText: 'Email'
                //         border: new OutlineInputBorder(
                //      borderRadius: new BorderRadius.circular(20.0)
                //  ),
                     ),
                    
                 ),
                  ),
                  Padding(padding: EdgeInsets.all(2.0),
                  child: TextField(
                     controller: contact,
                     enabled: false,
                     decoration: InputDecoration(
                       icon: Icon(Icons.contact_phone,color: Colors.grey,),
                       hintText: 'Phone',
                       labelText: 'Phone'
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