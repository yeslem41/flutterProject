import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
class aboutUs extends StatefulWidget {
  @override
  _aboutUsState createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation <double> animation;
  void initState(){
    super.initState();
   controller = AnimationController(duration:Duration(seconds:2),vsync: this);
    animation = Tween<double>(begin: 0,end: 150).animate(controller)
                 ..addListener((){
                   setState(() {
                     
                   });
                 });
                 controller.forward();
  }
  
  void phoneCall(String url)async{
    if(await canLaunch("tel:$url")){
          await launch("tel:$url");
    }else 
       Toast.show('your device can call from here. do call from phone\'s call', context);
  }
   void sendMail()async{
     final Uri params = Uri(
                        scheme: 'mailto',
                        path: 'cnam.mr@gmail.com',
                        query: 'subject=reclammation&body=body', //add subject and body here
                      );
    if(await canLaunch(params.toString())){
          await launch(params.toString());
    }else 
       Toast.show('your device can\'t email from here. do email from email\'s gmail', context);
  }
   void visiteCnam(String url)async{
   
    if(await canLaunch(url)){
          await launch(url);
    }else 
       Toast.show('your device can call from here. do call from phone\'s call', context);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
              appBar: AppBar(title:Text(AppLocalization.of(context).contactUs),centerTitle: true,),
              backgroundColor: Theme.of(context).primaryColor,
              body:ListView(
                  children: <Widget>[
                    Container(
                      height:200,
                      
                      child:Center(
                        child:ClipOval(
                          
                          child: Image.asset('images/sympol.png',fit: BoxFit.cover,width: animation.value,height: animation.value,),)
                      )
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left:25,right:25),
                      child:RaisedButton(
                        splashColor: Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.all(10),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color:Theme.of(context).secondaryHeaderColor,width: 1.5)),
                        onPressed: ()=>phoneCall('1919'),
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                        SizedBox(width: 20,),
                        Icon(Icons.call,size: 30,color: Theme.of(context).accentColor,),
                        SizedBox(width: 20,),
                      Text(AppLocalization.of(context).callUs,style: TextStyle(color: Colors.white,fontSize: 15)),
                      ],),
                        
                    )),
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left:25,right:25),
                      child:RaisedButton(
                        splashColor: Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.all(10),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color:Theme.of(context).secondaryHeaderColor,width: 1.5)),
                        onPressed: ()=>sendMail(),
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                        SizedBox(width: 20,),
                        Icon(Icons.email,size: 30,color: Theme.of(context).accentColor,),
                        SizedBox(width: 20,),
                        Text(AppLocalization.of(context).smsemail,style: TextStyle(color: Colors.white,fontSize: 15)),
                      ],),
                        
                    )),
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left:25,right:25),
                      child:RaisedButton(
                        splashColor: Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.all(10),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color:Theme.of(context).secondaryHeaderColor,width: 1.5)),
                        onPressed: ()=>visiteCnam('https://www.cnam.mr'),
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                        SizedBox(width: 20,),
                        Icon(Icons.attachment,size: 30,color: Theme.of(context).accentColor,),
                        SizedBox(width: 20,),
                        Text(AppLocalization.of(context).notreLieu,style: TextStyle(color: Colors.white,fontSize: 15)),
                      ],),
                        
                    )),
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(left:25,right:25),
                      child:RaisedButton(
                        splashColor: Theme.of(context).secondaryHeaderColor,
                        padding: EdgeInsets.all(10),
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),side: BorderSide(color:Theme.of(context).secondaryHeaderColor,width: 1.5)),
                        onPressed: ()=>visiteCnam('https://maps.app.goo.gl/wKYbHFzssGXGuHCi6'),
                        color: Theme.of(context).primaryColor,
                        child: Row(children: <Widget>[
                        SizedBox(width: 20,),
                        Icon(Icons.location_on,size: 30,color: Theme.of(context).accentColor,),
                        SizedBox(width: 20,),
                        Text(AppLocalization.of(context).notreMapgoogle,style: TextStyle(color: Colors.white,fontSize: 15)),
                      ],),
                        
                    )),
                    Container(
                      margin: EdgeInsets.only(left:25,right:25),
                      child:Divider(height:20,color:Theme.of(context).accentColor.withOpacity(0.7)),),
                      Container(
                        margin:  EdgeInsets.only(left:30,right:30),
                        child: Text(
                          AppLocalization.of(context).help,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 17,
                          ),
                          // textAlign: TextAlign.start,
                        ),
                      )
                  ],
              )
            );
  }
}