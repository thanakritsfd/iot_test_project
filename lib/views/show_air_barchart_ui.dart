// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot_test_project/models/roomtemp.dart';
import 'package:intl/intl.dart';
import 'package:iot_test_project/services/call_api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShowAirBarChartUI extends StatefulWidget {
  const ShowAirBarChartUI({super.key});

  @override
  State<ShowAirBarChartUI> createState() => _ShowAirBarChartUIState();
}

class _ShowAirBarChartUIState extends State<ShowAirBarChartUI> {
  String? dateSelected = 'ปี-เดือน-วัน';

  String showThaiMonth(month) {
    switch (month) {
      case 1:
        return 'มกราคม';
      case 2:
        return 'กุมภาพันธ์';
      case 3:
        return 'มีนาคม';
      case 4:
        return 'เมษายน';
      case 5:
        return 'พฤษภาคม';
      case 6:
        return 'มิถุนายน';
      case 7:
        return 'กรกฎาคม';
      case 8:
        return 'สิงหาคม';
      case 9:
        return 'กันยายน';
      case 10:
        return 'ตุลาคม';
      case 11:
        return 'พฤศจิกายน';
      default:
        return 'ธันวาคม';
    }
  }

  String showThaiDate = 'โปรดเลือกวันที่ที่ต้องการ';

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
        // showThaiDate = 'วันที่ ' + datetime.day.toString() + ' ' + showThaiMonth(datetime.month) + ' ' + (543 + datetime.year).toString();
        showThaiDate = 'วันที่ ${datetime.day} ${showThaiMonth(datetime.month)} ${543 + datetime.year}';
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
            series: <ColumnSeries>[
              ColumnSeries<Roomtemp, String>(
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
          'กราฟแท่งแอร์ทั้งหมด',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
                  },
                  icon: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            Text(
              showThaiDate,
              style: TextStyle(
                color: Colors.blue[800],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 30,
                ),
                child: flag == 1
                    ? Text('ไม่มีข้อมูล')
                    : FutureBuilder<List<Roomtemp>>(
                        future: _getbydateRoomtemp(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error.....',
                            );
                          } else {
                            return snapshot.data![0].roomtempId == 0
                                ? Text('ไม่มีข้อมูล')
                                : SfCartesianChart(
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
                                    title: ChartTitle(text: 'Tempurature Chart of AIR'),
                                    legend: Legend(isVisible: true),
                                    series: <ColumnSeries>[
                                      ColumnSeries<Roomtemp, String>(
                                        dataSource: snapshot.data!,
                                        xValueMapper: (Roomtemp data, _) => data.timesave ?? '',
                                        yValueMapper: (Roomtemp data, _) => data.temp1 ?? 0,
                                        name: 'Temp1',
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                        markerSettings: MarkerSettings(isVisible: true),
                                      ),
                                      ColumnSeries<Roomtemp, String>(
                                        dataSource: snapshot.data!,
                                        xValueMapper: (Roomtemp data, _) => data.timesave ?? '',
                                        yValueMapper: (Roomtemp data, _) => data.temp2 ?? 0,
                                        name: 'Temp2',
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                        markerSettings: MarkerSettings(isVisible: true),
                                      ),
                                      ColumnSeries<Roomtemp, String>(
                                        dataSource: snapshot.data!,
                                        xValueMapper: (Roomtemp data, _) => data.timesave ?? '',
                                        yValueMapper: (Roomtemp data, _) => data.temp3 ?? 0,
                                        name: 'Temp3',
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                        markerSettings: MarkerSettings(isVisible: true),
                                      ),
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
