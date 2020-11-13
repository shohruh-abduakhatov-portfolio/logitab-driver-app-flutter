import 'package:driver_app_flutter/models/stepline_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SteplineWidget extends StatelessWidget {
  final List data;
  final Function onChange;
  final RangeValues rangeValues;
  final double minRange;
  final double maxRange;

  SteplineWidget(
    this.data, {
    this.onChange,
    this.minRange = 0,
    this.maxRange = 1439,
    this.rangeValues = const RangeValues(0, 1439),
  }) {
    editMode = this.onChange != null;
  }

  bool editMode = true;

  @override
  Widget build(BuildContext context) {
    var _startDt = DateTime(2000, 1, 1, 0, 0, 0);
    String startLabel(int numb) {
      return DateFormat('h:mm a').format(_startDt
          .add(Duration(hours: (numb / 60).floor(), minutes: numb % 60)));
    }

    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(10.0, 0, 0.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "OFF",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "SB",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "D",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "ON",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    height: 150,
                    child: SfCartesianChart(
                        primaryXAxis: NumericAxis(
                            interval: 1,
                            minimum: 0,
                            maximum: 24,
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
                            plotBands: <PlotBand>[
                              editMode
                                  ? PlotBand(
                                      associatedAxisStart: 0,
                                      associatedAxisEnd: 4,
                                      opacity: 0.3,
                                      size: 5,
                                      shouldRenderAboveSeries: true,
                                      color: Colors.orange,
                                      isVisible: true,
                                      start: rangeValues.start / 60,
                                      end: rangeValues.end / 60,
                                      borderWidth: 2,
                                    )
                                  : PlotBand(isVisible: false),
                            ]),
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
                                fontWeight: FontWeight.w500)),
                        series: <ChartSeries>[
                          StepLineSeries<dynamic, double>(
                              dataSource: data,
                              xValueMapper: (sales, _) => sales.x,
                              yValueMapper: (sales, _) => sales.y,
                              width: 2),
                        ]),
                  ),
                  editMode
                      ? SliderTheme(
                          data: SliderThemeData(
                              showValueIndicator: ShowValueIndicator.always),
                          child: RangeSlider(
                            values: rangeValues,
                            min: minRange,
                            max: maxRange,
                            divisions: maxRange.toInt(),
                            labels: RangeLabels(
                              startLabel(rangeValues.start.round()),
                              startLabel(rangeValues.end.round()),
                            ),
                            onChanged: (RangeValues values) => onChange(values),
                          ))
                      : Container()
                ],
              ),
            ),
          ],
        ),
        // ),
      ],
    );
  }
}
