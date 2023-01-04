class MedicalItem {
  String? sId;
  String? itemID;
  String? medName;
  String? manufacture;
  String? contains;
  String? description;
  List<Substitutes>? substitutes;
  String? sideEffects;
  String? uses;
  String? concerns;
  String? warnings;
  int? iV;

  MedicalItem(
      {this.sId,
        this.itemID,
        this.medName,
        this.manufacture,
        this.contains,
        this.description,
        this.substitutes,
        this.sideEffects,
        this.uses,
        this.concerns,
        this.warnings,
        this.iV});

  MedicalItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    itemID = json['ItemID'];
    medName = json['MedName'];
    manufacture = json['Manufacture'];
    contains = json['Contains'];
    description = json['Description'];
    if (json['Substitutes'] != null) {
      substitutes = <Substitutes>[];
      json['Substitutes'].forEach((v) {
        substitutes!.add(new Substitutes.fromJson(v));
      });
    }
    sideEffects = json['SideEffects'];
    uses = json['Uses'];
    concerns = json['Concerns'];
    warnings = json['Warnings'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ItemID'] = this.itemID;
    data['MedName'] = this.medName;
    data['Manufacture'] = this.manufacture;
    data['Contains'] = this.contains;
    data['Description'] = this.description;
    if (this.substitutes != null) {
      data['Substitutes'] = this.substitutes!.map((v) => v.toJson()).toList();
    }
    data['SideEffects'] = this.sideEffects;
    data['Uses'] = this.uses;
    data['Concerns'] = this.concerns;
    data['Warnings'] = this.warnings;
    data['__v'] = this.iV;
    return data;
  }
}

class Substitutes {
  String? subMedName;
  String? sId;
  Substitutes({this.subMedName, this.sId});
  Substitutes.fromJson(Map<String, dynamic> json) {
    subMedName = json['SubMedName'];
    sId = json['_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubMedName'] = this.subMedName;
    data['_id'] = this.sId;
    return data;
  }
}
