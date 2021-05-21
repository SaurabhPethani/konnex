import 'package:Scrum/index.dart';
import 'dart:io';

class SqliteDatabaseService {
  Database _liteDatabase;

  Future<Database> get db async {
    if (_liteDatabase != null) return _liteDatabase;
    _liteDatabase = await _initDatabase();
    return _liteDatabase;
  }

  Future<Database> _initDatabase() async {
    print("Entered Init Database");
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, 'transactionDB.db');
    print("Before Lite Database");
    try {
      Database theDb =
          await openDatabase(path, version: 1, onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute(
          '''CREATE TABLE IF NOT EXISTS Task(id TEXT PRIMARY KEY, desc TEXT, priority TEXT, level TEXT, type TEXT, eta TEXT, assigned TEXT)''',
        );
        db.execute(
          '''CREATE TABLE IF NOT EXISTS Individual(name TEXT PRIMARY KEY, knowledge TEXT, understanding TEXT, specialize TEXT, timelyCompl TEXT, tpw TEXT, efficiency TEXT, overall TEXT, taskUndertaken TEXT, taskCompleted TEXT, noOfHrs TEXT)''',
        );
        db.execute(
            '''CREATE TABLE IF NOT EXISTS Assignment(id TEXT PRIMARY KEY , name TEXT , progress TEXT, timeTaken TEXT, startDate TEXT, FOREIGN KEY (id) REFERENCES Task(id), FOREIGN KEY (name) REFERENCES Individual(name))''');
      });
      return theDb;
    } catch (e) {
      print(e);
    }
    print("After Lite Database");
  }

  Future<void> insertTask(Task txn) async {
    var liteDatabase = await db;

    print('Before Inserting');
    await liteDatabase.insert(
      'Task',
      txn.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Task Insertion success");
    liteDatabase.batch().commit();
  }

  Future<void> deleteTask(String id) async {
    var liteDatabase = await db;

    print('Before Deleting');
    await liteDatabase.delete('Task', where: 'id = ?', whereArgs: [id]);
    print("Task Deletion success");
    liteDatabase.batch().commit();
  }

  Future<void> updateTask(String id, bool assign) async {
    var liteDatabase = await db;
    String stat = assign ? 'yes' : 'no';

    print('before updating');
    int c = await liteDatabase
        .rawUpdate('UPDATE Task SET assigned = ? WHERE id = ?', [stat, id]);
    print("$c rows updated");

    liteDatabase.batch().commit();
  }

  Future<void> insertIndividual(Individual indi) async {
    var liteDatabase = await db;

    print('Before Inserting');
    await liteDatabase.insert(
      'Individual',
      indi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Individual Insertion success");
    liteDatabase.batch().commit();
  }

  Future<void> deleteIndividual(String name) async {
    var liteDatabase = await db;

    print('Before Deleting');
    await liteDatabase
        .delete('Individual', where: 'name = ?', whereArgs: [name]);
    print("Individual Deletion success");
    liteDatabase.batch().commit();
  }

  Future<void> updateIndividual(String name, String taskUndertaken) async {
    var liteDatabase = await db;

    print('before updating');
    int c = await liteDatabase.rawUpdate(
        'UPDATE Individual SET taskUndertaken = ? WHERE name = ?',
        [taskUndertaken, name]);
    print("$c rows updated");

    liteDatabase.batch().commit();
  }

  Future<void> updateIndividualTask(String name, String taskCompleted) async {
    var liteDatabase = await db;

    print('before updating');
    int c = await liteDatabase.rawUpdate(
        'UPDATE Individual SET taskCompleted = ? WHERE name = ?',
        [taskCompleted, name]);
    print("$c rows updated");

    liteDatabase.batch().commit();
  }

  Future<void> insertAssignment(Assignment assign) async {
    var liteDatabase = await db;

    print('Before Inserting');
    await liteDatabase.insert(
      'Assignment',
      assign.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Assignment Insertion success");
    liteDatabase.batch().commit();
  }

  Future<void> deleteAssignment(String id) async {
    var liteDatabase = await db;

    print('Before Deleting');
    await liteDatabase.delete('Assignment', where: 'id = ?', whereArgs: [id]);
    print("Assignment Deletion success");
    liteDatabase.batch().commit();
  }

  Future<void> updateAssignment(int id, String name) async {
    var liteDatabase = await db;

    print('before updating');
    int c = await liteDatabase
        .rawUpdate('UPDATE Assignment SET name = ? WHERE id = ?', [name, id]);
    print("$c rows updated");

    liteDatabase.batch().commit();
  }

  Future<List<Task>> getTask() async {
    final liteDb = await db;

    var response = await liteDb.query('Task');
    print("TestResponse Task : $response");
    List<Task> akt = response.map((tk) => Task.fromMap(tk)).toList();
    return akt;
  }

  Future<List<Individual>> getIndividual() async {
    final liteDb = await db;

    var response = await liteDb.query('Individual');
    print("TestResponse Individual : $response");
    List<Individual> akt =
        response.map((tk) => Individual.fromMap(tk)).toList();
    return akt;
  }

  Future<List<Assignment>> getAssignedTask() async {
    final liteDb = await db;

    var response = await liteDb.query('Assignment');
    print("TestResponse Assignment : $response");
    List<Assignment> akt =
        response.map((tk) => Assignment.fromMap(tk)).toList();
    return akt;
  }

  Future<void> undoTask(String name) async {
    final liteDb = await db;

    var response =
        await liteDb.query('Assignment', where: 'name = ?', whereArgs: [name]);
    print("TestResponse Assignment : $response");
    List<Assignment> akt =
        response.map((tk) => Assignment.fromMap(tk)).toList();

    for (Assignment assign in akt) {
      int c = await liteDb.rawUpdate(
          'UPDATE Task SET assigned = ? WHERE id = ?', ['no', assign.id]);
    }

    print("Updation done");
  }

  Future<void> deleteDatabase() async {
    var liteDatabase = await db;
    liteDatabase.delete('Task');
    print("localTransaction deleted");
    liteDatabase.delete('Individual');
    print("AksharTransaction deleted");
    liteDatabase.delete('Assignment');
    print("Announcement deleted");

    liteDatabase.batch().commit();
  }
}
