import 'dart:convert';
import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:fluttercnam/pages/login_page.dart';

class curvedBar extends StatefulWidget {
  @override
  _curvedBarState createState() => _curvedBarState();
}

class _curvedBarState extends State<curvedBar> {
    PageController _controller = PageController(initialPage: 0);
    GlobalKey _curvedBar = GlobalKey();
    int _page = 1;
    Color buttonBackColor ;
    //principale
    var recuController =  TextEditingController();
      String checkedInput = '';
      bool loading = false;
      List user = [],logeouts=[];
      var formKey = GlobalKey <FormState>();
      bool pressed = false;
       SharedPreferences use ;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init()async{
    use = await SharedPreferences.getInstance();
  }
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
                index: 1,
                height: 60,
                buttonBackgroundColor: Theme.of(context).accentColor,
                backgroundColor:buttonBackColor,
               color:Theme.of(context).secondaryHeaderColor,
                items: <Widget>[
                  Icon(Icons.help_outline,size: 30,),
                  Icon(Icons.home,size: 30,),
                  Icon(Icons.exit_to_app,size: 30,),
                  
                ],
                onTap: (index){

                  setState(() {
                    buttonBackColor = colorResponsible(index);
                    _page=index;
                        });
                },
              ),
              body: _pageView(_page),
              
    );
  }
  Widget _pageView(int index){

        switch(index){
          case 0 :{
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
                       'نبذ عن ماكنامي',
                       style: TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.none,),
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.only(top: 25,left: 40,right: 40),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                        child:Text(
                          'كنامي هو تطبيق يتيح لمؤمني الصندوق الوطني للتأمين الصحي (كنام) بمتابعة ملفاتهم المودعه لدي مصاح الصندوق لغرض إطلاعهم علي مرحلة معالجتها. \nفبإمكان مستخدمي هذا التطبيق الحصول علي المعلومات الكافيه المتعلقه بملفاتهم التعويضيه و كذالك الإنتسابيه, كما أن بإمكانهم طلب إستفسار موجه لمصالح الصندوق المختصه في حال حصول تأخير في معالجة أي من ملفاتهم المذكورهٍ',
                          style: TextStyle(

                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.start,
                        )
                    ),
                   )
                 ],
               )
             ),

           )
             );
          } 
          break;

          case 1 : {
            return GestureDetector(
          onTap: ()=>FocusScope.of(context).unfocus(),
          child:Column(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width,height: 30,),
              loading ? LinearProgressIndicator(backgroundColor: Theme.of(context).secondaryHeaderColor) :Container(),
              Container(
                height:100,
                padding: EdgeInsetsDirectional.only(top: 5,end: 20,start: 20),
                child: Image.asset('images/sympol.png',),
              ),
              Expanded(
                child: ListView(
                  children:<Widget>[
              Container(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child:Text('من فضلك قم بإختيار الخدمه و أدخل رقم الوصل',style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),
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
                child:Row(
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child:Radio(
                        value: 'affiliation',
                        groupValue: checkedInput,
                        onChanged: (val){setState(() {checkedInput = val.toString();});},
                        activeColor: Colors.black,
                        focusColor: Theme.of(context).primaryColor,
                        autofocus: true,

                      ),
                    ),
                    Text('متابعة الملف',style: TextStyle(fontSize: 18,color: Colors.black),)
                  ],
                ),
              ),
              // Divider(height: 0,),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  shape: BoxShape.rectangle,
                   ),
                child:Row(
                  textBaseline: TextBaseline.alphabetic,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Padding(

                      padding: EdgeInsets.only(right: 30),
                      child:Radio(
                        value: 'rembourser',
                        groupValue: checkedInput,
                        onChanged: (val){setState(() { checkedInput = val.toString();});  },
                        activeColor: Colors.black,
                        focusColor: Theme.of(context).primaryColor,
                        autofocus: true,
                      ),
                    ),
                    Text('متابعة االتسديد',style: TextStyle(fontSize: 18,color: Colors.black),)
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
                   child: Directionality(
                    textDirection:TextDirection.rtl,
                  //padding: EdgeInsets.only(left: 10,right: 10),
                  child:TextFormField(

                    cursorColor: Colors.black,
                    controller: recuController,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    obscureText: false,
                    maxLength: 14,
                   // keyboardType : TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (val)=> val.length ==0 ? "ادخل رقم وصلك" : (val.length <5 ? "رقم الوصل غير صحيح" : null),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(right: 25,left: 25),
                      labelText:'ادخل رقم وصلك',
                      labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(35),),
                    ),
                  ))),
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
                    child: Text('التالي',textDirection: TextDirection.rtl,
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
          break;
          case 2 : {
            
            return  SafeArea(
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
                                                            use.getString("recu")
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
                      );
          }
          break;
          default: {
            return null;
          }
          break;
        }
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
                    print('logeout true');
                    use.remove("login");
                     use.remove("recu");
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

//functions of home page
_passing() async{
  FocusScope.of(context).unfocus();
       user.clear();
      if(formKey.currentState.validate()){
          formKey.currentState.save();
          if (checkedInput.isEmpty)
          return Toast.show('svp choisir une service', context, duration: 3, gravity: Toast.CENTER,backgroundColor: Colors.black);
          setState(() {pressed=true;});

           _showIndecator();
        FocusScope.of(context).unfocus();


       try {
         var reponse = await http.get('https://miage2a2i.000webhostapp.com/get_recu.php?recu='+recuController.text+'&cheked='+checkedInput);
      
         if(reponse.statusCode != 200)
              throw "errer dr server";
         user = json.decode(reponse.body);
       }catch(e){
         Toast.show('erreur du service', context,duration: 2,gravity:Toast.CENTER,backgroundColor: Colors.black);
       }
       setState(() {pressed=false;});
        Navigator.pop(context);
            if(user.isNotEmpty) {
             /* if(user[0]["noBody"]=="yes"){ user.clear(); _dialog();}
              else */
             if(user[0]["recuId"]=="no"){
                  user.clear(); _dialog();//Navigator.of(context).pushNamed('/AfterRecu', arguments: user);
                  }else{
               user.add(recuController.text);
               Navigator.of(context).pushNamed('/AfterRecu', arguments: user);
             }
            }else{
              Toast.show('erreur du connection', context,duration: 2,gravity:Toast.CENTER,backgroundColor: Colors.black);
            }

         }}

_showIndecator(){
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
         });}
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
                  height: 200,
                   width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/6,
                  decoration: BoxDecoration(
                       color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(25.0)),
                  child: Column(
              children: <Widget>[

              Container(height: 10,),
              Text('Vérifiez votre reçu et réessayez. ',
              style: TextStyle(fontSize: 16,decoration: TextDecoration.none),textAlign: TextAlign.start,),
              Divider(height: 5,color: Theme.of(context).primaryColor,),
              Container(height: 15,),
              Text('Nous vous aidions autant que possible',
                style: TextStyle(fontSize: 16,decoration: TextDecoration.none),textAlign: TextAlign.start,),
              Divider(height: 15,color: Theme.of(context).primaryColor,),
              Container(height: 25,),
              Container(
              padding: EdgeInsets.only(right: 15),
              alignment: Alignment.bottomRight,
              child:FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              color: Theme.of(context).primaryColor,
              child:Text('OK',style: TextStyle(color:Colors.white),),
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

//change colors of backgroundButtonIcon in curvedBar
Color colorResponsible(int index){
       switch (index) {
         case 0:{
              return Theme.of(context).primaryColor;
           }
           break;
           case 1:{
              return Colors.white;
           }
           break;
           case 2:{
              return Theme.of(context).primaryColor.withOpacity(0.8);
           }
           break;
         default:{
         return Colors.white;
         }
       }
}
}


  //         Case 0:
  //          return SafeArea(
  //            child: Center(child:Text('i am safearea 1 !'))
  //            );
  //       }else{
  //          return SafeArea(
  //            child: Center(child:Text('i am safearea 2 !'))
  //            );
  //       }
  // }