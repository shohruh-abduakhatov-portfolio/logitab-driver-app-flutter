import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GaugePage extends StatefulWidget {
  @override
  GaugePageState createState() => GaugePageState();
}

class GaugePageState extends State<GaugePage> {
  GaugePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                pointers: <GaugePointer>[
                  RangePointer(
                    value: 30,
                    cornerStyle: CornerStyle.bothCurve,
                    gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF00A8B5), Color(0xFFF54EA2)],
                    ),
                  )
                ],
                showTicks: false,
                showLabels: false,
                radiusFactor: 0.9,
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0,
                      verticalAlignment: GaugeAlignment.center,
                      widget: Container(
                        child: Text('70.00',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 75)),
                      )),
                  GaugeAnnotation(
                      positionFactor: 0,
                      verticalAlignment: GaugeAlignment.near,
                      widget: Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Text('CYCLE', style: TextStyle(fontSize: 45)),
                      ))
                ],
                axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothCurve,
                  color: Colors.grey.shade300,
                ))
          ],
        )),
      ),
    );
  }
}
