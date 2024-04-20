import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _controllerEntryTime = TextEditingController();
  final TextEditingController _controllerLeavingTime = TextEditingController();
  String _incidentTime = "00:00";
  int _count = 0;

  void _calculatePermissionTime() {
    try {
      DateTime entryTime =
          DateFormat("HH:mm").parseStrict(_controllerEntryTime.text);
      DateTime leavingRealTime =
          DateFormat("HH:mm").parseStrict(_controllerLeavingTime.text);

      DateTime leavingTime = entryTime.add(const Duration(hours: 8));
      DateTime finalLeavingTime = DateTime(2023, 1, 1, 16, 30);

      Duration difference = leavingTime.difference(leavingRealTime);
      DateTime incidentDifference = finalLeavingTime.subtract(difference);
      int hours = incidentDifference.hour;
      int minutes = incidentDifference.minute % 60;
      String leavingHour = "00";
      String leavingMinutes = "00";

      hours == 0 ? leavingHour = "00" : leavingHour = "$hours";
      minutes < 10 ? leavingMinutes = "0$minutes" : leavingMinutes = "$minutes";

      setState(() {
        _incidentTime = '$leavingHour:$leavingMinutes';
        _count = difference.inMinutes;
      });
    } catch (e) {
      setState(() {
        _incidentTime = 'Error en el formato de la hora';
      });
    }
  }

  void _clearTime() {
    setState(() {
      _controllerEntryTime.text = "";
      _controllerLeavingTime.text = "";
      _incidentTime = '00:00';
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF69366B),
        title: const Text(
          "Calculadora de horas permiso",
          style: TextStyle(
            fontSize: 22,
            color: Color(0xFFFFFBFF),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _controllerEntryTime,
              decoration:
                  const InputDecoration(labelText: 'Hora entrada (HH:MM)'),
            ),
            TextField(
              controller: _controllerLeavingTime,
              decoration:
                  const InputDecoration(labelText: 'Hora salida (HH:MM)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _calculatePermissionTime();
              },
              child: Text('Calcular'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _clearTime();
              },
              child: Text('Limpiar'),
            ),
            const SizedBox(height: 16),
            Text(
              'Hora incidencia: $_incidentTime \nCantidad: $_count',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
