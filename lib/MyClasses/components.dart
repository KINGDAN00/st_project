import 'package:flutter/material.dart';
class Componentss{
static void showDialogcz(BuildContext ctx,String menu,String msg){
  showDialog(
                        context: ctx,
                        builder: (context) => new AlertDialog(
                              title: new Text(""+menu+"\n+"+msg),
                              content: new Container(
                                height: MediaQuery.of(ctx).size.height/3,
                                child: IconButton(
                                  icon:Icon(Icons.cancel), 
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                )
                              ),
                            )
                            );
}

}