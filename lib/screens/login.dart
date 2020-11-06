import 'package:firebasedemo/screens/authen.dart';
import 'package:firebasedemo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({Key key, this.title}) : super(key: key);
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text('เข้าสู่ระบบ'),
      ),
   
     body: Center(
       child:Column
       (mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Padding(padding: EdgeInsets.only(top:30),),
         Image.asset(
            "asset/imagess/kk.png"),
            
         Padding(padding: EdgeInsets.only(top:30),),
          GoogleSignInButton(
          borderRadius: 20,
          onPressed: () => signInwithGoogle().then((value) {
            if(value!=null){
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute( builder: (context)=>Homepage()
                ),
                (route) => false);
          }
        })
        ), 

       ],
       ),
    ),
    backgroundColor: Colors.brown.shade300,
    );
  }
}
