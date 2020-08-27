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
           await db.execute("CREATE TABLE ReclaTable(id INTEGER PRIMARY KEY AUTOINCREMENT,id_recla TEXT, body TEXT, Supermatricule TEXT,matricule TEXT,nni TEXT,recu TEXT,dateNow TEXT,type TEXT)");
          
  }
  Future<void> insertRecla(reclamation recla)async{
          Database dbClient = await db;
         await dbClient.rawInsert("INSERT INTO ReclaTable(id_recla,body,Supermatricule,matricule,nni,recu,dateNow,type) VALUES(?,?,?,?,?,?,?,?)",[recla.toMap()['id_recla'],recla.toMap()['body'],recla.toMap()['superMat'],recla.toMap()['mat'],recla.toMap()['nni'],recla.toMap()['recu'],recla.toMap()['dateNow'],recla.toMap()['type']]);
        
  }
  Future<List<reclamation>> getAllRecla() async{
            Database dbClient = await db;
            var reclas =  await dbClient.query('ReclaTable',orderBy: 'id DESC');
             List<reclamation> reclamations = new List();
        for (int i = 0; i < reclas.length; i++) {
           reclamations.add( reclamation(reclas[i]["id_recla"].toString(),reclas[i]["body"].toString(), reclas[i]["Supermatricule"].toString(), reclas[i]["matricule"].toString(), reclas[i]["dateNow"].toString(),reclas[i]["nni"].toString(),reclas[i]["recu"].toString(),reclas[i]["type"].toString()));
           }
           return reclamations;
  }
  Future<void> deleteAllReclas()async{
    Database database= await db;
    await database.delete('ReclaTable');
     
  }
  closeDB() async {
final dataBase= await db;
await dataBase.close();
}
}
class reclamation {
  String id_recla;
  String body;
  String superMat;
  String mat;
  String dateNow;
  String nni;
  String recu;
  String type;
  reclamation(this.id_recla,this.body,this.superMat,this.mat,this.dateNow,this.nni,this.recu,this.type);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'body':body,
      'superMat':superMat,
      'mat':mat,
      'dateNow':dateNow,
      'nni':nni,
      'recu':recu,
      'type':type,
      'id_recla':id_recla
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
                 type=map['type'];
                 id_recla=map['id_recla'];
  }

}