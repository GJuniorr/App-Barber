import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysql_client/mysql_client.dart';

class Schedule extends StatefulWidget {

  final int? idUser;

  const Schedule({
    super.key,
    required this.idUser});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  List<Map<String, String>> dados = [];
  late MySQLConnection conn;
  int? agendaID;

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
    await scheduleSelect();
  }

  Future scheduleSelect() async {
    var resultadoSC = await conn.execute("SELECT * FROM agenda WHERE ID_Usuario = '$idUser' ORDER BY Data DESC ");
      
    List<Map<String, String>> list = [];

    for (final row in resultadoSC.rows) {
      final data = {
        'ID_Agenda': row.colAt(0)!,
        'ID_Usuario': row.colAt(1)!,
        'Usuario': row.colAt(2)!,
        'Nome':row.colAt(3)!,
        'Tipo': row.colAt(4)!,
        'Preço': row.colAt(5)!,
        'Data': row.colAt(6)!,
        'Horário': row.colAt(7)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
          
  }

  Future removeScheduling(int agendaID) async{
    var res = await conn.execute(
      'DELETE FROM agenda WHERE ID_Agenda = :ID_Agenda',
      {
        'ID_Agenda': agendaID,
      },
    );
    print(res.affectedRows);
    await getConnection();
  }


  int? idUser;
  int selectedIndex = 0;
  String? usuario;
  String? nome;

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
        title: const Text('Agenda'),
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
        ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: 600,
            height: 600,
            color: const Color(0xFF2c3e50),
            child: ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${dados[index] ['Tipo']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text('Remover agendamento',
                                  textAlign: TextAlign.center,),
                                  titleTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                  actions: [
                                    Text('Tem certeza que deseja remover este agendamento?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15
                                    ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();                                            
                                          }, child: Text('Voltar',
                                          style: TextStyle(
                                            color: Colors.black
                                          ),
                                          ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await removeScheduling(int.parse(dados[index] ['ID_Agenda']!));
                                              Navigator.of(context).pop();
                                            }, child: Text('Cancelar Agendamento',
                                            style: TextStyle(
                                              color: Colors.black
                                            ),),
                                            ),
                                      ],
                                    )
                                  ],
                                );
                              },);
                            }, icon: Icon(Icons.remove_circle,
                            color: Colors.red,))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 240.0),
                        child: Text('Preço: R\$ ${dados[index] ['Preço']}',
                         style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 200.0),
                        child: Text('Data: ${dados[index] ['Data']}',
                         style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 210.0),
                        child: Text('Horário: ${dados[index] ['Horário']}',
                         style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            ),
          ),
        ),
    );
  }
}