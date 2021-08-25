import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_example/coin.dart';

class HomeScreen extends StatelessWidget {
  final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'));
  final Queue<Coin> queue = Queue();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              Text('Trade Symbol : BTCUSDT trade'),
              SizedBox(
                height: 24,
              ),
              AspectRatio(
                aspectRatio: 1.70,
                child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    debugPrint(snapshot.data.toString(), wrapWidth: 2048);
                    var data = jsonDecode(snapshot.data.toString())
                        as Map<String, dynamic>;
                    var coin = Coin.fromJson(data);

                    queue.add(coin);

                    if (queue.length > 100) {
                      queue.removeFirst();
                    }
                    return SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: DateTimeAxis(
                        dateFormat: DateFormat.Hms(),
                        intervalType: DateTimeIntervalType.milliseconds,
                        desiredIntervals: 10,
                        axisLine: AxisLine(width: 2, color: Colors.white),
                        majorTickLines:
                            MajorTickLines(color: Colors.transparent),
                      ),
                      primaryYAxis: NumericAxis(
                        numberFormat: NumberFormat('##,###.00'),
                        desiredIntervals: 5,
                        decimalPlaces: 2,
                        axisLine: AxisLine(width: 2, color: Colors.white),
                        majorTickLines:
                            MajorTickLines(color: Colors.transparent),
                      ),
                      plotAreaBorderColor: Colors.white.withOpacity(0.2),
                      plotAreaBorderWidth: 0.2,
                      series: <LineSeries<Coin, DateTime>>[
                        LineSeries<Coin, DateTime>(
                          animationDuration: 0.0,
                          width: 2,
                          color: Theme.of(context).primaryColor,
                          dataSource: queue.toList(),
                          xValueMapper: (Coin coin, _) =>
                              DateTime.fromMicrosecondsSinceEpoch(coin.t),
                          yValueMapper: (Coin coin, _) =>
                              double.tryParse(coin.p) ?? 0,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
