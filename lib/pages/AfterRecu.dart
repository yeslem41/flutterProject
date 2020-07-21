import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
// import 'package:flushbar/flushbar.dart';

class AfterRecu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AfterRecuState();
  }


class _AfterRecuState extends State<AfterRecu> {
      //  List formInquity ;
      //    _AfterRecuState.formInquity(this.formInquity);
     Color buttonColor = Color(0xFFe81c8b).withOpacity(0.5);
     Map<String,dynamic> infoUser ;
     TextEditingController textController = TextEditingController();
     bool progress = false,snake=false;
     String snakeSms='',what='';
     GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //   @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
   _createAlbum() async{
     
     setState(() {progress = true; });
     try{
  Response reponse = await post(
    'https://miage2a2i.000webhostapp.com/inquiry_post.php',
    body:<String, String>{
      'body': textController.text,
      'recu':infoUser["recu"],
    },
  );
  if(reponse.statusCode != 200)
                 throw "errer du server";
   setState(() {progress = false; });
  print(infoUser[3]);
  var infos = jsonDecode(reponse.body);
  print(infos);
  if((infos[0]["success"] == "true") || (infos[0]["success"] == "fasle"))
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(infos[0]["desc"]),)) ;
   else  
   Toast.show('error of connection', context,duration: 3,gravity:Toast.CENTER);
 
 }catch(e){
   setState(() {progress = false; });
   print(e);
 }
  
  //  else
  // showSnak("error of connection");
}
 
  @override
  Widget build(BuildContext context) {
       infoUser = ModalRoute.of(context).settings.arguments;
       if(Localizations.localeOf(context).languageCode == 'fr')
              infoUser['cheked']=='rembourser'?what='de ${infoUser['cheked']}':what='d\'${infoUser['cheked']}';
       else
             infoUser['cheked']=='rembourser'?what='إعادة مال':what='الانتماء'; 
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      
      body:  SafeArea(
    
                 child: ListView(
                   scrollDirection: Axis.vertical,
                   children: <Widget>[
                      Container(
                                   child:Row(
                                   children: <Widget>[
                                    FlatButton(
                                    color: Colors.blue,
                                    splashColor: Theme.of(context).secondaryHeaderColor,
                                  // color: Colors.yellow,
                                      child:Row(
                                        children: <Widget>[
                                          SizedBox(width: 1,),
                                          Text(AppLocalization.of(context).demandeInfos,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                          Icon(Icons.create,size: 15,color:Theme.of(context).primaryColor,),
                                        ],
                                      ),
                                      onPressed: _dilog,
                                ),
                     ] )),

                          Container(
                            margin: EdgeInsets.only(left:10,right:10,top: 15),
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(25.0),
                            color: Theme.of(context).primaryColor,
                            ),
                            height: 50,
                            child:Center(
                              child: Text(AppLocalization.of(context).demandePropos+what,
                                style: TextStyle(color:Colors.white,),
                                textAlign: TextAlign.end,
                            ),)
                          ),
                   progress ?Container( 
                     margin: EdgeInsets.only(left:10,right:10),
                    
                     child:LinearProgressIndicator(backgroundColor: Theme.of(context).secondaryHeaderColor)):Container(),
                    Divider(height: 35,),
                    Container(
                      child: Center(child: Text(AppLocalization.of(context).reponse),),
                    ),
                     Padding(
                       padding: EdgeInsets.only(left:10,right:10),
                                    child:Card(
                                     elevation: 8.0,
                                     shape: StadiumBorder(
                                       side:BorderSide(
                                         color: Theme.of(context).secondaryHeaderColor,
                                         width: 2)
                                     ),
                                     child:Container(
                                      //  padding: EdgeInsets.all(auto),
                                       height: 50,
                                              child: Center(
                                                child: Text(
                                                          infoUser['libelle'],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                      ),
                                                      ),))),
                              ),
                              SizedBox(height:10),
                              Padding(
                                padding:EdgeInsets.fromLTRB(15, 2, 15, 2),
                                child: Table(
                                    
                                    border: TableBorder.all(color:Theme.of(context).primaryColor),
                                    children: [
                                      TableRow(
                                         decoration: BoxDecoration(
                                           color:Colors.blue,
                                         ),
                                          children:[
                                                Container(
                                                  padding: EdgeInsets.only(top:2,bottom:2),
                                                  child:Text(AppLocalization.of(context).recu,textAlign: TextAlign.center,)),
                                                
                                                Container(
                                                  padding: EdgeInsets.only(top:2,bottom:2),
                                                  child:Text(AppLocalization.of(context).matricule,textAlign: TextAlign.center,)),
                                                if(infoUser['mntR']!=null)
                                                Container(
                                                  padding: EdgeInsets.only(top:2,bottom:2),
                                                  child:Text(AppLocalization.of(context).rembourser,textAlign: TextAlign.center,)),
                                          ] 
                                      ),
                                      TableRow(
                                        
                                        decoration: BoxDecoration(
                                          
                                        ),
                                          children:[
                                                Container(
                                                  padding: EdgeInsets.only(top:5,bottom:5),
                                                    child: Text(infoUser["recu"],textAlign: TextAlign.center,),
                                                ),
                                                
                                                Container(
                                                  padding: EdgeInsets.only(top:5,bottom:5),
                                                  child:Text(infoUser['ARid'],textAlign: TextAlign.center,)
                                                ),
                                                if(infoUser['mntR']!=null)
                                                 Container(
                                                  padding: EdgeInsets.only(top:5,bottom:5),
                                                  child:Text(infoUser['mntR'],textAlign : TextAlign.center,),)
                                          ] 
                                      ),
                                    ],    
                                      )),
                              SizedBox(height: 35,),
                              //  Column(
                              //         crossAxisAlignment : CrossAxisAlignment.end,
                              //         children: <Widget>[
                              //           Padding(
                              //             padding: EdgeInsets.only(right:35,left:15),
                              //             child:Text('ستتمكن من إرسال أستفسار بعد أنتاه المد التي من المترض أن يعالج فيها ملفك أي بعد 7 أيام',
                              //               textAlign: TextAlign.end,
                              //               style: TextStyle(
                              //                 color: Colors.black,
                              //                 fontSize: 18,
                              //                 ),
                              //               ),)
                              //       ],) ,
                                  
                        ],
                 ),
         ),
      
      //    persistentFooterButtons: <Widget>[
      //        Container(
      //          width: MediaQuery.of(context).size.width,
      //          //alignment: Alignment.bottomCenter,
      //          child: Material(
      //            color: buttonColor,
      //            child: MaterialButton(
      //              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //              child: Text(
      //                ' إنشاء أستفسار',style: TextStyle(color: Colors.white,fontSize: 18),
      //              ),
      //               onPressed: _dilog,
      //             //(){
      //             //          _dilog;
      //                  //  navigateToSubPage(context) ;
      //               //  Toast.show('msg', context,duration: 3);
      //                 // setState((){buttonColor = Theme.of(context).accentColor;});
                      
      //               //  },
      //            ),
      //          )
      //        )
      // ],
      

    );
  }
  
  //   Future navigateToSubPage(context) async {
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>Recomandation(infoUser),));
// }
void _dilog(){
  showGeneralDialog(
    barrierLabel: 'Label',
    barrierDismissible: true,
    barrierColor: Color(0xFF2e3a8a),
     transitionDuration: Duration(milliseconds: 0),
    context: context, 
    pageBuilder: (context,anim1,anim2){
            return SafeArea(
            // backgroundColor:Color(0xFF2e3a8a),
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child:SafeArea(
                      child: ListView(
                        padding: EdgeInsets.only(left:25, right:25),
                         children:<Widget>[  
                                SizedBox(height: 25,),
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20,left: 15,right:35),
                                     child: TextField(
                                      controller: textController,  
                                      textAlign: TextAlign.start,  
                                      maxLines: 13,
                                      decoration: InputDecoration.collapsed(hintText: " أكتب أستفسارك هنا : تنبيه إلي أن أي إساءه يحاسب عليها"), 
                                      ),
                                      ),),
                              SizedBox(height: 30,),      
                                Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: Material(
                                            color: Color(0xFF43bdd2), 
                                            borderRadius: BorderRadius.circular(25.0),
                                            child: MaterialButton(
                                             onPressed:(){ _createAlbum();
                                             textController.clear();
                                               Navigator.pop(context);
                                              
                                             }, 
                                            // // Scaffold.of(context).showSnackBar(SnackBar(content: Text('first test in flutter')));
                                          
                                            child: Text('إرسال'),
                                            ),
                                            
                                            )  
                                )      
                                    
                              ],
                            
                      ),
                   ),
            ),
    );
    });
}


}








/*

 class Recomandation extends StatelessWidget{
  List user ;
     Recomandation(this.user);
  TextEditingController textController = TextEditingController();

  _createAlbum() async{
  var reponse = await post(
    'https://miage2a2i.000webhostapp.com/inquiry_post.php',
    body:<String, String>{
      'body': textController.text,
      'recu':'c13424',
    },
  );
  print(jsonEncode(<String, String>{
      'body': textController.text,
      'recu':'c13424',
    }));
  print(jsonDecode(reponse.body));
}

  // BuildContext context;
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return Scaffold(
            backgroundColor:Color(0xFF2e3a8a),
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
                   child: SafeArea(
                      child: ListView(
                        padding: EdgeInsets.only(left:25, right:25),
                         children:<Widget>[  
                                SizedBox(height: 25,),
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20,left: 15,right:15),
                                     child: TextField(
                                      controller: textController,  
                                      textAlign: TextAlign.end,  
                                      maxLines: 13,
                                      decoration: InputDecoration.collapsed(hintText: "أكتب أستفسارك"), 
                                      ),
                                      ),),
                              SizedBox(height: 30,),      
                                Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child:Builder(
                                      builder: (BuildContext context){
                                        
                                          return Material(
                                            color: Color(0xFF43bdd2), 
                                            borderRadius: BorderRadius.circular(25.0),
                                            child: MaterialButton(
                                             onPressed:(){
                                               Navigator.pop(context);
                                             }, 
                                            // // Scaffold.of(context).showSnackBar(SnackBar(content: Text('first test in flutter')));
                                          
                                            child: Text('إرسال'),
                                            ),
                                            
                                            );  })
                                )      
                                    
                              ],
                            
                      ),
                   ),
              ),
    );
  }
} 
*/

// children: <Widget>[
//              Text('dddd',style: TextStyle(color: Colors.black),),
//              SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),
//              SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//              Text('dddd',style: TextStyle(color: Colors.black),),SizedBox(height: 50,),
//            ],