import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

// external class to design custom legends
class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(BuildContext context,
      {Color? color, required Size size, bool enabled = true}) {
    return SizedBox.fromSize(
      size: size,
      child: Icon(
        iconData,
        color: color,
        size: 12,
      ),
    );
  }
}

class PieChartGaugeDashboard extends StatefulWidget {
  final Color color;
  final Color color2;
  PieChartGaugeDashboard(this.color, this.color2);

  @override
  State<PieChartGaugeDashboard> createState() => _PieChartGaugeDashboardState();
}

class _PieChartGaugeDashboardState extends State<PieChartGaugeDashboard> {
  List<charts.Series<PieChartData, String>> _seriesPieData = [];
  // list to store graph data

  _generateData() {
    var pieData = [
      PieChartData(
        // class to store legend title, graph percentage, and graph color
        'Answered',
        60,
        widget.color,
      ),
      PieChartData(
        'Missed',
        0,
        widget.color2,
      ),
    ];

    _seriesPieData.add(
      // adding data to graph
      charts.Series(
        domainFn: (PieChartData title, _) => title.legendAndxAxesTitle,
        measureFn: (PieChartData chartData, _) => chartData.pieChartDataOne,
        colorFn: (PieChartData chartColor, _) =>
            charts.ColorUtil.fromDartColor(chartColor.colorval),
        id: 'sample',
        data: pieData,
        labelAccessorFn: (PieChartData row, _) => '${row.pieChartDataOne}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
        animate: true,
        animationDuration: Duration(seconds: 1),
        _seriesPieData,
        behaviors: [
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.start,
            horizontalFirst: false,
            position: charts.BehaviorPosition.bottom,
            desiredMaxRows: 2,
            cellPadding: EdgeInsets.only(left: 16, bottom: 5),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black, fontSize: 11),
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(
            symbolRenderer: IconRenderer(CupertinoIcons.rhombus_fill),
            // calling overridden class to design custom widget
            // arcRendererDecorators: [
            //   charts.ArcLabelDecorator(
            //       labelPosition: charts.ArcLabelPosition.inside,
            //       insideLabelStyleSpec: charts.TextStyleSpec(
            //           fontSize: 14,
            //           color: charts.ColorUtil.fromDartColor(Colors.black)))
            // ],
            // arcWidth: 30,
            startAngle: -2 / 5,
            arcLength: 7 / 5 * 3.14));

    // startAngle = from which angle gauge is starting
  }
}

class PieChartData {
  int pieChartDataOne;
  String legendAndxAxesTitle;
  Color colorval;

  PieChartData(this.legendAndxAxesTitle, this.pieChartDataOne, this.colorval);
}
