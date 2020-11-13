import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SteplinePage extends StatefulWidget {
  @override
  _SteplinePageState createState() => _SteplinePageState();
}

class _SteplinePageState extends State<SteplinePage> {
  var hadZero = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //OK AND CLEAR BUTTONS
          Container(
            // decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.white,
                  ),
                  Positioned(
                    height: 200,
                    left: 25.0,
                    top: 25.0,
                    child: Column(
                      // mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("D"),
                        SizedBox(
                          height: 11,
                        ),
                        Text("D"),
                        SizedBox(
                          height: 11,
                        ),
                        Text("D"),
                        SizedBox(
                          height: 9,
                        ),
                        Text("D"),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 25.0,
                    left: 25.0,
                    right: 25.0,
                    top: 25.0,
                    child: Container(
                      height: 200,
                      child: SfCartesianChart(
                          primaryXAxis: NumericAxis(
                            plotOffset: 10,
                            rangePadding: ChartRangePadding.auto,
                            majorTickLines: MajorTickLines(
                                size: 6, width: 2, color: Colors.black),
                            minorTickLines: MinorTickLines(
                                size: 4, width: 2, color: Colors.black),
                            minorTicksPerInterval: 3,
                            majorGridLines: MajorGridLines(
                              width: 0.5,
                              color: Colors.grey.shade500,
                            ),
                            // labelFormat: '${xAxisFormat("{value}")}',
                          ),
                          primaryYAxis: NumericAxis(
                              minorGridLines: MinorGridLines(
                                width: 0,
                                color: Colors.white,
                              ),
                              majorGridLines: MajorGridLines(
                                width: 0.5,
                                color: Colors.grey.shade500,
                              ),
                              minorTicksPerInterval: 0,
                              interval: 1,
                              minimum: 0,
                              maximum: 4,
                              maximumLabels: 10,
                              labelStyle: TextStyle(
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.w500)

                              // isVisible: false,
                              ),
                          series: <ChartSeries>[
                            StepLineSeries<ChartSampleData, double>(
                                dataSource: chartData,
                                xValueMapper: (ChartSampleData sales, _) =>
                                    sales.x,
                                yValueMapper: (ChartSampleData sales, _) =>
                                    sales.y,
                                width: 4),
                          ]),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*

  */

  String xAxisFormat(value) {
    print(value);
    if (value == '0') {
      if (hadZero) {
        hadZero = false;
        return 'M';
      } else {
        return 'N';
      }
    }
    return '{value}-';
  }
}

class ChartSampleData {
  ChartSampleData({this.x, this.y, this.xStr});
  final double x;
  final double y;
  final String xStr;
}

final List<ChartSampleData> chartData = <ChartSampleData>[
  ChartSampleData(x: 00, y: 1.5, xStr: '00'),
  ChartSampleData(x: 0.25, y: 2.5, xStr: '00'),
  ChartSampleData(x: 0.5, y: 1.5, xStr: '00'),
  ChartSampleData(x: 0.75, y: 1.5, xStr: '00'),
  ChartSampleData(x: 01, y: 2.5, xStr: '01'),
  ChartSampleData(x: 1.25, y: 2.5, xStr: '01'),
  ChartSampleData(x: 1.5, y: 2.5, xStr: '01'),
  ChartSampleData(x: 1.75, y: 2.5, xStr: '01'),
  ChartSampleData(x: 02, y: 0.5, xStr: '02'),
  ChartSampleData(x: 2.25, y: 0.5, xStr: '02'),
  ChartSampleData(x: 2.5, y: 0.5, xStr: '02'),
  ChartSampleData(x: 2.75, y: 0.5, xStr: '02'),
  ChartSampleData(x: 03, y: 1.5, xStr: '03'),
  ChartSampleData(x: 3.25, y: 1.5, xStr: '03'),
  ChartSampleData(x: 3.5, y: 1.5, xStr: '03'),
  ChartSampleData(x: 3.75, y: 1.5, xStr: '03'),
  ChartSampleData(x: 04, y: 1.5, xStr: '04'),
  ChartSampleData(x: 4.25, y: 1.5, xStr: '04'),
  ChartSampleData(x: 4.5, y: 1.5, xStr: '04'),
  ChartSampleData(x: 4.75, y: 1.5, xStr: '04'),
  ChartSampleData(x: 05, y: 1.5, xStr: '05'),
  ChartSampleData(x: 5.25, y: 1.5, xStr: '05'),
  ChartSampleData(x: 5.5, y: 1.5, xStr: '05'),
  ChartSampleData(x: 5.75, y: 1.5, xStr: '05'),
  ChartSampleData(x: 06, y: 3.5, xStr: '06'),
  ChartSampleData(x: 6.25, y: 3.5, xStr: '06'),
  ChartSampleData(x: 6.5, y: 3.5, xStr: '06'),
  ChartSampleData(x: 6.75, y: 3.5, xStr: '06'),
  ChartSampleData(x: 07, y: 3.5, xStr: '07'),
  ChartSampleData(x: 7.25, y: 3.5, xStr: '07'),
  ChartSampleData(x: 7.5, y: 3.5, xStr: '07'),
  ChartSampleData(x: 7.75, y: 3.5, xStr: '07'),
  ChartSampleData(x: 08, y: 3.5, xStr: '08'),
  ChartSampleData(x: 8.25, y: 3.5, xStr: '08'),
  ChartSampleData(x: 8.5, y: 3.5, xStr: '08'),
  ChartSampleData(x: 8.75, y: 3.5, xStr: '08'),
  ChartSampleData(x: 09, y: 3.5, xStr: '09'),
  ChartSampleData(x: 9.25, y: 3.5, xStr: '09'),
  ChartSampleData(x: 9.5, y: 3.5, xStr: '09'),
  ChartSampleData(x: 9.75, y: 3.5, xStr: '09'),
  ChartSampleData(x: 10, y: 3.5, xStr: '10'),
  ChartSampleData(x: 10.25, y: 3.5, xStr: '10'),
  ChartSampleData(x: 10.5, y: 3.5, xStr: '10'),
  ChartSampleData(x: 10.75, y: 3.5, xStr: '10'),
  ChartSampleData(x: 11, y: 1.5, xStr: '11'),
  // ChartSampleData(x: 11.25, y: 1.5, xStr: '11'),
  // ChartSampleData(x: 11.5, y: 1.5, xStr: '11'),
  // ChartSampleData(x: 11.75, y: 1.5, xStr: '11')
];
