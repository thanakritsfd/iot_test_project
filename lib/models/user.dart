// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class User {
  String? message;
  String? userId;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userAge;

  User(
      {this.message,
      this.userId,
      this.userFullname,
      this.userName,
      this.userPassword,
      this.userAge});

// Json จาก (Server) มาใช้ใน APP
  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userAge = json['userAge'];
  }

//จากข้อมูลใน APP Convert to json and send to server
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['userFullname'] = this.userFullname;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userAge'] = this.userAge;
    return data;
  }
}