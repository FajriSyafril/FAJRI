import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SensorPage extends StatefulWidget {
  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  GyroscopeEvent? _gyroscopeValues;
 

  @override
  void initState() {
    super.initState();

    // Daftarkan listener untuk gyroscope sensor
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = event;
        // Aplikasikan perubahan orientasi berdasarkan data gyroscope
        
      });
    });
  }

  @override
  void dispose() {
    // Lepaskan listener saat halaman dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Page'),
      ),
      body: Stack(
        children: [
        
          Positioned(
            top: 370,
            left: 100,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: _gyroscopeValues != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Gyroscope Values:',
                            style: TextStyle(fontSize: 18.0)),
                        Text('X: ${_gyroscopeValues!.x.toStringAsFixed(2)}'),
                        Text('Y: ${_gyroscopeValues!.y.toStringAsFixed(2)}'),
                        Text('Z: ${_gyroscopeValues!.z.toStringAsFixed(2)}'),
                      ],
                    )
                  : Text('Gyroscope data not available'),
            ),
          ),
        ],
      ),
    );
  }
}
