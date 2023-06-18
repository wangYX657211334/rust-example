
import 'dart:collection';

class EatTimeModel {

  EatTimeModel({
    required this.id,
    required this.time,
    required this.motherFeeding,
    required this.breastMilk,
    required this.powderedMilk,
    required this.note,
  });

  String id;
  String time;
  bool motherFeeding;
  int breastMilk;
  int powderedMilk;
  String note;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = HashMap();
    json["id"] = id;
    json["time"] = time;
    json["mother_feeding"] = motherFeeding;
    json["breast_milk"] = breastMilk;
    json["powdered_milk"] = powderedMilk;
    return json;
  }

  factory EatTimeModel.fromJson(Map<String, dynamic> json) => EatTimeModel(
    id: json["id"] as String,
    time: (json["time"] as String).substring(0, 19),
    motherFeeding: json["mother_feeding"] as bool,
    breastMilk: json["breast_milk"] as int,
    powderedMilk: json["powdered_milk"] as int,
    note: json["note"] as String
  );

}
