import 'dart:math';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new GestureDetector(
        child:Column(
          children: <Widget>[
                Container(
                   height: 130.0,
                  width: double.infinity,
                  child: Padding(
                     padding: EdgeInsetsDirectional.only(top:35,end:25,start: 25),
                     child: Image.asset('images/cnami.jpg',),
                     ),
                  margin: EdgeInsets.only(bottom:20,left: 0,right: 0),
                ),
                Expanded( 
                
                child:Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                   borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
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
                  margin: EdgeInsets.only(right:5,left:5), 
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
                            
                                padding: EdgeInsets.only(left: 45,bottom: 10),
                                child:Container(
                                  margin: EdgeInsets.only(top:1),
                                  decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                boxShadow: [
                                        BoxShadow(
                                          color:Theme.of(context).primaryColor,
                                          blurRadius: 3.0,
                                          spreadRadius: -1,
                                          offset: Offset(0, 1)
                                          ) 
                                        ]
                                ),
                                  width: 100,
                                  child:InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed('/PagePrincipale');
                                    },
                                    child:Column(
                                      children: <Widget>[
                                        ClipOval(
                                      child: Image.asset('images/dossier.png'), 
                                        ),
                                        Text('suivi dossier en ligne',textAlign: TextAlign.center,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                                padding: EdgeInsets.only(right: 45,bottom: 10),
                                child:Container(
                                  margin: EdgeInsets.only(top:1),
                                   decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                boxShadow: [
                                        BoxShadow(
                                          color:Theme.of(context).primaryColor,
                                          blurRadius: 3.0,
                                          spreadRadius: -1,
                                          offset: Offset(0, 1)
                                          ) 
                                        ]
                                ),
                                  width: 100,
                                  child:InkWell(
                                    onTap: (){print('object2');},
                                    child:Column(
                                      children: <Widget>[
                                        ClipOval(
                                      child: Image.asset('images/imageout.png'), 
                                        ),
                                        Text('Déconnecté')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 45,bottom: 10),
                                child:Container(
                                   decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                boxShadow: [
                                        BoxShadow(
                                          color:Theme.of(context).primaryColor,
                                          blurRadius: 3.0,
                                          spreadRadius: -1,
                                          offset: Offset(0, 1)
                                          ) 
                                        ]
                                ),
                                  width: 100,
                                  child: InkWell(
                                    onTap: (){print('object3');},
                                    child:Column(
                                      children: <Widget>[
                                        ClipOval(
                                      child: Image.asset('images/reclamation.png'), 
                                        ),
                                        Text('envoyer recomandation',textAlign: TextAlign.center,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                                padding: EdgeInsets.only(right: 45,bottom: 10),
                                child:Container(
                                   decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                boxShadow: [
                                        BoxShadow(
                                          color:Theme.of(context).primaryColor,
                                          blurRadius: 3.0,
                                          spreadRadius: -1,
                                          offset: Offset(0, 1)
                                          ) 
                                        ]
                                ),
                                  width: 100,
                                  child:InkWell(
                                    onTap: (){print('object4');},
                                    child:Column(
                                      children: <Widget>[
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration:BoxDecoration(
                                                color: const Color(0xff7c94b6),
                                                borderRadius: new BorderRadius.all(new Radius.circular(250)),
                                                border: new Border.all(
                                                  color: Theme.of(context).primaryColor,
                                                  width: 4,
                                                ),
                                          ) ,
                                           child:ClipOval(
                                                child: Image.asset('images/imageout.png'),
                                                  )
                                        ),
                                        Text('Déconnecté')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                  ))),

     ],)),
     bottomNavigationBar: Container(
          height: 25,
             child: Center(
               child:Text('copy right cnam202')
             ),
     ),
      
     );
  }
}