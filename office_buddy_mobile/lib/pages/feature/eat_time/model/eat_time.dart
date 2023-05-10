
import 'dart:collection';

class EatTimeModel {

  EatTimeModel({
    required this.id,
    required this.time,
    required this.motherFeeding,
    required this.breastMilk,
    required this.powderedMilk,
    required this.managementId,
  });

  int id;
  String time;
  int motherFeeding;
  int breastMilk;
  int powderedMilk;
  int managementId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = HashMap();
    json["id"] = id;
    json["time"] = time;
    json["motherFeeding"] = motherFeeding;
    json["breastMilk"] = breastMilk;
    json["powderedMilk"] = powderedMilk;
    json["managementId"] = managementId;
    return json;
  }

  factory EatTimeModel.fromJson(Map<String, dynamic> json) => EatTimeModel(
    id: json["id"] as int,
    time: json["time"] as String,
    motherFeeding: json["motherFeeding"] as int,
    breastMilk: json["breastMilk"] as int,
    powderedMilk: json["powderedMilk"] as int,
    managementId: json["managementId"] as int,
  );
}
