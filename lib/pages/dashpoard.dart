import 'dart:math';
// import 'dart:convert';
// // import 'package:flutter/cupertino.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/pages/reclamation.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override 
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor:Theme.of(context).secondaryHeaderColor,
        body:
      // SafeArea(
      //    child:Column(
      //      children: <Widget>[
      //           Container(height:100),
      //              Stack(
      //                       children: [
                              
      //                         Container(
      //                               child:ClipPath(
      //                                   clipper: myclipper(),
      //                                   child:Container(
      //                                     height:300,
      //                                     color:Colors.blue,
      //                                   )
      //                                 ),
      //                             )
      //                       ],
      //                   )
      //    ],)),
    
     new SafeArea(
       child:Container(
         color: Theme.of(context).secondaryHeaderColor,
                child:Column(
                  children: <Widget>[
                    Container( 
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left:50,right: 50),
                      color:Theme.of(context).primaryColor,
                    child:Container(     
                                  color:Colors.white,
                          height: 80.0,
                          child: Padding(
                            
                            padding: EdgeInsetsDirectional.only(end:80,start: 80),
                            child: Image.asset('images/cnami.jpg',),
                            ),
                          margin: EdgeInsets.only(left: 0,right: 0),
                        )),
                Container(height:25,color: Colors.white,),
                Expanded( 
                  child:ClipPath( 
                     clipper: myclipper(),
                        
                            child:Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              // borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                              //  boxShadow: [
                              //         BoxShadow(
                              //           color:Theme.of(context).accentColor,
                              //           blurRadius: 4.0,
                              //           spreadRadius: 2,
                              //           offset: Offset(0, 1)
                              //           ) 
                              //         ]
                              ),
                              padding: EdgeInsets.only(top: 35),
                              
                             
                                    child: GridView.count(
                                      
                                      padding: EdgeInsets.only(left: 15,right:15),
                                        // Create a grid with 2 columns. If you change the scrollDirection to
                                        // horizontal, this produces 2 rows.
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 30,
                                        // Generate 100 widgets that display their index in the List.
                                        children: <Widget>[
                                          Padding(
                                        
                                            padding: EdgeInsets.only(left: 45,bottom: 15),
                                            child:Container(
                                              margin: EdgeInsets.only(top:1),
                                              width: 100,
                                              child:InkWell(
                                                onTap: (){
                                                  Navigator.of(context).pushNamed('/PagePrincipale');
                                                },
                                                child:Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(height:5),
                                                   Container(
                                                          width: 55,
                                                          height: 55,  
                                                      child:CustomPaint(
                                                           size: Size.square(100),
                                                           painter: CirclePainter(context: context),
                                                          child:ClipOval(
                                                      child: Icon(Icons.library_books), 
                                                        ))),
                                                    SizedBox(height: 5,),
                                                    Text('suivi des dossiers',textAlign: TextAlign.center,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        Padding(
                                            padding: EdgeInsets.only(right: 30,bottom: 15,),
                                            child:Container(
                                              margin: EdgeInsets.only(top:1),
                                              
                                              width: 100,
                                              child:InkWell(
                                                onTap: (){
                                                  print('object2');
                                                  // Navigator.pushAndRemoveUntil(
                                                  //   context, 
                                                  //   MaterialPageRoute(builder: (context)=>Reclammation()), (Route<dynamic> route)=>false);
                                                  Navigator.of(context).pushNamed('/Reclammation');
                                                  },
                                                
                                                child:Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                     SizedBox(height:5),
                                               Container(
                                                          width:55,
                                                          height:55,  
                                                          child:CustomPaint( 
                                                          size: Size.square(100),
                                                          painter:CirclePainter(context: context),
                                                      child: ClipOval(
                                                              child: Icon(Icons.forum), 
                                                    ))),
                                                    SizedBox(height: 5,),
                                                    Text('gestion de reclammation',textAlign: TextAlign.center,)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 45,bottom: 15),
                                            child:Container(
                                              width: 100,
                                              child: InkWell(
                                                onTap: (){print('object3');},
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                          width: 55,
                                                          height: 55,
                                                        child:CustomPaint( 
                                                          size: Size.square(100),
                                                          painter:CirclePainter(context: context), 
                                                      child:ClipOval(
                                                               child: Icon(Icons.live_help,), 
                                                    ))),
                                                    SizedBox(height: 5,),
                                                    Text('fragment')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                     
                                        Padding(
                                            padding: EdgeInsets.only(right: 30,bottom: 15),
                                            child:Container(
                                             
                                              width: 100,
                                              child:InkWell(
                                                onTap: (){print('object4');},
                                                child:Column(
                                                  children: <Widget>[
                                                    Container(
                                                          width: 55,
                                                          height: 55,  
                                                        child:CustomPaint( 
                                                          size: Size.square(100),
                                                          painter:CirclePainter(context: context),
                                                      child:ClipOval(
                                                            child: Icon(Icons.power_settings_new)
                                                              )
                                                    )),
                                                    SizedBox(height: 5,),
                                                    Text('Déconnecté')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                              )
                              ))
                   ),

     ],))),
    
     bottomNavigationBar: Container(
          color:Theme.of(context).secondaryHeaderColor,
          height: 15,
             child:Center(
               child:Text('copy right cnam 2020',style: TextStyle(color:Colors.black),)
     )
     ),
      
     );
  }
}

class myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
   var path =Path();
     // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height - 10);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
   
    path.lineTo(size.width, 0.0);

    // path.quadraticBezierTo((size.width - size.width/4), 40, size.width/2, 20);

    // path.quadraticBezierTo(size.width/4, 0, 0, 30);

    // var thirdControlPoint = Offset(size.width -(size.width/4), 0);
    // var thirdEndPoint = Offset(size.width/2.25, 20);
    // path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,thirdEndPoint.dx, thirdEndPoint.dy);

    // var fourthControlPoint = Offset(size.width-(size.width/3),45);
    // var fourthEndPoint =  Offset(0, 20);
    // path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,fourthEndPoint.dx, fourthEndPoint.dy);
    // path.lineTo(0.0, 0.0);
    path.close();
    return path;
  // print(size);

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

  
}
class footClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.quadraticBezierTo((size.width - size.width/4), 40, size.width/2, 20);

    path.quadraticBezierTo(size.width/4, 0, 0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
  
}
class CirclePainter extends CustomPainter {
  BuildContext context;
  CirclePainter({this.context});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint innerLine = Paint()
    ..color = Theme.of(context).accentColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;


     Paint outLine = Paint()
    ..color = Theme.of(context).primaryColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

    canvas.drawArc(
        Rect.fromCircle(center:Offset(size.width/2,size.height/2),radius: size.width/2), 
        -pi/3, 
        5*pi/3, 
        false,
         innerLine);


         canvas.drawArc(
        Rect.fromCircle(center:Offset(size.width/2,size.height/2),radius: (size.width+10)/2), 
        2*pi/3, 
       5*pi/3, 
        false,
         outLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}