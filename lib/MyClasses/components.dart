import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/pub.dart';
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

static Widget iconaddcons(BuildContext context){
  if(CritereSelect.refCatEngin==1){
    return new Icon(Icons.directions_boat, color: Colors.blue);
  }else if(CritereSelect.refCatEngin==2){
    return new Icon(Icons.directions_bus, color: Colors.blue);
  }else if(CritereSelect.refCatEngin==3){
    return new Icon(Icons.flight_takeoff, color: Colors.blue);
  }else if(CritereSelect.refCatEngin==4){
    return new Icon(Icons.directions_car, color: Colors.blue);
  }
}
static Widget iconaddconsCat(BuildContext context,String code){
  if(code=='1'){
    return new Icon(Icons.directions_boat, color: Colors.blue);
  }else if(code=='2'){
    return new Icon(Icons.directions_bus, color: Colors.blue);
  }else if(code=='3'){
    return new Icon(Icons.flight_takeoff, color: Colors.blue);
  }else if(code=='4'){
    return new Icon(Icons.directions_car, color: Colors.blue);
  }
}

static Widget manageImage(BuildContext context,String url){
  try{
  if(url=='' || url.isEmpty || url==null || url=="null"){
    return CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.blue,
                  child: new Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                );
  }else{
    return new CircleAvatar(
                  //backgroundColor: Colors.blue,
      backgroundImage: new NetworkImage('${PubCon.cheminPhoto}$url'),
    );
  }
  }catch(e){
    return CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.blue,
                  child: new Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                );
  }
}
}