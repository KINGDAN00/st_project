//import 'package:flights_app/MyClasses/clsCritereSelect.dart';
//import 'package:flights_app/MyClasses/pub.dart';
import 'package:flights_app/multicity_input.dart';
import 'package:flights_app/price_tab/price_tab.dart';
import 'package:flights_app/seach/charger_agences.dart';
//import 'package:flights_app/seach/flight_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ContentCard extends StatefulWidget {
  @override
  _ContentCardState createState() => _ContentCardState();
}
class _ContentCardState extends State<ContentCard> {
  bool showInput = true;
  bool showInputTabOptions = true;

  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!showInput) {
          setState(() {
            showInput = true;
            showInputTabOptions = true;
          });
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: new Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          child: new LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Column(
                children: <Widget>[
                  _buildTabBar(),
                  _buildContentContainer(viewportConstraints),
                ],
              );
            },
          ),
          length: 3,
        ),
      ),
    );
  }

  Widget _buildTabBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: Colors.orange,
          ),
        ),
        new TabBar(
          tabs: [
            Tab(text: showInputTabOptions ? "Donnees de voyage" : "Price"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            minHeight: viewportConstraints.maxHeight - 48.0,
          ),
          child: new IntrinsicHeight(
            child: showInput
                ? _buildMulticityTab()
                : PriceTab(
                    height: viewportConstraints.maxHeight - 48.0,
                    onPlaneFlightStart: () =>
                        setState(() => showInputTabOptions = false),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        MulticityInput(),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GetHoraire()));
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         FlightListScreen(fullName: nameController.text,catEngin:CritereSelect.refCatEngin,arrive:CritereSelect.arrive,depart: CritereSelect.depart,datedep: CritereSelect.datedep,)));
              print(nameController.text);
            },
            child: Icon(Icons.timeline, size: 36.0),
          ),
        ),
      ],
    );
  }
}
