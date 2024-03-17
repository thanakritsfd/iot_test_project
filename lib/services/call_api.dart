//เป็น Class ที่ประกอบไปด้วย Method ที่จะใช้ติดต่อกับ Server for call api.
// ignore_for_file: void_checks, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'package:iot_test_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:iot_test_project/utils/host.dart';

class CallApi{
  //Method add User data
 static Future insertUser(User user) async{
    //คำสั่งเรียกใช้ api ที่ Server
     final response = await http.post(
      Uri.parse(Host.hostURL+"/iotsau01api/apis/user/insert_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type':'application/json'},
     );

     if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      return responseData['message'];
     }else{
      throw Exception('Fail......');
     }
  }

   static Future updateUser(User user) async{
    //คำสั่งเรียกใช้ api ที่ Server
     final response = await http.post(
      Uri.parse(Host.hostURL+"/iotsau01api/apis/user/update_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type':'application/json'},
     );

     if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      return responseData['message'];
     }else{
      throw Exception('Fail......');
     }
  }

  //Method Login
   static Future checkLogin(User user) async{
    //คำสั่งเรียกใช้ api ที่ Server
     final response = await http.post(
      Uri.parse(Host.hostURL+"/iotsau01api/apis/user/check_login_user_api.php"),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type':'application/json'},
     );

     if(response.statusCode == 200){
      final responseData = jsonDecode(response.body);

      //แปลงข้แมูลที่มาเป็น json เป็นข้อมูลที่เอาไปใช้ใน app
      final data =  User.fromJson(responseData);
      return data;
     }else{
      throw Exception('Fail......');
     }
  }

}