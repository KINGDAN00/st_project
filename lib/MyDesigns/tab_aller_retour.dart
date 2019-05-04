
import 'package:flights_app/MyDesigns/critere_aller.dart';
import 'package:flights_app/MyDesigns/critere_aller_retour.dart';
import 'package:flutter/material.dart';

class TabAllerRetour extends StatefulWidget {
  @override
  _TabAllerRetourState createState() => _TabAllerRetourState();
}

class _TabAllerRetourState extends State<TabAllerRetour> {
  List<Widget> containers=[
     LayoutBuilder(
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
        child: IntrinsicHeight(child:CritereAller(),),),)
       
    )]);}),
     LayoutBuilder(
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
        child: IntrinsicHeight(child:CritereAllerRetour(),),),)
       
    )]);}),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Smart Ticket"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "ALLER SIMPLE",
              ),
              Tab(
                text: "ALLER RETOUR",
              )
            ],
          ),
        ),
        body: TabBarView( 
          children: containers,
        ),
      ),
    );
  }
}