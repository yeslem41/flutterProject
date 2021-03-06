import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:fluttercnam/pages/dashpoard.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart'as http;
import 'package:fluttercnam/pages/curvedBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final myController = TextEditingController();
    String NIN;
    List user =[];
    bool loading = false;
    var formKey = GlobalKey<FormState>();



    _passing() async{
             if(formKey.currentState.validate()){
           NIN = myController.text; setState(() {loading= true; });
             try {
               var reponse = await http.get('https://miage2a2i.000webhostapp.com/index_cnam.php?NIN=' + NIN);

               if(reponse.statusCode != 200)
                 throw "errer du server";
               user = json.decode(reponse.body);

             }catch(e){
              Toast.show(AppLocalization.of(context).erreurService, context,duration: 2,gravity:Toast.CENTER,backgroundColor: Colors.black);
             }
             setState(() { loading= false; });

             if(user.isEmpty)
               Toast.show(AppLocalization.of(context).erreurConnection, context,duration: 2,gravity: Toast.CENTER,) ;
              else {
               if(user[0]["noBody"]=="yes"){
                 user.clear();
                 _dialog();
               }else {
                 print(user);
                 SharedPreferences login = await SharedPreferences.getInstance();
                 login.setString("recu", user[0]["id"]);
                 login.setBool("login", true);
                 print(login.getBool("login").toString()+"  "+login.getString("recu").toString());
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(
                       builder:(context)=> Dashboard()

                     ),
                         (Route<dynamic> route)=>false);
                 //Navigator.of(context).pushNamed('/PagePrincipale');
               }
               }
        }

    }

    @override
  Widget build(BuildContext context) {
        final password = TextFormField(
          controller: myController,
          textAlign: TextAlign.center,
          obscureText: false,
          validator: (val) =>val.length == 0 ? AppLocalization.of(context).loginLabelText :val.length<=6 ? AppLocalization.of(context).hitLoginNotCorrect : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            labelText: AppLocalization.of(context).loginLabelText,
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.6),),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),

        );

        final buttonField = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(26.0),
          color: Theme.of(context).accentColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: !loading ? _passing : () => {},
            child: Text(AppLocalization.of(context).loginConnect,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),

            ),
          ),
        );

        return Scaffold(
            appBar: AppBar(title: Text(AppLocalization.of(context).AppBar), centerTitle: true,),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    loading ? LinearProgressIndicator(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,) : Container(),
                    Container(
                      height: 100.0,
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.only(
                          top: 10, end: 20, start: 20),
                      child: Image.asset('images/sympol.png',),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 20.0),
                        children: <Widget>[
                          SizedBox(height: MediaQuery.of(context).size.height/18,),
//                      emailField,
                          Text(AppLocalization.of(context).welcome,
                          textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),),
                          SizedBox(height: MediaQuery.of(context).size.height/18,),
                          Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  password,
                                  SizedBox(height: 30.0,),
                                  buttonField,
                                ],
                              )
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                '©Copyright Cnam 2020', textAlign: TextAlign.center, style:
              TextStyle(fontWeight: FontWeight.bold),),
            )
        );
      }


  void _dialog() {
    showGeneralDialog(
      barrierColor: Colors.white.withOpacity(0.3),
      barrierLabel: 'Label',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context,anim1,anim2){
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
               padding:EdgeInsets.only(right: 10,left: 10,top: 5) ,
              margin: EdgeInsets.only(top:30),
              height: 250,
              width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/6,
              decoration: BoxDecoration(
                 color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text(AppLocalization.of(context).alertNotrecu10,
                    style: TextStyle(fontSize: 16,decoration: TextDecoration.none),textAlign: TextAlign.center,),
                  Divider(height: 15,),
                  Container(height: 30,),
                  Text(AppLocalization.of(context).alertNotInam,style: TextStyle(fontSize: 16,decoration: TextDecoration.none),
                    textAlign: TextAlign.center,),
                  Divider(height: 15,),
                  Container(height: 25,),
                  Container(
                    // padding: EdgeInsets.only(right: 15),
                    // alignment: Alignment.bottomRight,
                     child:FlatButton(
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    color: Theme.of(context).primaryColor,
                         child:Text(AppLocalization.of(context).alertNotRecuOk,style: TextStyle(color:Colors.white),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },)
                  )

                ],
              ),

            ),
          );
        },
        transitionBuilder:(context,anim1,anim2,child){
                   return SlideTransition(
                     position: Tween(begin:Offset(2,2),
                         end: Offset(0,0)).animate(anim1),
                     child: child,
                   );

              }

    );

  }
}


