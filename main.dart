import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Borda(),
        ),
      ),
    );
  }
}

class Borda extends StatefulWidget {
  @override
  _BordaState createState() => _BordaState();
}

class _BordaState extends State<Borda> {
  late List<List<String>> borda;
  late int turno;

  @override
  void initState() {
    super.initState();
    iniciaBorda();
  }

  void iniciaBorda() {
    borda = List.generate(3, (i) => List.filled(3, ''));
    turno = 1;
  }

  void resetaBorda() {
    setState(() {
      iniciaBorda();
    });
  }

  void funcBotao(int row, int col) {
    if (borda[row][col] == '' && !estadoJogo()) {
      setState(() {
        if (turno == 1) {
          borda[row][col] = 'X';
        } else {
          borda[row][col] = 'O';
        }
        turno = 3 - turno;  
      });
    }
  }

  bool estadoJogo() {

  for (int i = 0; i < 3; i++) {
    if (borda[i][0] != '' &&
        borda[i][0] == borda[i][1] &&
        borda[i][1] == borda[i][2]) {
      popupVenceu(borda[i][0]);
      return true;
    }
    if (borda[0][i] != '' &&
        borda[0][i] == borda[1][i] &&
        borda[1][i] == borda[2][i]) {
      popupVenceu(borda[0][i]);
      return true;
    }
  }

  
  if (borda[0][0] != '' &&
      borda[0][0] == borda[1][1] &&
      borda[1][1] == borda[2][2]) {
    popupVenceu(borda[0][0]);
    return true;
  }
  if (borda[0][2] != '' &&
      borda[0][2] == borda[1][1] &&
      borda[1][1] == borda[2][0]) {
    popupVenceu(borda[0][2]);
    return true;
  }

  bool empate = true;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (borda[i][j] == '') {
        empate = false;
        break;
      }
    }
  }
  if (empate) {
    showTieDialog();
    return true; 
  }
  return false; 
}

void popupVenceu(String winner) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Jogador $winner venceu!'),
        content: Text('Parabéns ao Jogador $winner.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetaBorda();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void showTieDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Véia!'),
        content: Text('Empate'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetaBorda();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int j = 0; j < 3; j++)
                buildSquare(i, j),
            ],
          ),
        ElevatedButton(
          onPressed: resetaBorda,
          child: Text('Reiniciar Jogo'),
        ),
      ],
    );
  }

  Widget buildSquare(int row, int col) {
    Color buttonColor = Colors.white;

    if (borda[row][col] == 'X') {
      buttonColor = Colors.green;
    } else if (borda[row][col] == 'O') {
      buttonColor = Colors.lightBlue;
    }

    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80.0,
      height: 80.0,
      child: ElevatedButton(
        onPressed: () {
          funcBotao(row, col);
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
        ),
        child: Text(borda[row][col]),
      ),
    );
  }
}