
import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:http/http.dart' as http;
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/seach/flight_model.dart';

class FlightsMockData {

static List<String> lagence=[""];
  static List<String> lfromCity=[""];
  static List<String> ltoCity=[""];
  static List<String> ldateDepart=[""];
 static Future<List> charger() async{
  final response=await http.post(PubCon.cheminPhp+"getHoraire.php",
  body: {
      "depart": CritereSelect.depart,
      "arrive": CritereSelect.arrive,
      "datedep": CritereSelect.datedep,
      "RefCatEng": CritereSelect.refCatEngin,
    });
  //print(response.body);
  var datauser=json.decode(response.body);
  if(datauser.length==0){
    //setState(() {
     lagence=["Aucun resultat"];
    //});
  }else{
    lagence.clear();
    lfromCity.clear();
    ltoCity.clear();
    ldateDepart.clear();
    //clearItems();
    //setState(() {
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
     
    //});
    
  }
    return datauser;
}
  static var count = lagence.length == null ? 0 : lagence.length;

  // static var from = ["BBI", "CCU", "HYD", "BOM", "JAI"];
  // static var to = ["BLR", "JAI", "BBI", "CCU", "AMD"];
  // static var fromCity = ["Bhubaneshwar", "Kolkata", "Hyderabad", "Mumbai", "Jaipur"];
  // static var toCity = ["Bangalore", "Jaipur", "Bhubaneshwar", "Kolkata", "Ahmedabad"];
  // static var departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
  // static var arriveTime = ["8:40 AM", "7:25 PM", "4:00 PM", "8:21 AM", "3:25 PM"];
  
  static getFlights(int position) {
   // _charger();
    return Flight(
        lagence[position],
        lfromCity[position],
        ltoCity[position],
        ldateDepart[position]);
  }

}