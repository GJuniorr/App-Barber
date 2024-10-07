import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

class Prices extends StatefulWidget {

  final int? idUser;

  const Prices({
    super.key,
    required this.idUser});

  @override
  State<Prices> createState() => _PricesState();
}

class _PricesState extends State<Prices> {

  int? idUser;
  int selectedIndex = 0;
  String? bairro;
  List freteG = [
    'jardins',
    'grageru',
    'augusto franco',
  ];

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
      databaseName: 'appbarber',
    );
    try {
      await conn.connect();
      print('Conexão bem sucedida');
      print('ID: $idUser');
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
    
    var freteUser = await conn.execute("Select Bairro from usuarios WHERE ID_Usuario = '$idUser' ");

     for (var element in freteUser.rows) {
        Map data = element.assoc();
        bairro = data['Bairro'];
          }

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
        title: const Text('Preços'),
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
          height: 600,
          width: 600,
          color: const Color(0xFF2c3e50),
          child: Column(
            children: [
              Container(
                height: 130,
                width: 600,
                color: Colors.white,
                child:  Column(
                  children: [
                    const Text('Corte de Cabelo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 300.0),
                      child: Text('Preço: R\$ 40',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (freteG.contains(bairro))
                    const Padding(
                      padding: EdgeInsets.only(right: 170.0),
                      child: Text('Atendimento em casa: De graça',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15
                      ),
                      ),
                    )
                    else
                    const Padding(
                      padding: EdgeInsets.only(right: 190.0),
                      child: Text('Atendimento em casa: R\$ 10',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (freteG.contains(bairro))
                     const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Valor Total: R\$ 40',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    )
                    else
                     const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Valor Total: R\$ 50',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                width: 600,
                color: Colors.white,
                child: const Column(
                  children: [
                    Text('Fazer a Barba',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 300.0),
                      child: Text('Preço: R\$ 60',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 190.0),
                      child: Text('Atendimento em casa: R\$ 10',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Padding(
                      padding: EdgeInsets.only(right: 265.0),
                      child: Text('Valor Total: R\$ 70',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                width: 600,
                color: Colors.white,
                child: const Column(
                  children: [
                    Text('Cortar Cabelo e Fazer a Barba',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 300.0),
                      child: Text('Preço: R\$ 90',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 190.0),
                      child: Text('Atendimento em casa: R\$ 10',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Padding(
                      padding: EdgeInsets.only(right: 255.0),
                      child: Text('Valor Total: R\$ 100',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
