import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyDesigns/res_aller_retour.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CritereAllerRetour extends StatefulWidget {
  @override
  CritereAllerRetourState createState() {
    return new CritereAllerRetourState();
  }
}

class CritereAllerRetourState extends State<CritereAllerRetour>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController depart=new TextEditingController(),
arrive=new TextEditingController(),
datedep=new TextEditingController()
;
final f=new DateFormat('yyyy-MM-dd');
DateTime date1=DateTime.now();
DateTime date2=DateTime.now();
void getData(){
  CritereSelect.arrive=arrive.text;
  CritereSelect.depart=depart.text;
  CritereSelect.datedep=f.format(date1).toString();
  CritereSelect.dateRet=f.format(date2).toString();

}
Future<Null> _selectDate1(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   date1 =picked;
                   CritereSelect.datedep=date1.toString();
                  });
}
Future<Null> _selectDate2(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   date2 =picked;
                   CritereSelect.dateRet=date2.toString();
                  });
}

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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextField(
                controller: depart,
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_takeoff, color: Colors.red),
                  labelText: "Depart",
                ),
                onChanged:(text){
                  getData();
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextField(
                controller: arrive,
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_land, color: Colors.red),
                  labelText: "Destination",
                ),
                onChanged:(text){
                  getData();
                }
              ),
            ),
            
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.red),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextField(
                       maxLines: 2,
                     controller: datedep,
                     decoration: InputDecoration(
                       //icon: Icon(Icons.date_range,color: Colors.grey,),
                       hintText: 'Date Aller :\n'+f.format(date1).toString(),
                       
                     ),
                     onTap:(){_selectDate1(context);
                  getData();
                
                     },
                     onChanged:(text){getData();},
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextField(
                       maxLines: 2,
                     controller: datedep,
                     decoration: InputDecoration(
                       //icon: Icon(Icons.date_range,color: Colors.grey,),
                       hintText: 'Date Retour :\n'+f.format(date2).toString(),
                       
                     ),
                     onTap:(){_selectDate2(context);
                  getData();
                
                     },
                     onChanged:(text){getData();},
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 16.0),
                //     child: TypeableTextFormField(
                //       animation: _buildInputAnimation(begin: 0.75, end: 0.95),
                //       finalText: "29 July 2017",
                //       decoration: InputDecoration(labelText: "Arrival"),
                //     ),
                //   ),
                // ),
              ],
            ),
            Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              CritereSelect.course=2;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GetHoraireAllerRetour()));
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         FlightListScreen(fullName: nameController.text,catEngin:CritereSelect.refCatEngin,arrive:CritereSelect.arrive,depart: CritereSelect.depart,datedep: CritereSelect.datedep,)));
              
            },
            child: Icon(Icons.timeline, size: 36.0),
          ),
        ),
          ],
          
        ),
      ),
      
    );
  }

  CurvedAnimation _buildInputAnimation({double begin, double end}) {
    return new CurvedAnimation(
        parent: textInputAnimationController,
        curve: Interval(begin, end, curve: Curves.linear)
    );
  }

}
