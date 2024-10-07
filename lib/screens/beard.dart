import 'package:appbarbearia/homepage.dart';
import 'package:appbarbearia/screens/menu/perfil.dart';
import 'package:appbarbearia/screens/menu/prices.dart';
import 'package:appbarbearia/screens/menu/schedule.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:table_calendar/table_calendar.dart';

class Beard extends StatefulWidget {

  final int? idUser;

  const Beard({
    super.key,
    required this.idUser});

  @override
  State<Beard> createState() => _BeardState();
}

class _BeardState extends State<Beard> {

  String? usuario;
  String? nome;
  String tipo = 'Fazer a Barba';
  double preco = 60;
  String? data;
  String? dataIndisponivel;
  String? horarioIndisponivel;

  int? year;
  int? month;
  int? day;

  DateTime dayT = DateTime.now();
  DateTime? selectedDate;
  bool _showCalendar = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _firstDay;
  DateTime? _lastDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<DateTime> diasHorariosAgendados = [];
  List<String> hourNot = []; 

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
    var now = DateTime.now();
    _firstDay = DateTime(now.year, now.month - 3, now.day);
    _lastDay = DateTime(now.year, now.month + 3, now.day);
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

      var selectUser = await conn.execute("Select * from usuarios");

       for (var element in selectUser.rows) {
        Map data = element.assoc();
        usuario = data['Usuario'];
        nome = data['Nome'];
        bairro = data['Bairro'];
          }
          setState(() {
            
          });

        var selectSchedule = await conn.execute("Select * from agenda");

       for (var element in selectSchedule.rows) {
        Map data = element.assoc();
        dataIndisponivel = data['Data'];
        horarioIndisponivel = data['Horário'];
          }
          setState(() {
            
          });
      
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
  }

  Future scheduleConfirm() async{

    bool available = await isTimeSlotAvailable();
    if (available == false) {
      hourNot.clear();
       var result = await conn.execute(
      "SELECT * FROM agenda WHERE Data = '$data'");

       for (var element in result.rows) {
          Map data = element.assoc();
         hourNot.add(data['Horário']);
          }
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data e horário já agendados. Por favor, escolha outro horário.\n Horários indisponíveis no dia: ${hourNot.join(", ")}',
      style: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),),
    ));

  }else{
     try {
    // Transforma a lista [nome] em um mapa onde 'Nome' é a chave
    final Map<String, dynamic> parametros = {'ID_Usuario': idUser, 'Usuario': usuario, 'Nome': nome, 'Tipo': tipo, 'Preco': preco, 'Data': data, 'Horario': timeUser};

    // Executa a consulta SQL com o mapa de parâmetros
    var schedule = await conn.execute("Insert into agenda (ID_Usuario, Usuario, Nome, Tipo, Preço, Data, Horário) VALUES (:ID_Usuario, :Usuario, :Nome, :Tipo, :Preco, :Data, :Horario)", parametros);
  
    print('Agendamento feito com sucesso');
  } catch (e) {
    print('Erro ao concluir agendamento: $e');
  }
  }
  }

  Future<bool> isTimeSlotAvailable() async {
 // Formatar a data selecionada pelo usuário
  String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);

  // Formatar o horário selecionado pelo usuário
  String formattedTime = '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}H';

  // Combinar a data e o horário selecionados pelo usuário para o formato do banco de dados
  String formattedDateTime = '$formattedDate $formattedTime';

  var result = await conn.execute(
      "SELECT * FROM agenda WHERE Data = '$data' AND Horário = '$timeUser' ");

      var count = result.rows;
  if (count.length == 0) {
    return true;
    //return count == 0;
  }else{
  return false;
  }
}

Future<void> buscarAgendamentos() async {
  
  var resultados = await conn.execute('SELECT Data, Horário FROM agenda');

  
   for (var element in resultados.rows) {
        Map data = element.assoc();
        dataIndisponivel = data['Data'];
        horarioIndisponivel = data['Horário'];
          }

    // Parse da string para DateTime
   
  }

  bool isDayUnavailable(DateTime day) {
    if (dataIndisponivel != null) {
    // Formatar o dia no mesmo formato que as datas indisponíveis
    String formattedDay = DateFormat('dd/MM/yyyy').format(day);
    // Verificar se o dia formatado está na lista de datas indisponíveis
    return dataIndisponivel!.contains(formattedDay);
  }
  // Verificar se o dia está na lista de dias agendados
  return diasHorariosAgendados.any((DateTime diaAgendado) {
    return diaAgendado.year == day.year &&
        diaAgendado.month == day.month &&
        diaAgendado.day == day.day;
  });
}

 bool isDateTimeUnavailable(DateTime dateTime) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  if (dataIndisponivel!.contains(formattedDate)) {

    String formattedTime = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}H';
    if (horarioIndisponivel!.contains(formattedTime)) {
      
      return true;
    }
  }
  return false;
}


   String? _formattedDate;
   TimeOfDay? _selectedTime;
    String? timeUser;


   void _showTimePicker() async {

    final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
    barrierColor: Colors.blue,
    confirmText: 'Confirmar',
    cancelText: 'Cancelar',
    fieldLabelText: 'Insira uma data',

    selectableDayPredicate: (DateTime day) {
      return !isDateTimeUnavailable(day);
    },
  );

  if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        data = DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
      print('Data selecionada: $data');
    } else {
      // O usuário cancelou a seleção da data
      print('Seleção de data cancelada');
    }
    
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      confirmText: 'Confirmar',
      cancelText: 'Cancelar',
      
      barrierColor: Colors.blue,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
         timeUser = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}H';
         
        print(timeUser); 
      });
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

    if (freteG.contains(bairro))
    setState(() {
      preco = 40;
    });
    else 
    setState(() {
      preco = 50;
    });
    return Scaffold(
       appBar: AppBar(
        title: const Text('Fazer a Barba'),
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
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: 600,
            height: 800,
            color:  Color(0xFF2c3e50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 600,
                  height: 240,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Text('Preço: R\$ 60',
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
                           Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text('Atendimento em casa: De graça',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15
                            ),
                            ),
                          )
                          else
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
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
                      Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Valor Total: R\$ $preco',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    )
                    else
                      Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Valor Total: R\$ ${preco + 10}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 05,),
                      if (timeUser != null)
                   Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: Visibility(
                       child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                             'Data selecionada: $data',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                     ),
                   ),
                      SizedBox(
                        height: 05,
                      ),
                      if (timeUser != null)
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Horário escolhido: $timeUser',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black
                              )
                            ),
                            onPressed: () {
                              _showTimePicker();
                              setState(() {
                              });
                            }, child: Text('Escolher Horário e Data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black
                              )
                            ),
                            onPressed: () {
                              scheduleConfirm();
                              setState(() {
                              });
                            }, child: Text('Confirmar Agendamento',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                            ),
                            ),
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
