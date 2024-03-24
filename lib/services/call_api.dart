//เป็น Class ที่ประกอบไปด้วย Method ที่จะใช้ติดต่อกับ Server for call api.
// ignore_for_file: void_checks, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'package:http/retry.dart';
import 'package:iot_test_project/models/roomtemp.dart';
import 'package:iot_test_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:iot_test_project/utils/host.dart';

class CallApi {
  //Method add User data
  static Future insertUser(User user) async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.post(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/user/insert_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      throw Exception('Fail......');
    }
  }

  static Future updateUser(User user) async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.post(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/user/update_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      throw Exception('Fail......');
    }
  }

  //Method Login
  static Future checkLogin(User user) async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.post(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/user/check_login_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      final data = User.fromJson(responseData);
      return data;
    } else {
      throw Exception('Fail......');
    }
  }

  //Method getAllRoomTemp
  static Future<List<Roomtemp>> getAllRoomTemp() async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.get(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/roomtemp/get_all_roomtemp_api.php"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      List<Roomtemp> data = await responseData.map<Roomtemp>((json) => Roomtemp.fromJson(json)).toList();
      return data;
    } else {
      throw Exception('Fail......');
    }
  }

  //Method getRoomTemp1
  static Future<List<Roomtemp1>> getRoomTemp1() async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.get(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/roomtemp/get_roomtemp1_api.php"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      List<Roomtemp1> data = await responseData.map<Roomtemp1>((json) => Roomtemp1.fromJson(json)).toList();
      return data;
    } else {
      throw Exception('Fail......');
    }
  }

  //Method getRoomTemp2
  static Future<List<Roomtemp2>> getRoomTemp2() async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.get(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/roomtemp/get_roomtemp2_api.php"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      List<Roomtemp2> data = await responseData.map<Roomtemp2>((json) => Roomtemp2.fromJson(json)).toList();
      return data;
    } else {
      throw Exception('Fail......');
    }
  }

  //Method getRoomTemp3
  static Future<List<Roomtemp3>> getRoomTemp3() async {
    //คำสั่งเรียกใช้ api ที่ Server
    final response = await http.get(
      Uri.parse(Host.hostURL + "/iotsau01api/apis/roomtemp/get_roomtemp3_api.php"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      List<Roomtemp3> data = await responseData.map<Roomtemp3>((json) => Roomtemp3.fromJson(json)).toList();
      return data;
    } else {
      throw Exception('Fail......');
    }
  }
}
