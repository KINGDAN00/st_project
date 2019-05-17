import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences{
  static const AUTOMATIC="automatique";
  static const USER="user";
  static const PASSWORD="password";
  static const ID_USER="iduser";
  static const NOM_COMPLET="nomcomplet";
  static const PRIVILEGE="privilege";
  static const IMAGE="image";
  static final MyPreferences instance=MyPreferences._internal();
  SharedPreferences _sharedPreferences;
  bool automatic =false;
  String user="";
  String password="";
  String iduser="-1";
  String nomcomplet="";
  String privilege="0";
  String image="";
  MyPreferences._internal(){

  }
  factory MyPreferences()=>instance;

  Future<SharedPreferences> get preferences async{
    if(_sharedPreferences!=null){
      return _sharedPreferences;
    }else{
      _sharedPreferences=await SharedPreferences.getInstance();
      automatic=_sharedPreferences.getBool(AUTOMATIC);
      user=_sharedPreferences.getString(USER);
      password=_sharedPreferences.getString(PASSWORD);
      iduser=_sharedPreferences.getString(ID_USER);
      nomcomplet=_sharedPreferences.getString(NOM_COMPLET);
      privilege=_sharedPreferences.getString(PRIVILEGE);
      image=_sharedPreferences.getString(IMAGE);

      if(automatic==null){
        automatic=false;
        user="";
        password="";
        iduser="-1";
        nomcomplet="";
        privilege="0";
        image="";
      }
      return _sharedPreferences;
    }
  }
Future<bool> commit() async{
await _sharedPreferences.setBool(AUTOMATIC, automatic);
await _sharedPreferences.setString(USER, user);
await _sharedPreferences.setString(PASSWORD, password);
await _sharedPreferences.setString(ID_USER, iduser);
await _sharedPreferences.setString(NOM_COMPLET, nomcomplet);
await _sharedPreferences.setString(PRIVILEGE, privilege);
await _sharedPreferences.setString(IMAGE, image);
}
Future<MyPreferences> init() async{
  _sharedPreferences=await preferences;
  return this;
}
}