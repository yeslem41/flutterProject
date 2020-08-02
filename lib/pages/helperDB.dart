import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';


class HelperDB{

  static Database _db;

  Future<Database> get db async{
    if(_db != null) return _db;
    Database theDB = await intDB();

    return theDB;
  }
  intDB() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'recla.db');
    var theDB = await openDatabase(path , version: 1,onCreate: _onCreate);
      return theDB;
  }
  void _onCreate(Database db,int version) async{
           await db.execute("CREATE TABLE ReclaTable(id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT, Supermatricule TEXT,matricule TEXT,nni TEXT,recu TEXT,dateNow TEXT)");
          
          
  }
  Future<void> insertRecla(reclamation recla)async{
          Database dbClient = await db;
         await dbClient.rawInsert("INSERT INTO ReclaTable(body,Supermatricule,matricule,nni,recu,dateNow) VALUES(?,?,?,?,?,?)",[recla.toMap()['body'],recla.toMap()['superMat'],recla.toMap()['mat'],recla.toMap()['nni'],recla.toMap()['recu'],recla.toMap()['dateNow']]);
        
  }
  Future<List<reclamation>> getAllRecla() async{
            Database dbClient = await db;
            var reclas =  await dbClient.query('ReclaTable',orderBy: 'id DESC');
          await dbClient.close();
             List<reclamation> reclamations = new List();
        for (int i = 0; i < reclas.length; i++) {
           reclamations.add(new reclamation(reclas[i]["body"], reclas[i]["Supermatricule"], reclas[i]["matricule"], reclas[i]["dateNow"],reclas[i]["nni"],reclas[i]["recu"]));
           }
           return reclamations;
  }
  Future<void> deleteAllReclas()async{
    Database database= await db;
    int a = await database.delete('ReclaTable');
  }
}
class reclamation {
  String body;
  String superMat;
  String mat;
  String dateNow;
  String nni;
  String recu;
  reclamation(this.body,this.superMat,this.mat,this.dateNow,this.nni,this.recu);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'body':body,
      'superMat':superMat,
      'mat':mat,
      'dateNow':dateNow,
      'nni':nni,
      'recu':recu,
            };
      return map;
  }
  reclamation.fromMap(Map<String , dynamic> map){
                 body = map['body'];
                 superMat = map['superMat'];
                 mat = map['mat'];
                 dateNow = map['dateNow'];
                 nni = map['nni'];
                 recu = map['recu'];
  }

}