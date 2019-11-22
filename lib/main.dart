import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightGreen[100],
      accentColor: Colors.teal[100],
      fontFamily: 'Arial',
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  int Entrada = 00, Salida=00, PrecioHo =0, TiempoH, Minutos,
   MinutosCam =0, Precio = 0, Extra = 00, MinutosFinales = 00,Sobra =0;
  double Pagar = 0, PagarM =0, Total= 0;
  String SIN;

  TimeOfDay _Inicio = new TimeOfDay.now();
  TimeOfDay _Ultimo = new TimeOfDay.now();

    Future<Null> _seleccionaHoraEntrada(BuildContext inicio) async {
    final TimeOfDay tomaEntrada = await showTimePicker(
        context: inicio,
        initialTime: _Inicio);

    if(tomaEntrada != null && tomaEntrada != _Inicio){

      setState(() {

        _Inicio = tomaEntrada;
        Entrada = tomaEntrada.hour;
        Extra = tomaEntrada.minute;

      });
    }
  }
  Future<Null> _seleccionaHoraFinal(BuildContext ultima) async{
    final TimeOfDay tomaUltimo = await showTimePicker(
        context: ultima,
        initialTime: _Ultimo);

    if(tomaUltimo != null && tomaUltimo != _Ultimo){

      setState(() {

        _Ultimo = tomaUltimo;
        Salida = tomaUltimo.hour;
        MinutosFinales = tomaUltimo.minute;
      });
    }
  }

  void calcularTotal(){
    if(PrecioHo != 0 && Precio != 0){
      TiempoH = Salida - Entrada;
      Minutos = MinutosFinales-Extra;
      MinutosCam = (Minutos+(TiempoH*60))%60;
      Sobra = (Minutos+(TiempoH*60));
      PagarM= Sobra/60;
      Total = PagarM * PrecioHo;
      if(Sobra<=0.99){

        Sobra = 0;

        }else{
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Valet parking'),
      ),
      body: new Container(

        padding: new EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                TextField(

                  decoration: InputDecoration(

                      icon: Icon(Icons.fiber_manual_record),
                      labelText: 'Precio',
                      helperText: 'Coste de Hora',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),

                  onChanged: (Devolver){
                    print('Salida');

                    setState(() {

                      PrecioHo = int.parse(Devolver);

                    });

                  },
                ),


                TextField(

                  decoration: InputDecoration(

                    icon: Icon(Icons.fiber_manual_record),
                    labelText: 'Tarifa después de 15 minutos',
                    helperText: 'Coste Exedente',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                  ),


                  onChanged: (Devolver){
                    print('Salida');

                    setState(() {
                      Precio = int.parse(Devolver);
                    });

                  },
                ),
                Center(
                  child: Column(

                    children: <Widget>[

                      new RaisedButton(
                        color: Color.fromARGB(200, 700, 205, 70),
                        onPressed: (){
                          _seleccionaHoraEntrada(context);

                        },

                        textColor: Colors.white,
                        child:
                        Container(
                          child:
                          Text('Seleccionar Hora de Entrada',
                          ),
                        ),
                      ),

                      new RaisedButton(
                        color: Color.fromRGBO(200, 700, 205, 70),
                        onPressed: () {
                          _seleccionaHoraFinal(context);
                        },
                        textColor: Colors.white,
                        child:
                        Container(
                          child:
                          new Text('Seleccionar Hora de Salida'),
                        ),
                      ),

                    ],
                  ),
                ),
                Center(

                  child: Column(

                    children: <Widget>[

                      new Text('Entraste: $Entrada:$Extra\n\n'),
                      new Text('Saliste: $Salida:$MinutosFinales\n'),
                      new Text('Total: $Total'),
                      Text('\nTiempo transcurrido $Sobra : $MinutosCam'),

                    ],
                  ),
                ),
                RaisedButton(
                  color: Color.fromRGBO(200, 700, 205, 70),
                  child: new Text('Cobrar',
                      style:
                      TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      calcularTotal();
                    }
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
