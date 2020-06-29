import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
     List infoUser = [];
     TextEditingController textController = TextEditingController();
     bool progress = false,snake=false;
     String snakeSms='',sms='';
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
      'recu':infoUser[3],
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
       switch (infoUser[2]['libelle']) {
         case 'saisie':
         case 'premier validation':
         case 'deuxieme validation':
          setState(() { sms = 'En cours de traitement';});break;
         case 'en attente de paiment':  
         case 'en attente de validation bordereau': 
          setState(() { sms = 'En cours de paiement';});break; 
         default:
       }
      //  print(infoUser);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text(infoUser[3]["cheked"]) ,
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
      body:  SafeArea(
    
                 child: ListView(
                   scrollDirection: Axis.vertical,
                   children: <Widget>[
                          progress ? LinearProgressIndicator():Container(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                              children:<Widget>[
                                 Text(
                                infoUser[3]['cheked'],
                                textAlign: TextAlign.end,
                            ),
                              ]
                            ),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                              children:<Widget>[
                                 Text(infoUser[3]['cheked']+' matricule est :'+infoUser[1]['ARid'] ,
                                textAlign: TextAlign.end,
                            ),
                              ]
                            ),
                     Padding(
                       padding: EdgeInsets.only(left:10,right:10,top:35,),
                                child: Text(
                                            sms,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                        ),
                                        ),
                              ),
                              SizedBox(height:10),
                              Padding(
                                padding:EdgeInsets.fromLTRB(15, 2, 15, 2),
                                child: Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(
                                        
                                          children:[
                                                Text('recu',textAlign: TextAlign.center,),
                                                
                                                Text('matricule',textAlign: TextAlign.center,),
                                                
                                                Text('Mnt remboursé',textAlign: TextAlign.center,),
                                          ] 
                                      ),
                                      TableRow(
                                          children:[
                                                Text(infoUser[5],textAlign: TextAlign.center,),
                                                
                                                Text(infoUser[1]['ARid'],textAlign: TextAlign.center,),
                                                
                                                Text(infoUser[4]['mntR']!=null ? infoUser[4]['mntR'] :'invalid',textAlign: TextAlign.center,),
                                          ] 
                                      ),
                                    ],    
                                      )),
                              SizedBox(height: 35,),
                               Column(
                                      crossAxisAlignment : CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right:35,left:15),
                                          child:Text('ستتمكن من إرسال أستفسار بعد أنتاه المد التي من المترض أن يعالج فيها ملفك أي بعد 7 أيام',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                            ),)
                                    ],) ,
                                  
                        ],
                 ),
         ),
      
         persistentFooterButtons: <Widget>[
             Container(
               width: MediaQuery.of(context).size.width,
               //alignment: Alignment.bottomCenter,
               child: Material(
                 color: buttonColor,
                 child: MaterialButton(
                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   child: Text(
                     'إنشاء أستفسار',style: TextStyle(color: Colors.white,fontSize: 18),
                   ),
                    onPressed: _dilog,
                  //(){
                  //          _dilog;
                       //  navigateToSubPage(context) ;
                    //  Toast.show('msg', context,duration: 3);
                      // setState((){buttonColor = Theme.of(context).accentColor;});
                      
                    //  },
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
                                      textAlign: TextAlign.end,  
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