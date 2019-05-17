//import 'package:flights_app/MyClasses/clsCritereSelect.dart';
//import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/seach/flight_card.dart';
import 'package:flights_app/seach/flight_dummy.dart';
import 'package:flights_app/seach/flight_model.dart';
import 'package:flutter/material.dart';

class FlightListScreen extends StatelessWidget{


  final String fullName,datedep,depart,arrive;
  final int catEngin;
  const FlightListScreen({Key key, this.fullName, this.catEngin, this.datedep, this.depart, this.arrive}) : super(key: key);
  @override
  Widget build(BuildContext context) {
FlightsMockData.charger();
    Flight flight;

    return Scaffold(
      appBar: AppBar(
        title: Text(fullName+""+depart+" $catEngin $datedep \n $arrive"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: FlightsMockData.count,
            itemBuilder: (context, index) {
              flight=new Flight(FlightsMockData.lagence[index], FlightsMockData.lfromCity[index], FlightsMockData.ltoCity[index],FlightsMockData.ldateDepart[index]);
              //flight = FlightsMockData.getFlights(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlightCard(
                  fullName: fullName,
                  flight: flight,
                  isClickable: true,
                ),
              );
            }
        ),
      ),
    );
  }
}
