import 'package:covid_tracker/View/lang_workshop.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            PieChart(
              dataMap: {
                'Total': 20,
                'Recovered': 5,
                'Death': 15,
              },
              chartRadius: MediaQuery.of(context).size.width / 3.0,
              chartType: ChartType.ring,
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
              animationDuration: Duration(milliseconds: 1200),
              colorList: colorList,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Card(
                child: Column(
                  children: [
                    ReuseableRow(title: 'Total', value: '1200'),
                    ReuseableRow(title: 'Total', value: '1200'),
                    ReuseableRow(title: 'Total', value: '1200'),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff1aa260),
                  borderRadius: BorderRadius.circular(12)),
              height: 50,
              child: Center(
                child: Text('Track Countries'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String value, title;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.009,
          ),
          Divider(),
        ],
      ),
    );
  }
}
