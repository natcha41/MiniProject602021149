import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class Editdispenser extends StatefulWidget {
  final String docid;

  const Editdispenser({Key key, this.docid}) : super(key: key);
  @override
  _EditdispenserState createState() => _EditdispenserState();
}

class _EditdispenserState extends State<Editdispenser> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
 

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    // var _controller1;
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
      ),
      
      body: Column(
        children: <Widget> [
          Padding(padding: EdgeInsets.only(),), //ระยะรูปภาพ
          Image.asset(
            "asset/imagess/caa.png"),
            Padding(padding: EdgeInsets.only(top:30),), //ระยะรูปภาพ
            
          Container(
            width: 200,
            height: 50,
            child: TextField(
              controller: _controller2,
            ),
          ),

          Container(
            width: 200,
            height: 50,
            child: TextField(
              controller: _controller1,
            ),
          ),
          RaisedButton(
            onPressed: () {
            updateDispenser();
          },
            child: Text('บันทึก'),
          ),
          //อัปเดต
            //addDispenser(); //เพิ่ม
        ],
      ),
    );
  }

  Future<void> getInfo() async {
    await FirebaseFirestore.instance
        .collection("Coffee")
        .doc(widget.docid)
        .get() //ดึงข้อมูลทั้งหมดแค่ครั้งเดียว
        .then((value) {
      setState(() {
        // setstate ไม่ให้ค่าเปลี่ยน
        _controller2 = TextEditingController(text: value.data()['coffeename']);
        _controller1 = TextEditingController(text: value.data()['price'].toString());
       
      });
    });
  }

  Future<void> updateDispenser() async {
    await FirebaseFirestore.instance
        .collection("Coffee") //ไป
        .doc(widget.docid)
        .update({
      //อัปเดตข้อมูลไปในเอกสารใน Cloud Firestore
      'price': _controller1.text,
      'coffeename': _controller2.text,
    }).whenComplete(() => Navigator.pop(context));
  }

  //  Future<void> _uploadFile() async {
  //   FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  //   if (file != null){
  //     StorageUploadTask storageUploadTask = storageReference.putFile(file);
  //     await storageUploadTask.onComplete.then((response){
  //       print('Success Upload');
  //     }).catchError(() {});
  //   }
  // }


  // Future<void> addDispenser() async { //เพิ่ม
  //   var whenComplete = whenComplete;
  //   await FirebaseFirestore.instance.collection('Dispenser').doc({
  //     'amount': _controller1.text,
  //     'drug_name': _controller2.text,
  //   }).whenComplete(() => Navigator.pop(context));
  // }
}
//child: Text("บันทึก");