import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:fluttercnam/pages/helperDB.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AfterRecu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AfterRecuState();
  }


class _AfterRecuState extends State<AfterRecu> {
      //  List formInquity ;
      //    _AfterRecuState.formInquity(this.formInquity);
     Color buttonColor = Color(0xFFe81c8b).withOpacity(0.5);
     Map<String,dynamic> infoUser,infosPostRecla;
     TextEditingController textController = TextEditingController();
     TextEditingController nniController = TextEditingController();
     bool progress = false,snake=false,posted=false;
     String snakeSms='',what='',recu='',dateFromatted='';
     GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
     var formKey = GlobalKey<FormState>();
  //   @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
   
 
  @override
  Widget build(BuildContext context) {
       infoUser = ModalRoute.of(context).settings.arguments;
       recu = infoUser['recu'];
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
                              
                                  
                        ],
                 ),
         ),
      

    );
  }
  
  
void _dilog(){
  showGeneralDialog(
    barrierLabel: 'Label',
    barrierDismissible: true,
    barrierColor: Color(0xFF2e3a8a),
     transitionDuration: Duration(milliseconds: 0),
    context: context, 
    pageBuilder: (context,anim1,anim2){
            return Scaffold(
              backgroundColor: Color(0xFF2e3a8a),
              body:GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
               child:Form( 
                   key: formKey,
                      child: ListView(
                        padding: EdgeInsets.only(left:25, right:25),
                         children:<Widget>[  
                                SizedBox(height: 25,),
                                Card(
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20,left: 15,right:35),
                                     child: TextFormField(
                                      controller: textController,  
                                      textAlign: Localizations.localeOf(context).languageCode=='fr' ? TextAlign.start:TextAlign.end,  
                                      maxLines: 13,
                                      decoration: InputDecoration.collapsed(hintText: " أكتب أستفسارك هنا : تنبيه إلي أن أي إساءه يحاسب عليها"), 
                                      ),
                                      ),),
                                      SizedBox(height:15),
                                      Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: Material(
                                       color: Theme.of(context).primaryColor,
                                        child:TextFormField( 
                                            controller: nniController,
                                            textAlign: TextAlign.center,
                                            validator: (val)=>val.length <= 5 ? 'enter matricule cnam' : null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:'nni Obligatoire',
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                              labelStyle: TextStyle(
                                                color: Colors.black.withBlue(100),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                                   border: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(50.0)
                                                   )
                                            ),
                                            ) 
                                    ) 
                                      ),
                              SizedBox(height: 30,),      
                                Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: Material(
                                            color: Color(0xFF43bdd2), 
                                            borderRadius: BorderRadius.circular(25.0),
                                            child: MaterialButton(
                                             onPressed:(){ 
                                               if(formKey.currentState.validate()){
                                                  saveReclamation();
                                                  Navigator.pop(context);
                                                       }
                                             }, 
                                            child: Text('إرسال'),
                                            ),
                                            
                                            )  
                                )      
                                    
                              ],
                            
                      )),
                   ),
          
    );
    });
}
void saveReclamation()async{
   var use = await SharedPreferences.getInstance();
      String imaUser = use.getString("recu");
     await _createAlbum(imaUser);
     if(posted){
       print(dateFromatted);
    reclamation r = reclamation(textController.text,imaUser,'',dateFromatted,nniController.text,infoUser["recu"]);
    HelperDB DB = HelperDB();
    await DB.insertRecla(r);
    
             }
}
_createAlbum(String imaUser) async{
     
     setState(() {progress = true; });
     try{
  Response reponse = await post(
    'https://miage2a2i.000webhostapp.com/inquiry_post.php',
    body:<String, String>{
      'body': textController.text,
      'superUser':imaUser,
      'imat':'null',
      'nni':nniController.text,
      'recu':infoUser["recu"],
    },
  );
   if(reponse.statusCode != 200)
                 throw "errer du server";
   setState(() {progress = false; });
    infosPostRecla = json.decode(reponse.body);
  print(infosPostRecla);
 
 }catch(e){
   setState(() {progress = false; });
   Toast.show('error of service', context,duration: 3,gravity:Toast.CENTER);
   return null;
 }
 setState(() {progress = false; });
 if(infosPostRecla.isNotEmpty){ 
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(infosPostRecla["desc"]),)) ;
    if(infosPostRecla["success"] == "true"){
                dateFromatted = infosPostRecla['date'];
                posted = true;
   
   }
   }else  
      Toast.show('error of connection', context,duration: 3,gravity:Toast.CENTER);
 
}

}

// _createAlbum(String imaUser) async{
     
//      setState(() {progress = true; });
//      try{
//   Response reponse = await post(
//     'https://miage2a2i.000webhostapp.com/inquiry_post.php',
//     body:<String, String>{
//       'body': textController.text,
//       'superUser':imaUser,
//       'imat':matController.text,
//       'nni':nniController.text,
//       'recu':recuController.text,
//     },
//   );
//   if(reponse.statusCode != 200)
//                  throw "errer du server";
//    setState(() {progress = false; });
//     infosPostRecla = json.decode(reponse.body);
//   print(infosPostRecla);
 
//  }catch(e){
//    setState(() {progress = false; });
//    Toast.show('error of service', context,duration: 3,gravity:Toast.CENTER);
//    return null;
//  }
//  if(infosPostRecla.isNotEmpty){ 
//   // if((infosPostRecla["success"] == "true") || (infosPostRecla["success"] == "fasle")){
//     scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(infosPostRecla["desc"]),)) ;
//     if(infosPostRecla["success"] == "true"){
//                 dateFromatted = infosPostRecla['date'];
//                 posted = true;
   
//    }
//    }else  
//       Toast.show('error of connection', context,duration: 3,gravity:Toast.CENTER);
 
// }







