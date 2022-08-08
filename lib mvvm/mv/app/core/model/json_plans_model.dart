import 'package:builderworkoutplanner/models/exercise_model.dart';

class JsonPlansModel {
  List<Plans>? plans;

  JsonPlansModel({this.plans});

  JsonPlansModel.fromJson(Map<String, dynamic> json) {
    if (json['Plans'] != null) {
      plans = <Plans>[];
      json['Plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['Plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? name;
  var splits;

  Plans({this.name, this.splits});

  Plans.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    if (json['Splits'] != null) {
      splits = <Splits>[];
      json['Splits'].forEach((v) {
        splits!.add(new Splits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    if (this.splits != null) {
      data['Splits'] = this.splits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Splits {
  String? name;
  String? imgUrl;
  List<Company>? exrcs;

  Splits({this.name, this.imgUrl, this.exrcs});

  Splits.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    imgUrl = json['img_url'];
    exrcs = json['exrcs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['img_url'] = this.imgUrl;
    data['exrcs'] = this.exrcs;
    return data;
  }
}
