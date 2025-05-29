// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   factory DatabaseHelper() => _instance;

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'metro_app.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDb,
//     );
//   }

//   Future<void> _createDb(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE wallet(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         balance REAL NOT NULL
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE transactions(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         amount REAL NOT NULL,
//         type TEXT NOT NULL,
//         date TEXT NOT NULL
//       )
//     ''');
//   }

//   Future<double> getWalletBalance() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('wallet');
//     if (maps.isEmpty) {
//       await db.insert('wallet', {'balance': 0.0});
//       return 0.0;
//     }
//     return maps.first['balance'] as double;
//   }

//   Future<void> updateWalletBalance(double amount) async {
//     final db = await database;
//     final currentBalance = await getWalletBalance();
//     final newBalance = currentBalance + amount;

//     await db.transaction((txn) async {
//       await txn.update(
//         'wallet',
//         {'balance': newBalance},
//         where: 'id = ?',
//         whereArgs: [1],
//       );

//       await txn.insert('transactions', {
//         'amount': amount,
//         'type': amount > 0 ? 'credit' : 'debit',
//         'date': DateTime.now().toIso8601String(),
//       });
//     });
//   }

//   Future<List<Map<String, dynamic>>> getTransactionHistory() async {
//     final db = await database;
//     return await db.query('transactions', orderBy: 'date DESC');
//   }
// }
