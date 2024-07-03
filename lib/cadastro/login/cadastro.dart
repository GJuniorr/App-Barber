import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

 final _auth = FirebaseAuth.instance;

  late MySQLConnection conn;

  @override
  void initState() {
    super.initState();
    getConnection();
  }

  Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '10.0.2.2',
      port: 3306,
      userName: 'root',
      password: '@Kinafox223',
      databaseName: 'appbarber',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    numTelefone!.addListener(() {
      final text = numTelefone!.text;
      if (text.length > 2 && !text.startsWith('(')) {
        numTelefone!.value = TextEditingValue(
          text: '(${text.substring(0, 2)}) ${text.substring(2)}',
          selection: TextSelection.collapsed(offset: text.length + 3),
        );
      } else if(text.length > 10 && !text.contains('-')){
        numTelefone!.value = TextEditingValue(
          text: '${text.substring(0, 10)}- ${text.substring(10)}',
          selection: TextSelection.collapsed(offset: text.length + 1),
        );
      }
    });
    //await carregarDados();
    //await conn.close();
  }

  Future registerUser() async {

    try {
    await _auth.createUserWithEmailAndPassword(email: email!.text, password: password!.text);
    final Map<String, dynamic> parametros = {
      'Usuario': user!.text, 
      'Senha': password!.text, 
      'Nome': name!.text, 
      'Email': email!.text, 
      'Telefone': numTelefone!.text, 
      'Bairro': bairro!.text.toLowerCase(), 
      'Numero': numero!.text, 
      'CEP': cep!.text};

    var register = conn.execute("Insert into usuarios (Usuario, Senha, Nome, Email, Telefone, Bairro, Número, CEP) VALUES (:Usuario, :Senha, :Nome, :Email, :Telefone, :Bairro, :Numero, :CEP)", parametros);
    print('Usuario cadastrado com sucesso');
    print('Usuario: ${user!.text}');
     }catch (e){
      print('Erro ao cadastrar Usuario $e');
  }
  }
 

  TextEditingController? user = TextEditingController();
  TextEditingController? password = TextEditingController();
  bool lookPassword = true;
  TextEditingController? name = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? numTelefone = TextEditingController();
  TextEditingController? bairro = TextEditingController();
  TextEditingController? numero = TextEditingController();
  TextEditingController? cep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro',
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
              height: 786,
              color: Colors.blueGrey,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: user,
                        onChanged: (valueU) {
                          user!.text = valueU;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
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
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 260,
                          child: TextField(
                            obscureText: lookPassword,
                            controller: password,
                            onChanged: (valueS) {
                              password!.text = valueS;
                            },
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
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
                          }, icon: Icon(Icons.remove_red_eye))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: name,
                        onChanged: (valueN) {
                          name!.text = valueN;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Nome',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: email,
                        onChanged: (valueE) {
                          email!.text = valueE;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: numTelefone,
                        onChanged: (valueNT) {
                          numTelefone!.text = valueNT;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Número de Telefone',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: bairro,
                        onChanged: (valueB) {
                          bairro!.text = valueB;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Bairro',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: numero,
                        onChanged: (valueN) {
                          numero!.text = valueN;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Numero',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20),
                    child: SizedBox(
                      width: 260,
                      child: TextField(
                        controller: cep,
                        onChanged: (valueNT) {
                          cep!.text = valueNT;
                        },
                        style: TextStyle(
                          color: Colors.black
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'CEP',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.white
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: Colors.lightBlue
                              ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            }, child: Text('Voltar',
                            style: TextStyle(
                              color: Colors.black
                            ),
                            ),
                            ),
                        ),
                      ),
                       SizedBox(
                        width: 160,
                         child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.white
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: Colors.lightBlue
                              ),
                              ),
                            ),
                            onPressed: () {
                              registerUser();
                              //*Navigator.pushNamed(context, 'login');
                            }, child: Text('Cadastrar',
                            style: TextStyle(
                              color: Colors.black
                            ),
                            ),
                            ),
                            ),
                       ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}