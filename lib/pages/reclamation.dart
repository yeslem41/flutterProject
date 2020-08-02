import 'dart:convert';
import 'package:flutter/material.dart';
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
var formKey = GlobalKey<FormState>();
HelperDB DB = HelperDB();
List<reclamation> listReclas;
List getReclas=[];
Map<String,dynamic> infosPostRecla ;
 bool progress = false,posted=false,getRelasBool=false,failGetReclas=true,noRecla = false;
 GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String dateFromatted = '',lang='';
 int index = 0;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init()async{
    var use = await SharedPreferences.getInstance();
   bool alreadyGet = use?.getBool("getReclamations")??false;
    if(!alreadyGet){
    getReclas.clear();
      
    try{
    var use = await SharedPreferences.getInstance();
      String imaUser = use.getString("recu");
    Response allReclas = await get('https://miage2a2i.000webhostapp.com/getReclas.php?superImat='+imaUser);
    if(allReclas.statusCode != 200)
         throw 'erreur du service';
       getReclas = jsonDecode(allReclas.body);
       }catch(e){
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
           DB.insertRecla(reclamation(getReclas[i]['body'],getReclas[i]['superMat'],getReclas[i]['imat'],getReclas[i]['time'],getReclas[i]['nni'],getReclas[i]['recu'],))  ;  
         var use = await SharedPreferences.getInstance();
         use.setBool('getReclamations', true);
         setState(() {
           failGetReclas=false;
         });
         }
       }
       }else
          setState(() {failGetReclas=false;});
       listReclas = await DB.getAllRecla();
       
        setState(() {
           getRelasBool=true;
         });
  }
  @override
  Widget build(BuildContext context) {
    lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      key: scaffoldKey,
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
             noRecla ?Container(child:Text('tu n\'as aucun reclamation')): getRelasBool&&!failGetReclas? 
             Expanded(
                 child:ListView.builder(
                                      itemCount: listReclas.length,
                                      itemBuilder: (context,index){
                                        return Container(
                                           margin: EdgeInsets.all(5),
                                            color: Theme.of(context).secondaryHeaderColor,
                                          child:Column(
                                          children:<Widget>[
                                            Container(
                                              padding: EdgeInsets.only(right: 10,top: 5),
                                            child:Text('${listReclas[index].body}',
                                            style: TextStyle(decoration:TextDecoration.none,fontSize: 15,
                                            wordSpacing: 0.5
                                            ),textAlign: TextAlign.right,),
                                            ),
                                            Container(
                                              color:Colors.blue,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children:<Widget>[ 
                                               Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].dateNow}'),),
                                                Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].mat}'),),
                                                Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${listReclas[index].nni}'),),
                                                     ]
                                            )
                                            ),
                                          ],
                                        )
                                        );
                                      },
                                      ),
                                  ) :getRelasBool&&failGetReclas ?Container(
                          padding: EdgeInsets.only(top:60),
                          child:RaisedButton(
                            
                            onPressed:(){;init();},
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
                               color: Colors.red,
                                 borderRadius:BorderRadius.all(Radius.circular(50))
                               ),
                               child:InkWell( 
                                      onTap: (){
                                        _dilog();
                                        init();
                                      },
                                     child:Icon(Icons.create,color: Theme.of(context).primaryColor,size: 25,)
                                 )
                               ),
    );
  }

  void _dilog(){posted = false;
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
                                      validator: (val)=>val.length < 10 ?'reclammation doit contient plus du 20 mots':null,
                                      maxLines: 12,
                                      decoration: InputDecoration.collapsed(hintText: " أكتب أستفسارك هنا : تنبيه إلي أن أي إساءه يحاسب عليها"), 
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
                                            validator: (val)=>val.length <= 5 ? 'enter recu du dossier' : null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:'recu du dossier',
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
                                            validator: (val)=>val.length <= 5 ? 'enter matricule cnam' : null,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText:'matricule du cnam',
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
                                              saveReclamation(); 
                                              
                                                      Navigator.pop(context);}
                                               
                                              
                                             }, 
                                            // // Scaffold.of(context).showSnackBar(SnackBar(content: Text('first test in flutter')));
                                          
                                            child: Text('إرسال'),
                                            ),
                                            
                                            )  
                                ) , 
                                      SizedBox(height: 30,),    
                                    
                              ],
                            
                      )),
                   ));
    });
}
void saveReclamation()async{
  setState(() {progress=true;});
   var use = await SharedPreferences.getInstance();
      String imaUser = use.getString("recu");
     await _createAlbum(imaUser);
     setState(() {progress=false;});
     if(posted){
    reclamation r = reclamation(textController.text,imaUser,matController.text,dateFromatted,nniController.text,recuController.text);
    HelperDB DB = HelperDB();
    await DB.insertRecla(r);
    init();
             }
}
_createAlbum(String imaUser) async{
     
     try{
  Response reponse = await post(
    'https://miage2a2i.000webhostapp.com/inquiry_post.php',
    body:<String, String>{
      'body': textController.text,
      'superUser':imaUser,
      'imat':matController.text,
      'nni':nniController.text,
      'recu':recuController.text,
      'lang':lang,
    },
  );
  if(reponse.statusCode != 200)
                 throw "errer du server";
   
    infosPostRecla = json.decode(reponse.body);
 
 }catch(e){
   
   Toast.show('error of service', context,duration: 3,gravity:Toast.CENTER);
   return null;
 }
 if(infosPostRecla.isNotEmpty){ 
  if(infosPostRecla["invalid"]=="true"){
    Toast.show('IDN invalid', context,duration: 3,gravity: Toast.CENTER);
    posted=false;
    return null;
  }
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(infosPostRecla["desc"]),)) ;
    if(infosPostRecla["success"] == "true"){
                dateFromatted = infosPostRecla['date'];
                posted = true;
             return null;
   }
   }else  
      Toast.show('error of connection', context,duration: 3,gravity:Toast.CENTER);
 
}
}