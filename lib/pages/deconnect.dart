import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:fluttercnam/pages/login_page.dart';
import 'package:fluttercnam/pages/helperDB.dart';
class Deconnect extends StatefulWidget {
  @override
  _DeconnectState createState() => _DeconnectState();
}

class _DeconnectState extends State<Deconnect> {
  String imaUser = '';
  List logeouts=[];
  SharedPreferences use ;
  bool goBack,pressed;
  HelperDB DB = HelperDB();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init()async{
    use = await SharedPreferences.getInstance();
    setState(() {
      imaUser = use.getString("recu");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
    
      body:SafeArea(
                     child: Container(
                              height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color:Theme.of(context).primaryColor.withOpacity(0.8),
                                   child:Padding( 
                                         padding: EdgeInsets.only(top:55,left: 40,right:40),
                                          child:Center(  
                                                  child:Column(
                                                      children:<Widget> [
                                                        Text('أهل بك! نتمني أنتكون مرتاحا مع إستخدام ماكنامي',textAlign: TextAlign.end,),
                                                        Divider(color:Theme.of(context).primaryColor ,),
                                                        Text(
                                                            imaUser
                                                        ),
                                                        RichText(textAlign:TextAlign.end,
                                                          text: TextSpan(
                                                           style: TextStyle(
                                                             color: Colors.black,
                                                           ),
                                                            children: <TextSpan>[
                                                             TextSpan(text: 'تنبيه: ',style: TextStyle(color:Colors.red,fontSize: 20)),
                                                             TextSpan(
                                                               text:'إذاقمة بتسجيل الخروج ستحذف كل معلومات لدخول المره القادمه'
                                                             )
                                                            ]
                                                          ),
                                                        ),
                                                        SizedBox(height:25),
                                                        Material(
                                                          elevation: 5.0,
                                                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                          color: Colors.red,
                                                          child: MaterialButton(
                                                            
                                                            padding: EdgeInsets.fromLTRB(40,0,40,0,),
                                                            onPressed: _logoutConfirmed,
                                                            child: Text(
                                                              'logout'
                                                            ),),)

                                                      ]
                                                    )
                                                      ))
                                ),
                      ));
  }

  _logoutConfirmed() async{
             _showIndecator();
 var  url='https://miage2a2i.000webhostapp.com/index_cnam.php?logeout=yes&recunni='+use.getString("recu");
  try{
      http.Response response = await http.get(url);
      if(response.statusCode != 200)
             throw 'errer of server';
       logeouts = json.decode(response.body); 
       print(logeouts);
       }catch(e){
         print(e);
       }
       if(logeouts.isEmpty){
             Navigator.pop(context);
             Toast.show('errer de connection', context,duration: 2,gravity: Toast.CENTER);
       }else{print(logeouts[0]["logeout"]);
         if(logeouts[0]["logeout"] == "true"){
                    use.remove("login");
                     use.remove("recu");
                     use.remove("getReclamations");
                     DB.deleteAllReclas();
                     Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=>LoginPage(),
                                  ),
                                  (Route<dynamic> route)=>false);
          }else 
                   print('logeout false');        
       }   
}

_showIndecator(){
         goBack = false;
         showGeneralDialog(
          barrierLabel: 'progress',
          barrierColor: Colors.white.withOpacity(0.4),
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 0),
           context: context, 
           pageBuilder: (context,anim1,anim2){
                 return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(top:120),
                        child: CircularProgressIndicator(),
                      ),

                 );
         }).then((val){
           if(val != 'success'){goBack = true;
            setState(() {pressed = false;});
                    }else
                    print('success');
           })
         ;}

}