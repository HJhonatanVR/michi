import 'dart:math';

import 'package:app_3raya/comp/CustomButton.dart';
import 'package:app_3raya/theme/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Michi());
}
class Michi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MichiPage(),
    );
  }
}

class MichiPage extends StatefulWidget {
  @override
  MichiState createState() => MichiState();
}

class MichiState extends State<MichiPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _p1 = new TextEditingController();
  TextEditingController _p2 = new TextEditingController();
  final List<String> entries = <String>['1'];
  final List<String> entries2 = <String>[''];
  final List<String> entries3 = <String>['T'];
  final List<String> entries4 = <String>['1'];
  List labelList = [" "," "," "," "," "," "," "," "," "];
  bool enableDisable=false;
  String turno="";
  String ganador="";
  bool clickTurno=false;
  int chance_flag=0;

  void accion() {
    setState(() {
      AppTheme.colorX=Colors.blue;
    });
  }

  void btnInicio(){
    labelList.replaceRange(0, 9, ["","","","","","","","",""]);
    ganador="";
    enableDisable=true;
    chance_flag=0;
    Random rnd = new Random();
    int min = 13, max = 42;
    int r = min + rnd.nextInt(max - min);
    if(r%2==0){
      turno="J1:${_p1.value.text}-(X)";
    }else{
      turno="J2:${_p2.value.text}-(O)";
    }
  }
  void btnAnular(){
    labelList.replaceRange(0, 9, ["","","","","","","","",""]);
    enableDisable=false;
    turno="";
  }

  void numClick(String text, int index) {
    setState((){
      if(text==""){
        chance_flag+=1;
      }
      start(index);
      matchCheck();
      print("ver txt: ${text} index: ${index} num val: ${labelList[index]} cant:${chance_flag}");
    });
  }
  void start(int index){
    var parts = turno.split(':');
    if(parts[0].trim()=="J1" && clickTurno==false){
      labelList[index]="X";
      clickTurno=true;
      turno="J2:${_p2.value.text}-(O)";
    }else{
      labelList[index]="O";
      clickTurno=false;
      turno="J1:${_p1.value.text}-(X)";
    }
  }
  void matchCheck() {
    if ((labelList[0]=="X") && (labelList[1]=="X") && (labelList[2]=="X")) {xWins();}
    else if ((labelList[0]=="X") && (labelList[4]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[0]=="X") && (labelList[3]=="X") && (labelList[6]=="X")) {xWins();}
    else if ((labelList[1]=="X") && (labelList[4]=="X") && (labelList[7]=="X")) {xWins();}
    else if ((labelList[2]=="X") && (labelList[4]=="X") && (labelList[6]=="X")) {xWins();}
    else if ((labelList[2]=="X") && (labelList[5]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[3]=="X") && (labelList[4]=="X") && (labelList[5]=="X")) {xWins();}
    else if ((labelList[6]=="X") && (labelList[7]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[0]=="O") && (labelList[1]=="O") && (labelList[2]=="O")) {oWins();}
    else if ((labelList[0]=="O") && (labelList[3]=="O") && (labelList[6]=="O")) {oWins();}
    else if ((labelList[0]=="O") && (labelList[4]=="O") && (labelList[8]=="O")) {oWins();}
    else if ((labelList[1]=="O") && (labelList[4]=="O") && (labelList[7]=="O")) {oWins();}
    else if ((labelList[2]=="O") && (labelList[4]=="O") && (labelList[6]=="O")) {oWins();}
    else if ((labelList[2]=="O") && (labelList[5]=="O") && (labelList[8]=="O")) {oWins();}
    else if ((labelList[3]=="O") && (labelList[4]=="O") && (labelList[5]=="O")) {oWins();}
    else if ((labelList[6]=="O") && (labelList[7]=="O") && (labelList[8]=="O")) {oWins();}
    else if(chance_flag==9) {
      enableDisable=false;
      ganador="Empate";
      turno="Termino";
    }
  }
  void xWins(){
    ganador="${_p1.value.text}";
    enableDisable=false;
    turno="Termino";//if(chance_flag==9){ turno="Termino";}
  }
  void oWins(){
    ganador="${_p2.value.text}";
    enableDisable=false;
    turno="Termino";//if(chance_flag==9){ turno="Termino";}
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.colorX=Colors.amber;
    List funx=[numClick,numClick, numClick,numClick , numClick,numClick, numClick,numClick , numClick];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UPeU',
      //Fin Agregado
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("UPeU - JUEGO DE TRES EN RAYA")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Arial',
                    ),
                  ),
                  _buidForm(),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 3,
                    ),
                    children: [
                      ...List.generate(
                        labelList.length,
                            (indexx) => CustomButton(
                          text: labelList[indexx],
                          index: indexx,
                          buttonenabled: enableDisable,
                          callback: funx[indexx] as Function,
                        ),
                      ),
                    ],
                    padding: EdgeInsets.all(30),
                    shrinkWrap: true,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: const Text('T:'),
                          ),
                          label: Text(turno)),
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: const Text('G:'),
                          ),
                          label: Text(ganador))
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("TABLA DE PUNTAJES", style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Arial',
                  ),),
                  SizedBox(height: 2),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Partido ${entries[index]}',
                                      style: Theme.of(context).textTheme.headline6),
                                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppTheme.colorX=Colors.cyan),
                                        child: Text("Ganador:" + ganador),
                                      )
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: const Text('P:'),
                                          ),
                                          label: Text("${entries4[index]}")),
                                      SizedBox(width: 2),
                                      Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: const Text('E:'),
                                          ),
                                          label: Text("${entries3[index]}")),
                                    ],
                                  ),
                                )
                              ],
                            )),
                          );
                        }
                    ),
                  )
                ],
              )
          )
      ),
    );
  }


  Form _buidForm(){
    return Form(
        key: _formKey,
        child: Padding(
            padding:  EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children:  <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PLAYER 1: (X)',

                  ),
                  controller: _p1,
                ),
                SizedBox(height: 18),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PLAYER 2: (O)',
                  ),
                  controller: _p2,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: () {setState((){
                      btnInicio();
                    });}, child: Text("Iniciar")),
                    ElevatedButton(onPressed: (){setState((){
                      btnAnular();
                    });}, child: Text("Anular")),
                  ],
                )
              ],
            )
        ));
  }
}