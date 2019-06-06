
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class DetailBoarding extends StatefulWidget {
  final String refDetReserv,firstName,dateVoyage;

  const DetailBoarding({Key key, this.refDetReserv, this.firstName, this.dateVoyage}) : super(key: key);
  @override
  _DetailBoardingState createState() => _DetailBoardingState();
}

class _DetailBoardingState extends State<DetailBoarding> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;
@override
void initState() { 
  super.initState();
  _dataString=widget.refDetReserv.toString();
  _textFirstName.text=widget.firstName.toString();
  _textDateVoyage.text=widget.dateVoyage.toString();

}
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  TextEditingController _textFirstName =  TextEditingController();
  TextEditingController _textDateVoyage =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Qr_Code",style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.share),
          //   onPressed:(){} 
          //   //_captureAndSharePng,
          // )
        ],
      ),
     body: _contentWidget()
    );
  }

 Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

 _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0
            ),
            child: Card(
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                      controller: _textFirstName,
                      decoration:  InputDecoration(
                        hintText: "Name:",
                        labelText: 'Name',
                        errorText: _inputErrorText,
                      ),),
                      TextField(
                        textAlign: TextAlign.center,
                        enabled: false,
                      controller: _textDateVoyage,
                      decoration:  InputDecoration(
                        hintText: "Date de Voyage",
                        labelText: "Date Voyage",
                        errorText: _inputErrorText,
                      ),),
                ],
              ),
            )),
            Divider(),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: _topSectionTopPadding,
          //     left: 20.0,
          //     right: 10.0,
          //     bottom: _topSectionBottomPadding,
          //   ),
          //   child:  Container(
          //     height: _topSectionHeight,
          //     child:  Row(
          //       mainAxisSize: MainAxisSize.max,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: <Widget>[
          //         Expanded(
          //           child:  TextField(
          //             controller: _textController,
          //             decoration:  InputDecoration(
          //               hintText: "Enter a custom message",
          //               errorText: _inputErrorText,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 10.0),
          //           child:  FlatButton(
          //             child:  Text("SUBMIT"),
          //             onPressed: () {
          //               setState((){
          //                 _dataString = _textController.text;
          //                 _inputErrorText = null;
          //               });
          //             },
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          //=============================
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
                  onError: (ex) {
                    print("[QR] ERROR - $ex");
                    setState((){
                      _inputErrorText = "Error! Maybe your input value is too long?";
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}