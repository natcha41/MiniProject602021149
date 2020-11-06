import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit.dart';
import 'addcoffee.dart';
import 'package:firebasedemo/screens/addcoffee.dart';
import 'package:firebasedemo/screens/edit.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String user;
  String password;
  String name;
  String tel;

  @override
  Widget build(BuildContext context) {
    var floatingActionButton4 = FloatingActionButton.extended(
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => AddCoffee());
        Navigator.push(context, route);
      },
      label: const Text('เพิ่มข้อมูล'),
      icon: Icon(Icons.add_shopping_cart),
      backgroundColor: Colors.brown,
    );

    var floatingActionButton3 = floatingActionButton4;
    var floatingActionButton2 = floatingActionButton3;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cafe amazon menu"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
          onPressed: () {}
          //=> googleSignOut().whenComplete(() {
          //       signOutPage();
          //       Navigator.of(context).pushAndRemoveUntil(
          //           MaterialPageRoute(
          //             builder: (context) => SignInPage(),
          //           ),
          //           (route) => false);
          //     }),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton2,
      body: realTimeFood(),
    );
  }

  Widget realTimeFood() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Coffee").snapshots(),
      builder: (context, snapshots) {
        switch (snapshots.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          default:
            return Column(
              children: makeListWidget(snapshots),
            );
        }
      },
    );
  }

  List<Widget> makeListWidget(AsyncSnapshot snapshots) {
    return snapshots.data.docs.map<Widget>((document) {
      return brow(document);
    }).toList();
  }

  Card brow(document) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), //เพิ่ม
      ),
      //color: Colors.deepPurpleAccent,
      child: ListTile(
          trailing: IconButton(
              //--------------------------trailing คือ เพิ่มข้างหลัง เพื่อไว้ใส่ icon ลบ
              icon: Icon(Icons.delete),
              //--------------------------ปุ่มลบ
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context)  {
                      return AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "ท่านต้องการลบข้อมูลหรือไม่?",
                                // style: TextStyle(color: Colors.brown, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        actions: [
                          FlatButton(
                              child: Text(
                                "ลบ",
                              ),
                              color: Colors.red,
                              onPressed: () {
                                deleteFood(
                                    document.id); //-------ใส่ document id
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text("ยกเลิก"),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    });
              }),
          leading: ClipRRect(

              //ปรับมุมภาพ
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: Image.network(
                document['img'],
                fit: BoxFit.cover, //ใส่รูป
              )),
          tileColor: Colors.brown.withOpacity(0.3), //ใส่สีในcard
          title: Text(document['coffeename']),
          subtitle: Text(document['price'].toString()),
          onTap: () {
            //คลิกเพื่อกลับ
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => Editdispenser(docid: document.id),
            );
            Navigator.push(context, route); //เรียกคำสั่งโดย Navigator
          }),
    );
  }

  Future<void> deleteFood(id) async {
    await FirebaseFirestore.instance.collection('Coffee').doc(id).delete();
  }
}
