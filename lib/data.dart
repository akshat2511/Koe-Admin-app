import 'dart:developer';
import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:flutter_imagekit/flutter_imagekit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart';

var url = "mongodb+srv://adm:adm@akshatbhaika.ftmgts2.mongodb.net/test";
//var collection = "caves";

class MongoDatabase {
  static dynamic db, usercollection;
  static connect() async {
    db = await Db.create(url);
    await db.open();
    inspect(db);
    //usercollection = db.collection(collection);
  }

  static getcoll(String collection) async {
    //db = await Db.create(url);
    //await db.open();
    // inspect(db);
    usercollection = db.collection(collection);
  }

  static get() async {
    final data =
        await usercollection.find(where.excludeFields(['_id', '__v'])).toList();
    //var list = json.decode(data);
    return data;
  }

  static del(String input) async {
    await usercollection.deleteOne({"n1": input});
  }

  static del2(int input) async {
    await usercollection.deleteOne({"phone": input});
  }
  static del3(String input) async {
    await usercollection.deleteOne({"text2": input});
  }
}

class Imagecdn {
  // static dynamic urll;
  static insert(String? akshat, XFile? ak, String? str, String? str1, String? str2) async {
    ImageKit.io(
      File(ak!.path),
      //  folder: "folder_name/nested_folder", (Optional)
      privateKey: "private_e9hcssdyHCFL8SQBq7/6r+Gakbs=", // (Keep Confidential)
      onUploadProgress: (progressValue) {
        // print(progressValue * 100);
      },
    ).then((String url) async {
      // print(str);
      // print(url);
      await MongoDatabase.getcoll(akshat!);
      MongoDatabase.usercollection.insertOne({
        "_id": ObjectId(),
        "text1": str,
        "text2": str1,
        "text3": str2,
        "imageurl": url,
      });
    });
  }
  

  
}
