import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/typable_text.dart';
import 'package:flutter/material.dart';

class MulticityInput extends StatefulWidget {
  @override
  MulticityInputState createState() {
    return new MulticityInputState();
  }
}

class MulticityInputState extends State<MulticityInput>
    with TickerProviderStateMixin {
  AnimationController textInputAnimationController;
TextEditingController depart=new TextEditingController(),
arrive=new TextEditingController(),
datedep=new TextEditingController(),
nbrePassager=new TextEditingController()
;
DateTime date=DateTime.now();
void getData(){
  CritereSelect.arrive=arrive.text;
  CritereSelect.depart=depart.text;
  CritereSelect.nbrePassager=int.parse(nbrePassager.text);
  CritereSelect.datedep=date.toString();

}
Future<Null> _selectDate(BuildContext context) async{
  final DateTime picked = await
  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2099),

                  );
                  setState(() {
                   date =picked;
                   CritereSelect.datedep=date.toString();
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
                  labelText: "From",
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
                  labelText: "To",
                ),
                onChanged:(text){
                  getData();
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TextField(
                controller: nbrePassager,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.red),
                  labelText: "Passengers",
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
                       hintText: 'Date de Naissance:\n'+date.toString(),
                       
                     ),
                     onTap:(){_selectDate(context);
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
