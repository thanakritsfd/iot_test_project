// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';
import 'package:iot_test_project/models/roomtemp.dart';
import 'package:iot_test_project/services/call_api.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ShowValueIoT03 extends StatefulWidget {
  const ShowValueIoT03({super.key});

  @override
  State<ShowValueIoT03> createState() => _ShowValueIoT03State();
}

class _ShowValueIoT03State extends State<ShowValueIoT03> {
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
        return 'กรกฏาคม';
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

//เรียกใช้ Method ที่เรียก api
  Future callAPIGetRoomtemp2() async {
    var dataFromCallAPI = await CallApi.getRoomTemp2();
    return showTableDetail(dataFromCallAPI);
  }

  //Method crate หัวตาราง
  List<GridColumn> createHeadTable() {
    return <GridColumn>[
      GridColumn(
        columnName: 'temp2',
        width: 100.0,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'แอร์ตัวที่ 2',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: 'datesave',
        width: 100.0,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'วันที่',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: 'timesave',
        width: 100.0,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'เวลา',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 134, 13, 5),
        title: Text(
          'ข้อมูลแอร์ตัวที่ 2',
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
              height: 30.0,
            ),
            Text(
              'ข้อมูลแอร์ทั้งตัวที่ 2',
              style: TextStyle(
                fontSize: 25.0,
                color: const Color.fromARGB(255, 134, 13, 5),
              ),
            ),
            Text(
              '-- แสดงข้อมูลแอร์ตัวที่ 2 วัน และเวลา --',
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: FutureBuilder(
                  future: callAPIGetRoomtemp2(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'มีข้อผิดพลาด กรุณาตรวจสอบการเชื่อมต่อ Internet หรือลองใหม่อีกครั้ง',
                        ),
                      );
                    } else {
                      return SfDataGridTheme(
                        data: SfDataGridThemeData(
                          headerColor: Colors.green[400],
                        ),
                        child: SfDataGrid(
                          source: snapshot.data,
                          columns: createHeadTable(),
                          columnWidthMode: ColumnWidthMode.auto,
                          columnResizeMode: ColumnResizeMode.onResize,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'ข้อมูล ณ วันที่ ${DateTime.now().day} ${showThaiMonth(DateTime.now().month)} พ.ศ. ${DateTime.now().year + 543}',
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

//******************************************************//

//create class for create description table
class showTableDetail extends DataGridSource {
  late List<DataGridRow> dataGridRow;
  late List<Roomtemp2> dataShow;
  showTableDetail(this.dataShow) {
    buildDataGridRow();
  }

  buildDataGridRow() {
    dataGridRow = dataShow.map<DataGridRow>((dataGridRowItem) {
      return DataGridRow(
        cells: [
          DataGridCell(columnName: 'temp2', value: dataGridRowItem.temp2),
          DataGridCell(columnName: 'datesave', value: dataGridRowItem.datesave),
          DataGridCell(columnName: 'timesave', value: dataGridRowItem.timesave),
        ],
      );
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: effectiveRows.indexOf(row) % 2 == 0 ? Colors.transparent : Colors.red[100],
      cells: [
        Container(
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
        ),
        Container(
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
        ),
        Container(
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }
}
