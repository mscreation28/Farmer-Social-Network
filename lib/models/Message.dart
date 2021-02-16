import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Message {
  String message;
  bool sentByMe = false;
  DateTime messageTime;
  int userId;
  String userName;
  int groupId;

  Message(
      {this.message,
      this.userId,
      this.userName,
      this.messageTime,
      this.sentByMe,
      this.groupId});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      userId: json['userId'],
      userName: json['userName'],
      groupId: json['groupId'],
      messageTime: DateTime.parse(json['messageTime']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "message": message,
      "groupId": groupId,
      "messageTime": messageTime.toIso8601String(),
    };
  }

  Future<Database> createTableIfNotExist() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'messages.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS message(messageId INTEGER PRIMARY KEY AUTOINCREMENT,message TEXT,userId INTEGER,userName TEXT,groupId INTEGER,messageTime TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  void storeMessage(Message message) async {
    final Database db = await createTableIfNotExist();

    int id = await db.insert(
      'message',
      message.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(id);
  }

  Future<List<Message>> getMessages(int groupId, int userId) async {
    final Database db = await createTableIfNotExist();
    final List<Map<String, dynamic>> maps =
        await db.query('message', where: "groupId = ?", whereArgs: [groupId]);
    return List.generate(maps.length, (i) {
      return Message(
        message: maps[i]['message'],
        userId: maps[i]['userId'],
        userName: maps[i]['userName'],
        groupId: maps[i]['groupId'],
        messageTime: DateTime.parse(maps[i]['messageTime']),
        sentByMe: maps[i]['userId'] == userId ? true : false,
      );
    });
  }
}
