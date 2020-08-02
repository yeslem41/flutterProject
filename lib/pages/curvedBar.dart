import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class curvedBar extends StatefulWidget {
  @override
  _curvedBarState createState() => _curvedBarState();
}

class _curvedBarState extends State<curvedBar> {
    PageController _controller = PageController(initialPage: 0);
    GlobalKey _curvedBar = GlobalKey();
    // Animation tranformAnim;
    // AnimationController _animationController = AnimationController(vsync: null);
    int _page = 0;
    Color buttonBackColor = Colors.white;
     
      
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
           
    return Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                key: _curvedBar,
                index: _page,
                height: 60,
                buttonBackgroundColor: Theme.of(context).accentColor,
                backgroundColor:buttonBackColor,
               color:Theme.of(context).secondaryHeaderColor,
                items: <Widget>[
                  Icon(Icons.home,size: 30,),
                  Icon(Icons.help_outline,size: 30,),
                  
                ],
                onTap: (index){

                  setState(() {
                    buttonBackColor = colorResponsible(index);
                    _controller.animateToPage(index, duration: Duration(milliseconds: 600), curve: Curves.linear);
                        });
                },
              ),
              body: PageView(
                controller: _controller,
                onPageChanged:(index){
                         setState(() {print(index);
                            buttonBackColor = colorResponsible(index);
                              _page=index;});  
                },
                children:<Widget>[
                  homePage(),
                  helpPage(),
                ]
              ),
              
    );
  }
 



//change colors of backgroundButtonIcon in curvedBar
Color colorResponsible(int index){
       switch (index) {
         case 0:{
              return Colors.white;
           }
           break;
           case 1:{
              return Theme.of(context).primaryColor;
           }
           break;
         default:{
         return Colors.white;
         }
       }
}
}
//home page
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
    List <String> recuCharactaire=["1","2","3","4","5","6","7","8","9","0","/"];
    Color buttonBackColor ;
    var recuController =  TextEditingController();
      String checkedInput = '',_sysLng;
      bool loading = false;
      Map<String,dynamic> user;
      var formKey = GlobalKey <FormState>();
      bool pressed = false,goBack=false,frlang;
       SharedPreferences use ;
  bool validateRecu(String input){
    if((input.length!=11)||(input[6]!="/"))
         return false;

    for(int i=0;i<input.length;i++){
      var char = input[i];
      if(!recuCharactaire.contains(char))
                return false;
    }
    return true;
  }     
  @override
  Widget build(BuildContext context) {
     String myLo = Localizations.localeOf(context).languageCode;
        if(myLo == 'fr')
              frlang = true;
        else  
              frlang = false;  
    return GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child:Column(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width,height: 30,),
              Container(
                height:80,
                padding: EdgeInsetsDirectional.only(top: 5,end: 20,start: 20),
                child: Image.asset('images/sympol.png',),
              ),
              Expanded(
                child: ListView(
                  children:<Widget>[
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child:Text(AppLocalization.of(context).choisir,style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  shape: BoxShape.rectangle,


                ),
                  child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Padding(
                      padding:frlang ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
                      child:Radio(
                        value: 'affiliation',
                        groupValue: checkedInput,
                        onChanged: (val){setState(() {checkedInput = val.toString();});},
                        activeColor: Colors.black,
                        focusColor: Theme.of(context).primaryColor,
                        autofocus: true,

                      ),
                    ),
                    Text(AppLocalization.of(context).choiDossier,style: TextStyle(fontSize: 18,color: Colors.black),)
                  ],
                  ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  shape: BoxShape.rectangle,
                   ),
                child:Row(
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Padding(

                      padding: frlang ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
                      child:Radio(
                        value: 'rembourser',
                        groupValue: checkedInput,
                        onChanged: (val){setState(() { checkedInput = val.toString();});  },
                        activeColor: Colors.black,
                        focusColor: Theme.of(context).primaryColor,
                        autofocus: true,
                      ),
                    ),
                    Text(AppLocalization.of(context).choiRembourser,style: TextStyle(fontSize: 18,color: Colors.black),)
                  ],
                ),
              ),
              Container(height: 20,),
              Form(
                  key: formKey,
                child:Column(
                  children:<Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 10,right: 20),
                  child:TextFormField(
                     keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: recuController,
                    textAlign: TextAlign.center,
                    obscureText: false,
                    maxLength: 11,
                    // !validateRecu(val)
                    textInputAction: TextInputAction.done,
                    validator: (val)=> val==null ? AppLocalization.of(context).hintRecuFalse : null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(right: 25,left: 25),
                      labelText:AppLocalization.of(context).hintRecu,
                      labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w100,color: Colors.black.withOpacity(0.6)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),),
                    ),
                  )),
              Container(height: MediaQuery.of(context).size.height/25,),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child:Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(26.0),
                  color: Theme.of(context).accentColor,

                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed:!pressed?_passing:null,
                    child: Text(AppLocalization.of(context).suiviButton,textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),

                    ),
                  ),
                ),
              )]))
               ]
                ),
              ),
                ],
          ),
        );
  }
  _passing() async{
  user?.clear();
  _sysLng = Localizations.localeOf(context).languageCode; 
  FocusScope.of(context).unfocus();
      if(formKey.currentState.validate()){
          formKey.currentState.save();
          if (checkedInput.isEmpty)
          return Toast.show(AppLocalization.of(context).choiservice, context, duration: 3, gravity: Toast.CENTER,backgroundColor: Colors.black);
          setState(() {pressed=true;});

           _showIndecator();
        FocusScope.of(context).unfocus();


       try {
         var reponse = await http.get('https://miage2a2i.000webhostapp.com/get_recu.php?recu='+recuController.text+'&cheked='+checkedInput+'&lang='+_sysLng+checkedInput);
      
         if(reponse.statusCode != 200)
              throw "errer dr server";
         user = json.decode(reponse.body);
       
       }catch(e){
         setState(() {
           pressed = false;
         });
         Toast.show(AppLocalization.of(context).erreurService, context,duration: 2,gravity:Toast.CENTER,backgroundColor: Colors.black);
       }
       setState(() {pressed=false;});
       if(!goBack)
           Navigator.pop(context,'success');
         print(user); print("user");
          if(!goBack){
                    if(user.isNotEmpty) {
                    if(user["recuId"]=="no" || user["ARid"]=="no"){
                          user.clear(); _dialog();
                           }else{
                      user["recu"]=recuController.text; print(user);
                      Navigator.of(context).pushNamed('/AfterRecu', arguments: user);
                    }
                    }else{
                      Toast.show(AppLocalization.of(context).erreurConnection, context,duration: 2,gravity:Toast.CENTER,backgroundColor: Colors.black);
                    }
            }

         }}
//functions of home page

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
           });
           }
_dialog() {
        showGeneralDialog(
          barrierColor: Colors.white.withOpacity(0.3),
           barrierLabel: 'label',
           barrierDismissible: true,
            transitionDuration: Duration(milliseconds: 700),
            context: context,
            pageBuilder: (context,anim1,anim2){
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding:EdgeInsets.only(right: 10,left: 10,top: 5) ,
                  margin: EdgeInsets.only(top:100),
                  height: 230,
                   width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/6,
                  decoration: BoxDecoration(
                       color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(25.0)),
                  child: Column(
              children: <Widget>[

              Container(height: 10,),
              Text(AppLocalization.of(context).alertNotRecu,
              style: TextStyle(fontSize: 16,decoration: TextDecoration.none),textAlign: TextAlign.start,),
              Divider(height: 5,color: Theme.of(context).primaryColor,),
              Container(height: 15,),
              Text(AppLocalization.of(context).alertNotrecu10,
                style: TextStyle(fontSize: 16,decoration: TextDecoration.none),textAlign: TextAlign.start,),
              Divider(height: 15,color: Theme.of(context).primaryColor,),
              Container(height: 25,),
              Container(
              padding: frlang ? EdgeInsets.only(right: 15) : EdgeInsets.only(left: 15),
              alignment: frlang ? Alignment.bottomRight : Alignment.bottomLeft,
              child:FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
        transitionBuilder: (context,anim1,anim2,child){
            return SlideTransition(
              position: Tween(
                begin: Offset(-1,-1),
                end: Offset(0,0)
              ).animate(anim1),
              child: child,
            );
        },
        );
      }
}
//help page
class helpPage extends StatefulWidget {
  @override
  _helpPageState createState() => _helpPageState();
}

class _helpPageState extends State<helpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
             child: Align(
             alignment: Alignment.topCenter,
             child: Container(
               //padding: EdgeInsets.only(left: 15,right: 15,top: 0),
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               color:Theme.of(context).primaryColor,
               child: ListView(
                 children: <Widget>[
                   Container(
                     alignment: Alignment.bottomCenter,
                     color: Theme.of(context).primaryColor,
                     padding: EdgeInsets.only(bottom: 15),
                     height: 82,
                     child: Text(
                       AppLocalization.of(context).helpTete,
                       style: TextStyle(fontSize: 18,color: Colors.white.withOpacity(0.7),decoration: TextDecoration.combine([TextDecoration.overline,TextDecoration.underline]),),
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.only(top: 25,left: 40,right: 40),
                    // child: Directionality(
                        child:Text(
                          AppLocalization.of(context).help,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 17,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                   )
                 ],
               )
             ),

           )
             ) ;
  }
}

