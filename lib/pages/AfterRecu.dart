import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

class AfterRecu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AfterRecuState();
  }


class _AfterRecuState extends State<AfterRecu> {

     List Array = [];
  @override
  Widget build(BuildContext context) {
       Array = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text('vvvvvvvv') ,
        centerTitle: true,/*Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('أستفسار')
                  ],
                ),
                Row(

                )
              ],
        )*/
      ),
      body: Center(
         child: ListView(
           children: <Widget>[
             Text('dddd',style: TextStyle(color: Colors.black),),
             SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),
             SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
             Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
           ],
         )
      ),
      persistentFooterButtons: <Widget>[
             Container(
               width: MediaQuery.of(context).size.width,
               //alignment: Alignment.bottomCenter,
               child: Material(
                 color: Theme.of(context).accentColor,
                 child: MaterialButton(
                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   child: Text(
                     'إنشاء أستفسار',style: TextStyle(color: Colors.white,fontSize: 18),
                   ),
                   onPressed: ()=>Toast.show('msg', context,duration: 3),
                 ),
               )
             )
      ],

      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(bottom: 3),
              child: Text("©Copyright Cnam 2020",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

        ),
      ),

    );
  }

}