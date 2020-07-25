//import 'dart:io';
import 'package:fluttercnam/pages/AfterRecu.dart';
import 'package:fluttercnam/pages/curvedBar.dart';

//import 'package:splashscreen/splashscreen.dart';
//import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/pages/dashpoard.dart';
import 'package:fluttercnam/pages/deconnect.dart';
import 'package:fluttercnam/pages/login_page.dart';
import 'package:fluttercnam/pages/reclamation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttercnam/locale/locales.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences login = await SharedPreferences.getInstance();
   var loged = login.getBool("login");
   bool myApp = loged==null ? false : loged;
  return runApp(MyApp(loged: myApp,));
}
class MyApp extends StatelessWidget{
  final bool loged ;
  MyApp({this.loged});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context)=>AppLocalization.of(context).AppName,
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('fr',''),
        Locale('ar','')
      ],
      // Localizations.localeOf(context).languageCode == 'ar'  ? 
      theme: ThemeData(
        fontFamily: 'Al-Jazeera-Arabic',
        primarySwatch: MaterialColor(0XFF2e3a8a, {
          50: Color.fromRGBO(18, 23, 54, 0.1),
          100: Color.fromRGBO(18, 23, 54, 0.2),
          200: Color.fromRGBO(18, 23, 54, 0.3),
          300: Color.fromRGBO(18, 23, 54, 0.4),
          400: Color.fromRGBO(18, 23, 54, 0.5),
          500: Color.fromRGBO(18, 23, 54, 0.6),
          600: Color.fromRGBO(18, 23, 54, 0.7),
          700: Color.fromRGBO(18, 23, 54, 0.8),
          800: Color.fromRGBO(18, 23, 54, 0.9),
          900: Color.fromRGBO(18, 23, 54, 1),
        }),
        accentColor: MaterialColor(0XFFe81c8b, {
        50: Color.fromRGBO(91, 11, 54, 0.1),
        100: Color.fromRGBO(91, 11, 54, 0.2),
        200: Color.fromRGBO(91, 11, 54, 0.3),
        300: Color.fromRGBO(91, 11, 54, 0.4),
        400: Color.fromRGBO(91, 11, 54, 0.5),
        500: Color.fromRGBO(91, 11, 54, 0.6),
        600: Color.fromRGBO(91, 11, 54, 0.7),
        700: Color.fromRGBO(91, 11, 54, 0.8),
        800: Color.fromRGBO(91, 11, 54, 0.9),
        900: Color.fromRGBO(91, 11, 54, 1),
      }),
        secondaryHeaderColor:MaterialColor(0XFF43bdd2, {
          50:Color.fromRGBO(33, 75, 84, 0.1),
          100:Color.fromRGBO(33, 75, 84, 0.2),
          200:Color.fromRGBO(33, 75, 84 ,0.3),
          300:Color.fromRGBO(33, 75, 84 ,0.4),
          400:Color.fromRGBO(33, 75, 84 ,0.5),
          500:Color.fromRGBO(33, 75, 84 ,0.6),
          600:Color.fromRGBO(33, 75, 84 ,0.7),
          700:Color.fromRGBO(33, 75, 84 ,0.8),
          800:Color.fromRGBO(33, 75, 84 ,0.9),
          900:Color.fromRGBO(33, 75, 84 ,1),
        }),
        scaffoldBackgroundColor: Colors.white,
      ),
      //home: Auth.isLogin?Pageprincipale():LoginPage(),
      routes: {
       '/':(context)=>Splash(loged: loged),
       '/PagePrincipale':(_) => curvedBar(),
        '/AfterRecu':(_)=>AfterRecu(),
        '/LoginPage':(_)=>LoginPage(),
        '/Reclammation':(_)=>Reclammation(),
        '/deconnected':(_)=>Deconnect()
      }
    );
  }
}
//LoginPage
class Splash extends StatefulWidget {
  bool loged;
  Splash({this.loged});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds:3),(){
      if(widget.loged)
        return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=> Dashboard()),(Route<dynamic> route)=>false);
      else 
        return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=> LoginPage()),(Route<dynamic> route)=>false);            
                     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
         backgroundColor: Colors.white,   
         body:Center(  
           
                child:Container(
                  color: Colors.white,
                     height: 150,
                     child: Center(
                       child:Image.asset('images/cnami.jpg'),
                     ),

              ))
          
    );
    
  }
}

