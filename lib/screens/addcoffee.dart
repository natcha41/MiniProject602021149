import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasedemo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddCoffee extends StatefulWidget {
  @override
  _AddCoffeeState createState() => _AddCoffeeState();
}

class _AddCoffeeState extends State<AddCoffee> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  

  File _image;
  final picker = ImagePicker();

  Future<void> chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล'),
      ),
      body: Center(
        child: Column(
          
          children: [
            Container(
              width: 200,
              height: 150,
              child: _image == null? Text('ไม่มีรูปภาพ') : Image.file(_image),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                onPressed: () {
                  chooseImage();
                },
                child: Text('เลือกรูป'),
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _controller2,
                decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _controller1,
                decoration: InputDecoration(labelText: 'ราคา'),
              ),
            ),
            RaisedButton(
              onPressed: () {
                addCosmetic();
              },
              //ปุ่ม button บันทึกการแก้ไขข้อมูล
              child: Text('บันทึก'),
              color: Colors.green.shade500,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addCosmetic() async {
    String fileName = Path.basename(_image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask storageUploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) async {
      await FirebaseFirestore.instance.collection('Coffee').add({
        'price': _controller1.text,
        'coffeename': _controller2.text,
        'img': value,
      });
    });
  }
}