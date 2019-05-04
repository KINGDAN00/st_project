import 'package:flights_app/air_asia_bar.dart';
import 'package:flights_app/content_card.dart';
import 'package:flights_app/rounded_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int catergorieEngin;

  const HomePage({Key key, this.catergorieEngin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AirAsiaBar(height: 210.0),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  _buildButtonsRow(),
                  Expanded(child: ContentCard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "ALLEE SIMPLE",selected: true),
          new RoundedButton(text: "ALLEE ET RETOUR"),
        ],
      ),
    );
  }
}
