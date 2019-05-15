import 'dart:async';
import 'dart:convert';
import 'package:flights_app/MyClasses/clsCritereSelect.dart';
import 'package:flights_app/MyClasses/pub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LieuSelect extends StatefulWidget {
 
  _LieuSelectState createState() => _LieuSelectState();
}

class _LieuSelectState extends State<LieuSelect> {
Future<List> _chargerLieu() async{
  final response=await http.post(PubCon.cheminPhp+"GetAllLieu.php",
  body:{
    
  }
  );
  //print(response.body);
  var datauser=json.decode(response.body);
  _view.clear();
  if(mounted)
  setState(() {
   for (int h = 0; h < datauser.length; h++) {
          _view.add(datauser[h]['designeLieu'].toString());
        }
  });
    return datauser;
}






  //fonction recherche
  var _searchView=new TextEditingController();
  bool _firstSearch=true;
  String _query="";
  List<String> _view=[""];
  List<String> _filterList;
  @override
  void initState() {
    super.initState();
  
    _view=[""];

     // _chargerLieu();
    //_view.sort();
  }

  _LieuSelectState(){
    _searchView.addListener((){
      if(_searchView.text.isEmpty){
        setState(() {
         _firstSearch=true;
         _query=""; 
        });
      }else{
        setState(() {
         _firstSearch=false;
         _query=_searchView.text; 
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //getString();
    return new Container(
          child: new FutureBuilder<List>(
              future: _chargerLieu(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //List lieuFull = snapshot.data;

                  return new Column(
       children: <Widget>[
         _createSearchView(),
         Divider(),
         _firstSearch? _createListView(_view): _performSearch(),
        
       ],
    );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Align(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator());
              }));
    
    
    
    
    
  }
  //create a searchView
  Widget _createSearchView(){
    return new Container(
      //decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: TextField(
        controller: _searchView,
        decoration: InputDecoration(
          icon: Icon(Icons.search,color: Colors.blue,),
          hintText: "...Recherchez...",
          hintStyle: new TextStyle(color: Colors.blue[300])
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  //create a list Widget
  Widget _createListView(List lieuFull){
    return new Flexible(
      child:
       new ListView.builder(
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
        itemCount:lieuFull.length == null ? 0 : lieuFull.length,
        itemBuilder: (BuildContext context,int index){
          //return new Text(_view[index]);
          return new Card(
            elevation: 1.0,
            color: Colors.white,
            child:Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(1.0),
              child: new GestureDetector(
                child: new Text("${lieuFull[index]}"),
                onTap: (){
                  clickmaladie(lieuFull[index].toString());
                                    },
                                  ),
                                ),
                              );
                              
                            },
                          )
                          ,
                        )
                        ;
                      }
                      //perform actual search
                      Widget _performSearch(){
                        _filterList=new List<String>();
                        for(int i=0;i<_view.length;i++){
                          var item=_view[i];
                          if(item.toLowerCase().contains(_query.toLowerCase())){
                            _filterList.add(item);
                          }
                        }
                        return _createFilteredListView();
                      }
                      //
                      
                      //create the filtered listview
                      Widget _createFilteredListView(){
                        return new Flexible(
                          child: new ListView.builder(
                            //itemCount: _filterList.length,
                            itemCount:_filterList.length==null ? 0 : _filterList.length,
                            itemBuilder: (BuildContext context,int index){
                              return new Card(
                                color: Colors.white,
                                elevation: 1.0,
                                child: new Container(
                                  margin: EdgeInsets.all(1.0),
                                  child:new ListTile(
                                  title: new Text("${_filterList[index]}"),
                                  onTap: (){
                                    clickmaladie(_filterList[index].toString());
                                  },
                                ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    
                      void clickmaladie(String valeur) {
                       if(CritereSelect.est_Depart_Ou_Arrive==1){
                         setState(() {
                          CritereSelect.depart=valeur; 
                         });
                       }else if(CritereSelect.est_Depart_Ou_Arrive==2){
                         setState(() {
                          CritereSelect.arrive=valeur; 
                         });
                       }
                        Navigator.pop(context);
                      }
}

