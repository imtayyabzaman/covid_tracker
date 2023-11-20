import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    StatesServices statesServices = StatesServices();
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
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(
                              snapshot.data!.cases!.toString(),
                            ),
                            'Recovered': double.parse(
                              snapshot.data!.recovered!.toString(),
                            ),
                            'Death': double.parse(
                              snapshot.data!.deaths!.toString(),
                            ),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 3.0,
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
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
                                ReuseableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today\'s Death',
                                  value: snapshot.data!.todayDeaths!.toString(),
                                ),
                                ReuseableRow(
                                  title: 'Today\'s Recovered',
                                  value:
                                      snapshot.data!.todayRecovered!.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CountriesListScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 50,
                            child: const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
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
      padding: const EdgeInsets.only(
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
          const Divider(),
        ],
      ),
    );
  }
}
