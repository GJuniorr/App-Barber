// ignore_for_file: avoid_print

import 'package:appbarbearia/cadastro/login/forgetPassword.dart';
import 'package:appbarbearia/homepage.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  int? idUser;
  String? user;
  String? password;
  bool lookPassword = true;

  late MySQLConnection conn;

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '',
      port: ,
      userName: '',
      password: '',
      databaseName: 'appbarber',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
  }

  Future loginUser() async{

      var login = await conn.execute("SELECT * FROM usuarios WHERE Usuario = '$user' AND Senha = '$password' ");

      var count = login.numOfRows;

    // ignore: prefer_is_empty
    if (count > 0) {
       for (var element in login.rows) {
        Map data = element.assoc();
        idUser = int.tryParse(data['ID_Usuario']);
          }

      print("O usuário é $user e a senha é $password ");
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Homepage(
          idUser: idUser
        ),));
    }else{
      print("O usuário é $user e a senha é $password ");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro de Login'),
          content: const Text('Usuário ou senha incorretos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
        );

    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              height: 600,
              color: Colors.blueGrey,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 100.0,
                      top: 50),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/images/Login.png')),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 33),
                    child: SizedBox(
                      width: 280,
                      child: TextField(
                        onChanged: (valueU) {
                          user = valueU;
                        },
                        style: const TextStyle(
                          color: Colors.black
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Usuario',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(
                     horizontal: 33),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 280,
                          child: TextField(
                            obscureText: lookPassword,
                            onChanged: (valueS) {
                              password = valueS;
                            },
                            style: const TextStyle(
                              color: Colors.black
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              lookPassword = !lookPassword;
                            });
                          }, icon: const Icon(Icons.remove_red_eye))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'forgetPassword');
                        }, child: Text('Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        ),),
                    ],
                  ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 0.0),
                     child: SizedBox(
                      width: 400,
                      height: 50,
                        child: TextButton(
                          style:  ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black
                            ),
                            shape: WidgetStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              ),
                              ),
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: Colors.lightBlue
                            ),
                            ),
                          ),
                          onPressed: () {
                            loginUser();
                          }, child: const Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          ),
                        ),
                   ),
                   const SizedBox(
                    height: 10,
                   ),  
                      const Center(
                        child: Text('Ainda não tem uma conta?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: TextButton(
                            style:  ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: Colors.lightBlue
                              ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'cadastro');
                            }, child: const Text('Cadastre-se',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
