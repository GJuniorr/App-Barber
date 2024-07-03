import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({
    super.key,});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {

  TextEditingController textEmail = TextEditingController();

  final _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetLink(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email para resetar a senha foi enviado'
      ),
      ),
      );
      Navigator.pushNamed(context, 'login');
    } catch (e) {
      print(e.toString());
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Digite o seu email',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15
            ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
            style: TextStyle(
              color: Colors.black
            ),
            controller: textEmail,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.black
              )
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.white,
                ),
                shape: WidgetStatePropertyAll(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    ),
                )
              ),
              onPressed: () {
                sendPasswordResetLink(textEmail.text);
              }, child: Text('Enviar Email',
              style: TextStyle(
                color: Colors.black
              ),),
              ),
          ),
          ],
        ),
    );
  }
}