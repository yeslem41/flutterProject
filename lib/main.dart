//import 'dart:io';
import 'package:fluttercnam/pages/AfterRecu.dart';
import 'package:fluttercnam/pages/PagePrincipale.dart';
//import 'package:splashscreen/splashscreen.dart';
//import 'package:toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                   print(loged);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MACNAMI',
      theme: ThemeData(
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
       '/':(context)=> loged ? Pageprincipale():Splash(),
       '/PagePrincipale':(_) => Pageprincipale(),
        '/AfterRecu':(_)=>AfterRecu(),
        '/LoginPage':(_)=>LoginPage(),
      }
    );
  }
}
//LoginPage
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds:3),()=>Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(
                       builder:(context)=> LoginPage()

                     ),
                         (Route<dynamic> route)=>false));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient:LinearGradient(
                  //center:FractionalOffset.center,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                 // transform: GradientRotation(3.144/3),
                  colors: [Theme.of(context).accentColor,Theme.of(context).primaryColor,Theme.of(context).secondaryHeaderColor],
                  //stops: [0.3,0.5,0.1],

                )
              ),
            ),
            Center(

                  child:Text('Bienvenue à Macnami',style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 12
                      ),),

            )
          ],
    );/*Scaffold(
      body:Center(
           child: Image(
             width: 100,
             height: 100,
             image: AssetImage('images/sympol.png'),
           ),
        ),

    );*/
  }
}

