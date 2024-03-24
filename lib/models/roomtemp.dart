// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class Roomtemp {
  int? roomtempId;
  double? temp1;
  double? temp2;
  double? temp3;
  String? datesave;
  String? timesave;

  Roomtemp({this.roomtempId, this.temp1, this.temp2, this.temp3, this.datesave, this.timesave});

  Roomtemp.fromJson(Map<String, dynamic> json) {
    roomtempId = int.parse(json['roomtempId']);
    temp1 = double.parse(json['temp1']);
    temp2 = double.parse(json['temp2']);
    temp3 = double.parse(json['temp3']);
    datesave = json['datesave'];
    timesave = json['timesave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomtempId'] = this.roomtempId;
    data['temp1'] = this.temp1;
    data['temp2'] = this.temp2;
    data['temp3'] = this.temp3;
    data['datesave'] = this.datesave;
    data['timesave'] = this.timesave;
    return data;
  }
}

class Roomtemp1 {
  int? roomtempId;
  double? temp1;
  String? datesave;
  String? timesave;

  Roomtemp1({this.roomtempId, this.temp1, this.datesave, this.timesave});

  Roomtemp1.fromJson(Map<String, dynamic> json) {
    roomtempId = int.parse(json['roomtempId']);
    temp1 = double.parse(json['temp1']);
    datesave = json['datesave'];
    timesave = json['timesave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomtempId'] = this.roomtempId;
    data['temp1'] = this.temp1;
    data['datesave'] = this.datesave;
    data['timesave'] = this.timesave;
    return data;
  }
}

class Roomtemp2 {
  int? roomtempId;
  double? temp2;
  String? datesave;
  String? timesave;

  Roomtemp2({this.roomtempId, this.temp2, this.datesave, this.timesave});

  Roomtemp2.fromJson(Map<String, dynamic> json) {
    roomtempId = int.parse(json['roomtempId']);
    temp2 = double.parse(json['temp2']);
    datesave = json['datesave'];
    timesave = json['timesave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomtempId'] = this.roomtempId;
    data['temp2'] = this.temp2;
    data['datesave'] = this.datesave;
    data['timesave'] = this.timesave;
    return data;
  }
}

class Roomtemp3 {
  int? roomtempId;
  double? temp3;
  String? datesave;
  String? timesave;

  Roomtemp3({this.roomtempId, this.temp3, this.datesave, this.timesave});

  Roomtemp3.fromJson(Map<String, dynamic> json) {
    roomtempId = int.parse(json['roomtempId']);
    temp3 = double.parse(json['temp3']);
    datesave = json['datesave'];
    timesave = json['timesave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomtempId'] = this.roomtempId;
    data['temp3'] = this.temp3;
    data['datesave'] = this.datesave;
    data['timesave'] = this.timesave;
    return data;
  }
}
