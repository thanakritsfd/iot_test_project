// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot_test_project/models/roomtemp.dart';
import 'package:intl/intl.dart';
import 'package:iot_test_project/services/call_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowAir1LinegraphUI extends StatefulWidget {
  const ShowAir1LinegraphUI({super.key});

  @override
  State<ShowAir1LinegraphUI> createState() => _ShowAir1LinegraphUIState();
}

class _ShowAir1LinegraphUIState extends State<ShowAir1LinegraphUI> {
  String? dateSelected = 'ปี-เดือน-วัน';

  Future showCalendar() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (datetime != null) {
      setState(() {
        dateSelected = DateFormat('yyyy-MM-dd').format(datetime);
        flag = 0;
      });
    }
  }

  int flag = 1;

  Future<List<Roomtemp>> _getbydateRoomtemp() async {
    return await CallApi.getbydateRoomtemp(Roomtemp(datesave: dateSelected));
  }

  buildGraph() async {
    return FutureBuilder(
      future: _getbydateRoomtemp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
            'Error.....',
          );
        } else {
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                text: 'เวลา',
              ),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'อุณหภูมิ',
              ),
            ),
            title: ChartTitle(text: 'Tempurature Chart of AIR 1'),
            legend: Legend(isVisible: true),
            series: <LineSeries>[
              LineSeries<Roomtemp, String>(
                dataSource: snapshot.data!,
                xValueMapper: (Roomtemp data, _) => data.timesave ?? '',
                yValueMapper: (Roomtemp data, _) => data.temp1 ?? 0,
                name: 'Tempurature',
                dataLabelSettings: DataLabelSettings(isVisible: true),
                markerSettings: MarkerSettings(isVisible: true),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 134, 13, 5),
        title: Text(
          'กราฟเส้นแอร์ตัวที่ 1',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'วันที่ ',
                ),
                Text(
                  dateSelected!,
                  style: TextStyle(
                    color: Colors.blue[800],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showCalendar();
                    //buildGraph();
                  },
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (dateSelected != 'yyyy-MM-dd') {
            //       // _getbydateRoomtemp();
            //       setState(() {
            //         flag = 0;
            //       });
            //     } else {
            //       flag = 1;
            //     }
            //   },
            //   child: Text(
            //     'Show Graph',
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 30,
                ),
                child: flag == 1
                    ? Container(color: Colors.transparent)
                    : FutureBuilder<List<Roomtemp>>(
                        future: _getbydateRoomtemp(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error.....',
                            );
                          } else {
                            return SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                title: AxisTitle(
                                  text: 'เวลา',
                                ),
                                labelRotation: -45,
                              ),
                              primaryYAxis: NumericAxis(
                                title: AxisTitle(
                                  text: 'อุณหภูมิ',
                                ),
                                labelFormat: '{value}℃',
                              ),
                              title: ChartTitle(
                                  text: 'Tempurature Chart of AIR 1'),
                              legend: Legend(isVisible: true),
                              series: <LineSeries>[
                                LineSeries<Roomtemp, String>(
                                  dataSource: snapshot.data!,
                                  xValueMapper: (Roomtemp data, _) =>
                                      data.timesave ?? '',
                                  yValueMapper: (Roomtemp data, _) =>
                                      data.temp1 ?? 0,
                                  name: 'Tempurature',
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true),
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                ),
                                // LineSeries<Roomtemp, String>(
                                //   dataSource: snapshot.data!,
                                //   xValueMapper: (Roomtemp data, _) =>
                                //       data.timesave ?? '',
                                //   yValueMapper: (Roomtemp data, _) =>
                                //       data.temp2 ?? 0,
                                //   name: 'Tempurature2',
                                //   dataLabelSettings:
                                //       DataLabelSettings(isVisible: true),
                                //   markerSettings:
                                //       MarkerSettings(isVisible: true),
                                // ),
                              ],
                            );
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
