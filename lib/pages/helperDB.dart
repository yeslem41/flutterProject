// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'dart:io' as io;
// import 'package:path_provider/path_provider.dart';


// class HelperDB{

//   static Database _db;

//   Future<Database> get db async{
//     if(_db != null) return _db;
//     Database theDB = await intDB();

//     return theDB;
//   }
//   intDB() async{
//     io.Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path,'recla.db');
//     var theDB = await openDatabase(path , version: 1,onCreate: _onCreate);

//   }
//   void _onCreate(Database db,int version) async{
//            await db.execute("CREATE TABLE ReclaTable(id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT, Supermatricule TEXT,matricule TEXT,dateNow TEXT)");
//           print("Created tables");
          
//   }
//   Future<void> insertRecla(reclamation recla)async{
//           Database dbClient = await db;
//           dbClient.rawInsert("INSERT INTO ReclaTable(body,Supermatricule,matricule,dateNow) VALUES(?,?,?,?)",[recla.toMap()['body'],recla.toMap()['superMat'],recla.toMap()['mat'],recla.toMap()['dateNow']]);
//   }
//   Future<List<reclamation>> getAllRecla() async{
//             Database dbClient = await db;
//             var reclas =  await dbClient.query('ReclaTable');
//           await dbClient.close();
//              List<reclamation> reclamations = new List();
//         for (int i = 0; i < reclas.length; i++) {
//            reclamations.add(new reclamation(reclas[i]["body"], reclas[i]["Supermatricule"], reclas[i]["matricule"], reclas[i]["dateNow"]));
//            }
//   }
// }
// class reclamation {
//   String body;
//   String superMat;
//   String mat;
//   String dateNow;
//   reclamation(this.body,this.superMat,this.mat,this.dateNow);

//   Map<String,dynamic> toMap(){
//     var map = <String,dynamic>{
//       'body':body,
//       'superMat':superMat,
//       'mat':mat,
//       'dateNow':dateNow,
//             };
//       return map;
//   }
//   reclamation.fromMap(Map<String , dynamic> map){
//                  body = map['body'];
//                  superMat = map['superMat'];
//                  mat = map['mat'];
//                  dateNow = map['dateNow'];
//   }

// }