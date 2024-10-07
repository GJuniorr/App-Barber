import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

class Perfil extends StatefulWidget {

  final int? idUser;
  const Perfil({
    super.key,
    required this.idUser});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

   TextEditingController? usuario = TextEditingController();
   bool editingUser = false;
   TextEditingController? senha = TextEditingController();
   bool editingPassword = false;
   TextEditingController? nome = TextEditingController();
   bool editingName = false;
   TextEditingController? email = TextEditingController();
   bool editingEmail = false;
   TextEditingController? telefone = TextEditingController();
   bool editingTelefone = false;
   TextEditingController? bairro = TextEditingController();
   bool editingBairro = false;
   TextEditingController? numero = TextEditingController();
   bool editingNumber = false;
   TextEditingController? cep = TextEditingController();
   bool editingCEP = false;

   int? idUser;
   int selectedIndex = 0;

   late MySQLConnection conn;

   @override
  void initState() {
    super.initState();
    getConnection();
    idUser = widget.idUser;
  }

  Future getConnection() async {
    conn = await MySQLConnection.createConnection(
      host: '',
      port: ,
      userName: '',
      password: '',
      password: '@Kinafox223',
      databaseName: 'appbarber',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
      print('ID: $idUser');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    await userSelect();
  }

  Future userSelect() async {
    var userSelect = await conn.execute("SELECT * FROM usuarios WHERE ID_Usuario = '$idUser' ");

    for (var element in userSelect.rows) {
        Map data = element.assoc();
        usuario!.text = data['Usuario'];
        senha!.text = data['Senha'];
        nome!.text = data['Nome'];
        email!.text = data['Email'];
        telefone!.text = data['Telefone'];
        bairro!.text = data['Bairro'];
        numero!.text = data['Número'];
        cep!.text = data['CEP'];
        }
  }

  Future changeUser() async{

    try {
    final Map<String, dynamic> parametros = {'Usuario': usuario!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Usuario = :Usuario WHERE ID_Usuario = :ID_Usuario',
      {
        'Usuario': usuario!.text,
        'ID_Usuario': idUser
      } );
    print('Usuario modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar usuario: $e');
  }
  }

  Future changePassword() async{

    try {
    final Map<String, dynamic> parametros = {'Senha': senha!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Senha = :Senha WHERE ID_Usuario = :ID_Usuario',
      {
        'Senha': senha!.text,
        'ID_Usuario': idUser
      } );
    print('Senha modificada com sucesso');
  } catch (e) {
    print('Erro ao modificar senha: $e');
  }
  }

  Future changeName() async{

    try {
    final Map<String, dynamic> parametros = {'Nome': nome!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Nome = :Nome WHERE ID_Usuario = :ID_Usuario',
      {
        'Nome': nome!.text,
        'ID_Usuario': idUser
      } );
    print('Nome modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar nome: $e');
  }
  }

  Future changeEmail() async{

    try {
    final Map<String, dynamic> parametros = {'Email': email!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Email = :Email WHERE ID_Usuario = :ID_Usuario',
      {
        'Email': email!.text,
        'ID_Usuario': idUser
      } );
    print('Email modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar email: $e');
  }
  }

  Future changeTelefone() async{

    try {
    final Map<String, dynamic> parametros = {'Telefone': telefone!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Telefone = :Telefone WHERE ID_Usuario = :ID_Usuario',
      {
        'Telefone': telefone!.text,
        'ID_Usuario': idUser
      } );
    print('Telefone modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar telefone: $e');
  }
  }

  Future changeBairro() async{

    try {
    final Map<String, dynamic> parametros = {'Bairro': bairro!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Bairro = :Bairro WHERE ID_Usuario = :ID_Usuario',
      {
        'Bairro': bairro!.text,
        'ID_Usuario': idUser
      } );
    print('Bairro modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar bairro: $e');
  }
  }

  Future changeNumero() async{

    try {
    final Map<String, dynamic> parametros = {'Numero': numero!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET Numero = :Numero WHERE ID_Usuario = :ID_Usuario',
      {
        'Numero': numero!.text,
        'ID_Usuario': idUser
      } );
    print('Numero modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar numero: $e');
  }
  }

  Future changeCEP() async{

    try {
    final Map<String, dynamic> parametros = {'CEP': cep!.text};

    var update = await conn.execute(
      'UPDATE usuarios SET CEP = :CEP WHERE ID_Usuario = :ID_Usuario',
      {
        'CEP': cep!.text,
        'ID_Usuario': idUser
      } );
    print('CEP modificado com sucesso');
  } catch (e) {
    print('Erro ao modificar CEP: $e');
  }
  }

    Future deleteUser() async{
    var res = await conn.execute(
      'DELETE FROM usuarios WHERE ID_Usuario = :ID_Usuario',
      {
        'ID_Usuario': idUser,
      },
    );
    print(res.affectedRows);
    await userSelect();
  }
  

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  
   switch(selectedIndex){

    case 0:
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Homepage(
      idUser: idUser,
      )));
      break;

    case 1:
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Prices(
      idUser: idUser,
      )));
      break;

    case 2:
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Schedule(
      idUser: idUser,
      )));
      break;

    case 3:
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => Perfil(
      idUser: idUser,
      )));
      break;
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início'
            ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.moneyCheckDollar),
            label: 'Preços'),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendarDays),
            label: 'Agenda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil'),
        ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: 600,
            height: 800,
            color: const Color(0xFF2c3e50),
            child: Column(
              children: [
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueU) {
                              usuario!.text = valueU;
                            },
                            controller: usuario,
                            enabled: editingUser,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingUser,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingUser = !editingUser;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingUser,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          usuario!.text = usuario!.text;
                          changeUser();
                          editingUser = !editingUser;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingUser,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingUser = !editingUser;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Senha
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueS) {
                              senha!.text = valueS;
                            },
                            controller: senha,
                            enabled: editingPassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingPassword,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingPassword = !editingPassword;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingPassword,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          senha!.text = senha!.text;
                          changePassword();
                          editingPassword = !editingPassword;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingPassword,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingPassword = !editingPassword;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Nome
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueN) {
                              nome!.text = valueN;
                            },
                            controller: nome,
                            enabled: editingName,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingName,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingName = !editingName;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingName,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          nome!.text = nome!.text;
                          changeName();
                          editingName = !editingName;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingName,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingName = !editingName;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Email
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueE) {
                              email!.text = valueE;
                            },
                            controller: email,
                            enabled: editingEmail,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingEmail,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingEmail = !editingEmail;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingEmail,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          email!.text = email!.text;
                          changeEmail();
                          editingEmail = !editingEmail;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingEmail,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingEmail = !editingEmail;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Telefone
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueT) {
                              telefone!.text = valueT;
                            },
                            controller: telefone,
                            enabled: editingTelefone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingTelefone,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingTelefone = !editingTelefone;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingTelefone,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          telefone!.text = telefone!.text;
                          changeTelefone();
                          editingTelefone = !editingTelefone;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingTelefone,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingTelefone = !editingTelefone;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Bairro
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueB) {
                              bairro!.text = valueB;
                            },
                            controller: bairro,
                            enabled: editingBairro,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingBairro,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingBairro = !editingBairro;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingBairro,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          bairro!.text = bairro!.text;
                          changeBairro();
                          editingBairro = !editingBairro;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingBairro,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingBairro = !editingBairro;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* Número
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueN) {
                              numero!.text = valueN;
                            },
                            controller: numero,
                            enabled: editingNumber,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingNumber,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingNumber = !editingNumber;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingNumber,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          numero!.text = numero!.text;
                          changeNumero();
                          editingNumber = !editingNumber;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingNumber,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingNumber = !editingNumber;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                //* CEP
                Padding(
                   padding: const EdgeInsets.only(
                        left: 15.0,
                        top: 30),
                  child: Row(
                    children: [
                         SizedBox(
                          width: 300,
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            onChanged: (valueC) {
                              cep!.text = valueC;
                            },
                            controller: cep,
                            enabled: editingCEP,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      Visibility(
                        visible: !editingCEP,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingCEP = !editingCEP;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.edit
                        ),
                        ),
                        ),
                        Visibility(
                        visible: editingCEP,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          cep!.text = cep!.text;
                          changeCEP();
                          editingCEP = !editingCEP;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.check
                        ),
                        ),
                        ),
                         Visibility(
                        visible: editingCEP,
                        child: IconButton(
                        onPressed: () {
                          setState(() {
                          editingCEP = !editingCEP;
                          }
                          );
                          
                        }, icon: Icon(
                          Icons.close
                        ),
                        ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 260.0,
                    top: 30),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                        Colors.white
                        )
                      ),
                      onPressed: () {
                        //* deleteConta();
                        showDialog(context: context,
                         builder: (context) {
                           return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text('Deletar Conta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                            ),
                            actions: [
                              Text('Tem certeza que quer deletar a sua conta?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text('Voltar',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15
                                    ),
                                    ),
                                    ),
                                    TextButton(
                                    onPressed: () {
                                      deleteUser();
                                      Navigator.pushNamed(context, 'login');
                                    }, child: Text('DELETAR CONTA',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    ),
                                ],
                              ),
                            ],
                           );
                         },);
                      }, child: Text('Apagar conta',
                      style: TextStyle(
                        color: Colors.red
                      ),)),
                )
              ],
            ),
          ),
        ),
    );
  }
}
