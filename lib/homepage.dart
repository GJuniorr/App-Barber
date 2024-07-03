// ignore_for_file: avoid_print

import 'package:appbarbearia/screens/beard.dart';
import 'package:appbarbearia/screens/hair.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

class Homepage extends StatefulWidget {
  
  final int? idUser;

  const Homepage({
    super.key, 
    required this.idUser,});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  
  late MySQLConnection conn;
  int? idUser;

  @override
  void initState() {
    super.initState();
    getConnection();
    idUser = widget.idUser;
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
      print('ID: $idUser');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
  }

  int selectedIndex = 0;

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
        title: const Text('Início'),
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
        body: Container(
          color: const Color(0xFF2c3e50),
          child: Center(
            child: Column(
              children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 200.0,
                          left: 20),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 150,
                                height: 150,
                                color: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                     Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Hair(
                                        idUser: idUser,
                                        )));
                                  }, icon: const FaIcon(FontAwesomeIcons.scissors,
                                  size: 90,),
                                  color: Colors.black,),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Cortar Cabelo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 200.0,
                          right: 20),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 150,
                                height: 150,
                                color: Colors.white,
                                child: GestureDetector(
                                  child: Image.asset('assets/images/beard.png',
                                  ),
                                  onTap: () {
                                     Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => Beard(
                                        idUser: idUser,
                                        )));
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             const Text('Fazer a Barba',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
    );
  }
}