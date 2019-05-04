import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/seach/flights_details_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:http/http.dart' as http;

class GetHoraire extends StatefulWidget {
  @override
  _GetHoraireState createState() => _GetHoraireState();
}

class _GetHoraireState extends State<GetHoraire> {
  
   List<String> lagence=[""];
   List<String> lfromCity=[""];
   List<String> ltoCity=[""];
   List<String> ldateDepart=[""];
   
 Future<List> charger() async{
  final response=await http.post(PubCon.cheminPhp+"getHoraire.php",
  body: {
      "depart": CritereSelect.depart.toString(),
      "arrive": CritereSelect.arrive.toString(),
      "datedep": CritereSelect.datedep.toString(),
      "RefCatEng": CritereSelect.refCatEngin.toString(),
    });
  //print(response.body);
  var datauser=json.decode(response.body);
  if(datauser.length==0){
    
    setState(() {
     lagence=["Aucun resultat"];
    });
  }else{
    lagence.clear();
    lfromCity.clear();
    ltoCity.clear();
    ldateDepart.clear();
    //clearItems();
    setState(() {
    for(int h=0;h<datauser.length;h++){
      
        var nom=datauser[h]['nomAgence'].toString();
        var fromCity=datauser[h]['LieuDepart'].toString();
        var toCity=datauser[h]['LieuArret'].toString();
        var datedep=datauser[h]['Jours'].toString();
     lagence.add(nom);
     lfromCity.add(fromCity); 
     ltoCity.add(toCity); 
     ldateDepart.add(datedep);

     }
     
    });
    
  }
    return datauser;
}
//create custom listView
Widget _createListView(){
    return new Flexible(
      child:
       new ListView.builder(
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
        itemCount:lagence.length==null ? 0 : lagence.length,
        itemBuilder: (BuildContext context,int index){
          //return new Text(_view[index]);
          return new Card(
            color: Colors.white,
            elevation: 5.0,
            child:Column(
              children: <Widget>[
                Card(
        elevation: 5.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          
          child: 
           GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)
                => FlightDetailScreen(
                  passengerName: '',
                  //flight: flight,
                )
            )
        );
      },
          child:
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical:20.0),
          //   child: ListView(
          //     children: <Widget>[
          //       Text(flight.agence, style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 40.0,
          //     fontWeight: FontWeight.bold
          // ),),
         child:
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
      child: Column(
        children: <Widget>[
          Text(lagence[index], style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold
          ),),
          Text(lfromCity[index], style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 10.0,),
          Text(ldateDepart[index], style: TextStyle(color: Colors.grey, fontSize: 14.0),)
        ],
      ),
    ),
                    Icon(Icons.airplanemode_active),
Expanded(
      child: Column(
        children: <Widget>[
          
          Text(ltoCity[index], style: TextStyle(fontSize: 18.0),),
          SizedBox(height: 10.0,),
          
        ],
      ),
    ),

                  ],
                ),)
            //     Text(flight.dateDepart, style: TextStyle(color: Colors.grey, fontSize: 14.0),)
            //   ],
            // ),
          ),
        ),
      ),
              ],
            ),
          );
        },
      )
      ,
    )
    ;
  }
@override
  void initState() {
    super.initState();
    charger();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CritereSelect.depart+" ${CritereSelect.refCatEngin} ${CritereSelect.datedep} \n ${CritereSelect.arrive}"),
      ),
      body: new Column(
        children: <Widget>[
          _createListView(),
        ],
      ),
    );
    
  }
}