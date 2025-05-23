import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';



class SalesData {
    SalesData(this.year, this.sales);
    final DateTime year;
    final double sales;
}

class EstadisticPage extends StatelessWidget {
  const EstadisticPage({super.key});

  

  @override
  Widget build(BuildContext context) {
        final List<SalesData> chartData = [
            SalesData(DateTime(2024), 0),
            SalesData(DateTime(2025), 5),
            SalesData(DateTime(2026), 10),
            SalesData(DateTime(2027), 14),
            SalesData(DateTime(2028), 18),
        ];
 
        return Scaffold(
            appBar: AppBar(title: Text('Estadistica'),),
            body: Center(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <CartesianSeries>[
                        // Renders line chart
                        LineSeries<SalesData, DateTime>(
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales
                        )
                    ]
                )
            )
        );
    }
}