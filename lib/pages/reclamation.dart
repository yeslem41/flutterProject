import 'package:flutter/material.dart';


class Reclammation extends StatefulWidget {
  @override
  _ReclammationState createState() => _ReclammationState();
}

class _ReclammationState extends State<Reclammation> {
  // get textController => null;
TextEditingController textController =TextEditingController();
TextEditingController matController = TextEditingController();
TextEditingController recuController = TextEditingController();
var formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body:SafeArea(
           child:ListView(
                           padding: EdgeInsets.only(left:10,right:10), 
                           children: <Widget>[
                             Container(height:50),
                             Container(
                               height:45,
                               decoration: BoxDecoration(
                                 border:Border.all(color:Theme.of(context).secondaryHeaderColor)
                               ),
                               child: Text('datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata'),
                             ),
                             Divider(height: 5,color:Colors.orange ,),
                            Container(
                               height:45,
                               decoration: BoxDecoration(
                                 border:Border.all(color:Theme.of(context).secondaryHeaderColor)
                               ),
                             ),
                             Divider(height: 5,color:Colors.orange ,),
                             Container(
                               height:45,
                               decoration: BoxDecoration(
                                 border:Border.all(color:Theme.of(context).secondaryHeaderColor)
                               ),
                             ),
                             Divider(height: 5,color:Colors.orange ,),
                           ],
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
                                        print(DateTime.now().toString()+' med');
                                      },
                                     child:Icon(Icons.create,color: Theme.of(context).primaryColor,size: 25,)
                                 )
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
                                      textAlign: TextAlign.end,  
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
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                                              padding: EdgeInsets.only(top:1,bottom:1),
                                             onPressed:(){ 
                                              //  _createAlbum();
                                            if(formKey.currentState.validate()){
                                                      textController.clear();
                                                      Navigator.pop(context);}
                                             textController.clear();
                                               
                                              
                                             }, 
                                            // // Scaffold.of(context).showSnackBar(SnackBar(content: Text('first test in flutter')));
                                          
                                            child: Text('إرسال'),
                                            ),
                                            
                                            )  
                                )      
                                    
                              ],
                            
                      )),
                   ));
    });
}
}