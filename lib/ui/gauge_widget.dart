import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GaugeWidget extends StatelessWidget {
  final double value;
  final String label;
  final double max;

  GaugeWidget(this.value, this.label, this.max);
  String toTime(value) {
    var _val = (value).toStringAsFixed(2).split('.');
    return "${_val[0]}:${_val[1]}";
  }

  @override
  Widget build(BuildContext context) {
    double calcVal = (this.value * 100) / this.max;
    return Container(
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              pointers: <GaugePointer>[
                RangePointer(
                  width: 5,
                  value: calcVal,
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
                      child: Text(toTime(value), //"08:00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                    )),
                GaugeAnnotation(
                    positionFactor: 0,
                    verticalAlignment: GaugeAlignment.near,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 55),
                          child: Text(label, style: TextStyle(fontSize: 30)),
                          //                           Align(
                          //    alignment: Alignment.bottomRight,
                          //    child: Container(width: 100, height: 100, color: Colors.red),
                          // )
                        )
                      ],
                    ))
              ],
              axisLineStyle: AxisLineStyle(
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.grey.shade300,
                thickness: 5,
              ))
        ],
      ),
    );
  }
}
