import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercnam/locale/locales.dart';
import 'package:fluttercnam/pages/helperDB.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class Reclammation extends StatefulWidget {
  @override
  _ReclammationState createState() => _ReclammationState();
}

class _ReclammationState extends State<Reclammation> {
  // get textController => null;
TextEditingController textController =TextEditingController();
TextEditingController matController = TextEditingController();
TextEditingController recuController = TextEditingController();
TextEditingController nniController = TextEditingController();
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String type ,typeCheck='';
var formKey = GlobalKey<FormState>();
HelperDB DB = HelperDB();
List<reclamation> listReclas;
List getReclas=[];
List getReponse=[];
GlobalKey<RefreshIndicatorState> refreshKey;
Map<String,dynamic> infosPostRecla ;
 bool progress = false,posted=false,getRelasBool=false,failGetReclas=true,noRecla = false;
  String dateFromatted = '',lang='';
 int index = 0;
 SharedPreferences reponses;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    initReponse();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    
  }
  Future<Null> initReponse() async{
     reponses = await SharedPreferences.getInstance();
                    // bool alreadyGet = reponses.getBool("getReclamations")==true?true:false;
                    //             if(!alreadyGet)
                    //               return null;
                                  
    String imaUser = reponses.getString("recu");
      try{
          Response response = await get('https://miage2a2i.000webhostapp.com/get_reponses.php?superuser='+imaUser);
          if(response.statusCode != 200)
             throw 'errer du service';
             getReponse = jsonDecode(response.body);
             print(getReponse);
      }catch(e){
          Toast.show('error du service', context,duration: 2,gravity: Toast.TOP);
          return null;
      }
       
        for(int i=0;i<getReponse.length;i++){
          // if(!reponses.containsKey(getReponse[i]['recla_id'])){
                       
                       reponses.setString(getReponse[i]['recla_id'].toString()+'etat', getReponse[i]['etat']);
                        reponses.setString(getReponse[i]['recla_id'].toString()+'body', getReponse[i]['body']);
                      //  print(reponses.getString(getReponse[i]['recla_id']));
                      //  }
        }
     
  }
  Future<Null>init()async{
    var use = await SharedPreferences.getInstance();
   bool alreadyGet = use?.getBool("getReclamations")==true?true : false;print(alreadyGet);
    if(!alreadyGet){
    getReclas.clear();
      
    try{
    var use = await SharedPreferences.getInstance();
      String imaUser = use.getString("recu");print(imaUser);
    Response allReclas = await get('https://miage2a2i.000webhostapp.com/getReclas.php?superImat='+imaUser);
    if(allReclas.statusCode != 200)
         throw 'erreur du service';
       getReclas = jsonDecode(allReclas.body);print(getReclas);
       }catch(e){
         print('reclas');
         print(e);
         print('reclas');
         setState(() {
           getRelasBool=true;
         });
       }
        if(getReclas.isNotEmpty){
         if(getReclas[0]["noRecla"] == "yes"){
           setState(() { noRecla = true; });
           return null;
          }else{ setState(() { noRecla = false; }); 
          for(int i=0;i<getReclas.length;i++)
           DB.insertRecla(reclamation(getReclas[i]['recla_id'].toString(),getReclas[i]['body'],getReclas[i]['superMat'],getReclas[i]['imat'],getReclas[i]['time'],getReclas[i]['nni'],getReclas[i]['recu'],getReclas[i]['type']))  ;  
         var use = await SharedPreferences.getInstance();
         use.setBool('getReclamations', true);
         setState(() {
           failGetReclas=false;
         });
         }
       }
       }else{
          setState(() {failGetReclas=false;});}
          try{ 
       listReclas = await DB.getAllRecla();
       print(listReclas);
       }catch(e){
         print('e');
            print(e);
            print('e');
       }
      //  await DB.closeDB();
        setState(() {
           getRelasBool=true;
         });
  }
  Future<Null> refresh()async{
                   init();
                   initReponse();
  }
  @override
  Widget build(BuildContext context) {
//  print(listReclas.length);
    return Scaffold(
      key: _scaffoldKey,
         body:SafeArea(
             child: Column(
                   children:<Widget>[
                        Container(
                      height: 100.0,
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.only(
                          top: 10, end: 20, start: 20),
                      child: Image.asset('images/sympol.png',),
                          ),   
                  progress ?LinearProgressIndicator(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,):Container(),
             noRecla ?Container(child:Text(AppLocalization.of(context).AucunRecla)): getRelasBool&&!failGetReclas? 
             Expanded(
               child:RefreshIndicator(
                 semanticsValue: 'refresh',
                 semanticsLabel: 'refresh h',
                 key:refreshKey,
                 color: Theme.of(context).secondaryHeaderColor,
                 backgroundColor: Theme.of(context).accentColor,
                 onRefresh:refresh,
                 child:ListView.builder(
                                      itemCount: listReclas?.length??0,
                                      itemBuilder: (context,index){
                                        return Container(
                                           margin: EdgeInsets.all(5),
                                            // color: Theme.of(context).secondaryHeaderColor,
                                          child:Column(
                                          children:<Widget>[
                                            Container(
                                              
                                              color: Theme.of(context).secondaryHeaderColor,
                                              padding: EdgeInsets.only(left:10,right:10),
                                              child:Row(
                                                textDirection: TextDirection.ltr,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:<Widget>[
                                                  Text('${listReclas[index].type}'),
                                                  // reponses.containsKey(listReclas[index].id_recla.toString())?
                                                  Text('${reponses?.getString(listReclas[index].id_recla.toString()+'etat')??'non résolu'}'),
                                                ]
                                              )
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              color: Theme.of(context).secondaryHeaderColor,
                                              padding: EdgeInsets.only(right: 10,top: 5,left: 10),
                                            child:Text('${listReclas[index].body}',
                                            style: TextStyle(decoration:TextDecoration.none,fontSize: 15,
                                            wordSpacing: 0.5,
                                            letterSpacing: 0
                                            ),textAlign: TextAlign.center,),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              color:Colors.blue,
                                              child:Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children:<Widget>[ 
                                               Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].dateNow}'),),
                                                Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].recu}'),),
                                                Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].nni}'),),
                                                     ]
                                            )
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width-20,
                                              margin: EdgeInsets.only(left:10,right:10),
                                              padding:reponses?.getString(listReclas[index].id_recla.toString()+'body')!=null? EdgeInsets.all(10):EdgeInsets.all(0),
                                              child: Text('${reponses?.getString(listReclas[index].id_recla.toString()+'body')??AppLocalization.of(context).norepear}',textAlign: TextAlign.center,),
                                              decoration: BoxDecoration(
                                                color:Colors.green.withOpacity(0.5),
                                                border: Border(top:BorderSide(color:Theme.of(context).accentColor),
                                                bottom:BorderSide(color:Theme.of(context).accentColor),
                                                left:BorderSide(color:Theme.of(context).accentColor),
                                                right:BorderSide(color:Theme.of(context).accentColor)),
                                                borderRadius: BorderRadius.all(Radius.circular(12))
                                              ),
                                            )
                                          ],
                                        )
                                        );
                                      },
                                      ),
                                  )) :getRelasBool&&failGetReclas ?Container(
                          padding: EdgeInsets.only(top:60),
                          child:RaisedButton(
                            
                            onPressed:(){
                              setState(() {
                                failGetReclas=true;noRecla = false;getRelasBool=false;
                              });
                              refresh();},
                            child: Text('refresh!!'),)
                          ): Center(child: Text('Loading....'),)
                        ,
                   ]
           ),
                   ),
                   floatingActionButton: Container(
                               width: 40,
                               height:40,
                               decoration: BoxDecoration(
                               color: Theme.of(context).accentColor,
                                 borderRadius:BorderRadius.all(Radius.circular(50))
                               ),
                               child:InkWell( 
                                      onTap: (){
                                        Navigator.of(context).pushNamed('/addRecla');
                                      },
                                     child:Icon(Icons.create,color: Theme.of(context).primaryColor,size: 25,)
                                 )
                               ),
    );
  }

  
}











class addRecla extends StatefulWidget {
  @override
  _addReclaState createState() => _addReclaState();
}

class _addReclaState extends State<addRecla> {
  TextEditingController textController =TextEditingController();
TextEditingController matController = TextEditingController();
TextEditingController recuController = TextEditingController();
TextEditingController nniController = TextEditingController();
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String type ,typeCheck='';
var formKey = GlobalKey<FormState>();
HelperDB DB = HelperDB();
List<reclamation> listReclas;
List getReclas=[];
Map<String,dynamic> infosPostRecla ;
 bool progress = false,posted=false;
 List <String> langCodes = ["ar","fr"];
  String dateFromatted = '',lang='',recla_id;
 int index = 0;
  @override
  Widget build(BuildContext context) {
    lang = Localizations.localeOf(context).languageCode;
    if(!langCodes.contains(lang))
              lang = 'fr';
    return Scaffold(  
      key: _scaffoldKey,
      appBar: AppBar(title:Text(AppLocalization.of(context).creerecla,)),
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
                                      padding: EdgeInsets.only(top: 10,left: 15,right:15),
                                     child: TextFormField(
                                      controller: textController,  
                                      validator: (val)=>val.length < 50 ?'${AppLocalization.of(context).taillerecla}':null,
                                      maxLines: 8,
                                      decoration: InputDecoration.collapsed(hintText: '${AppLocalization.of(context).hintcontenurecla}'), 
                                      ),
                                      ),),
                                      
                                      SizedBox(height: 10,),
                                      // Card(
                                        
                                      //   color: Theme.of(context).primaryColor,
                                    Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: TextFormField( 
                                            controller: recuController,
                                            textAlign: TextAlign.center,
                                            validator: null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:AppLocalization.of(context).hintRecu,
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
                                            )) ,
                                     SizedBox(height: 15,), 
                                     
                                       Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: TextFormField( 
                                            controller: matController,
                                            textAlign: TextAlign.center,
                                            validator:null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:AppLocalization.of(context).hintmatricule,
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
                                      ),
                                      SizedBox(height: 15,),
                                       Padding(
                                    padding: EdgeInsets.only(left:35,right:35),
                                    child: TextFormField( 
                                            controller: nniController,
                                            textAlign: TextAlign.center,
                                            validator: (val)=>val.length==0?AppLocalization.of(context).nnivide:val.length != 10 ? AppLocalization.of(context).nniincorrect: null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:AppLocalization.of(context).nni,
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
                                      ),
                                      SizedBox(height: 15,),
                                      Padding(
                                    padding: EdgeInsets.only(left:70,right:70),
                                    child: DropdownButton(
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                      elevation: 24,
                                      focusColor: Theme.of(context).accentColor,
                                      iconEnabledColor: Theme.of(context).secondaryHeaderColor,
                                      hint:Text(AppLocalization.of(context).dossiertype,textAlign: TextAlign.center,),
                                      value: type,
                                      items: [
                                        DropdownMenuItem(child: Text(AppLocalization.of(context).choiDossier,),value: 'affiliation',),
                                        DropdownMenuItem(child: Text(AppLocalization.of(context).choiRembourser),value: 'remboursement',),
                                      ], 
                                      onChanged: (val){
                                        print(val.toString());
                                        setState(() {
                                          type=val.toString();
                                        });
                                        print(type);
                                      },
                                      ) 
                                      ),
                                      SizedBox(height: 15,),
                                Padding(
                                    padding: EdgeInsets.only(left:55,right:55),
                                    child: Material(
                                            color: Color(0xFF43bdd2), 
                                            borderRadius: BorderRadius.circular(25.0),
                                            child: MaterialButton( 
                                             onPressed:(){
                                              //  saveReclamation(); 
                                              //  _createAlbum();
                                            if(formKey.currentState.validate()){
                                              if(type == null)
                                               return Toast.show(AppLocalization.of(context).selectiontype, context,duration: 2);
                                              saveReclamation(); 
                                              }
                                               
                                              
                                             }, 
                                            // // Scaffold.of(context).showSnackBar(SnackBar(content: Text('first test in flutter')));
                                          
                                            child: Text(AppLocalization.of(context).envoyer),
                                            ),
                                            
                                            )  
                                ) , 
                                      SizedBox(height: 30,),    
                                    
                              ],
                            
                      )),
                   ));
  }
  void saveReclamation()async{
  _showIndecator();
   var use = await SharedPreferences.getInstance();
      String imaUser = use.getString("recu");
     await _createAlbum(imaUser);
    Navigator.pop(context);
     if(posted){
    reclamation r = reclamation(recla_id,textController.text,imaUser,matController.text,dateFromatted,nniController.text,recuController.text,type);
    HelperDB DB = HelperDB();
    await DB.insertRecla(r);
             }
            //  Navigator.of(context).pushNamed('/Reclammation');
}
_createAlbum(String imaUser) async{
     String m=matController.text;
     print(textController.text);print(imaUser);print(matController.text);print(nniController.text);print(recuController.text);
     print(type);print(lang);print(m);
     try{
  Response reponse = await post(
    'https://miage2a2i.000webhostapp.com/inquiry_post.php',
    body:<String, String>{
      'body': textController.text,
      'superUser':imaUser,
      'imat':matController.text,
      'nni':nniController.text,
      'recu':recuController.text,
      'type':type,
      'lang':lang,
    },
  );
  if(reponse.statusCode != 200)
         throw "errer du server";
   
    infosPostRecla = json.decode(reponse.body);
 
 }catch(e){
   Toast.show('error du service', context,duration: 3,gravity:Toast.CENTER);
   return null;
 }
 if(infosPostRecla.isNotEmpty){ 
  if(infosPostRecla["invalid"]=="true"){
    Toast.show('IDN invalid', context,duration: 3,gravity: Toast.CENTER);
    posted=false;
     
    return null;
  }
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(infosPostRecla["desc"]),)) ;
    if(infosPostRecla["success"] == "true"){
                 recla_id = infosPostRecla['recla_id'].toString();
                dateFromatted = infosPostRecla['date'];
                posted = true;
                
             return null;
   }
   }else  
      Toast.show(AppLocalization.of(context).erreurService, context,duration: 3,gravity:Toast.CENTER);
 
}
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
         });
           }
}