class PatientModel {
  Vitals? vitals;
  LabReports? labReports;
  MedicalDevice? medicalDevice;
  String? sId;
  Profile? profile;
  String? ongoingTreatment;
  String? treatmentPlan;
  int? walletBalance;
  List<Medications>? medications;
  List<Visits>? visits;
  List<Hospitalization>? hospitalization;
  int? iV;
  List<Orders>? orders;
  List<Issues>? issues;
  List<Doctors>? doctors;

  PatientModel(
      {this.vitals,
        this.labReports,
        this.medicalDevice,
        this.sId,
        this.profile,
        this.ongoingTreatment,
        this.treatmentPlan,
        this.walletBalance,
        this.medications,
        this.visits,
        this.hospitalization,
        this.iV,
        this.orders,
        this.issues,
        this.doctors});

  PatientModel.fromJson(Map<String, dynamic> json) {
    vitals =
    json['Vitals'] != null ? new Vitals.fromJson(json['Vitals']) : null;
    labReports = json['Lab_Reports'] != null
        ? new LabReports.fromJson(json['Lab_Reports'])
        : null;
    medicalDevice = json['Medical_Device'] != null
        ? new MedicalDevice.fromJson(json['Medical_Device'])
        : null;
    sId = json['_id'];
    profile =
    json['Profile'] != null ? new Profile.fromJson(json['Profile']) : null;
    ongoingTreatment = json['Ongoing_Treatment'];
    treatmentPlan = json['Treatment_Plan'];
    walletBalance = json['Wallet_Balance'];
    if (json['Medications'] != null) {
      medications = <Medications>[];
      json['Medications'].forEach((v) {
        medications!.add(new Medications.fromJson(v));
      });
    }
    if (json['Visits'] != null) {
      visits = <Visits>[];
      json['Visits'].forEach((v) {
        visits!.add(new Visits.fromJson(v));
      });
    }
    if (json['Hospitalization'] != null) {
      hospitalization = <Hospitalization>[];
      json['Hospitalization'].forEach((v) {
        hospitalization!.add(new Hospitalization.fromJson(v));
      });
    }
    iV = json['__v'];
    if (json['Orders'] != null) {
      orders = <Orders>[];
      json['Orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    if (json['Issues'] != null) {
      issues = <Issues>[];
      json['Issues'].forEach((v) {
        issues!.add(new Issues.fromJson(v));
      });
    }
    if (json['Doctors'] != null) {
      doctors = <Doctors>[];
      json['Doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vitals != null) {
      data['Vitals'] = this.vitals!.toJson();
    }
    if (this.labReports != null) {
      data['Lab_Reports'] = this.labReports!.toJson();
    }
    if (this.medicalDevice != null) {
      data['Medical_Device'] = this.medicalDevice!.toJson();
    }
    data['_id'] = this.sId;
    if (this.profile != null) {
      data['Profile'] = this.profile!.toJson();
    }
    data['Ongoing_Treatment'] = this.ongoingTreatment;
    data['Treatment_Plan'] = this.treatmentPlan;
    data['Wallet_Balance'] = this.walletBalance;
    if (this.medications != null) {
      data['Medications'] = this.medications!.map((v) => v.toJson()).toList();
    }
    if (this.visits != null) {
      data['Visits'] = this.visits!.map((v) => v.toJson()).toList();
    }
    if (this.hospitalization != null) {
      data['Hospitalization'] =
          this.hospitalization!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    if (this.orders != null) {
      data['Orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.issues != null) {
      data['Issues'] = this.issues!.map((v) => v.toJson()).toList();
    }
    if (this.doctors != null) {
      data['Doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vitals {
  HeartRate? heartRate;
  BloodPressure? bloodPressure;
  HeartRate? oxygen;
  HeartRate? respiratory;
  HeartRate? temperature;
  Haemoglobin? haemoglobin;
  HeartRate? glucose;
  Thyroid? thyroid;

  Vitals(
      {this.heartRate,
        this.bloodPressure,
        this.oxygen,
        this.respiratory,
        this.temperature,
        this.haemoglobin,
        this.glucose,
        this.thyroid});

  Vitals.fromJson(Map<String, dynamic> json) {
    heartRate = json['HeartRate'] != null
        ? new HeartRate.fromJson(json['HeartRate'])
        : null;
    bloodPressure = json['BloodPressure'] != null
        ? new BloodPressure.fromJson(json['BloodPressure'])
        : null;
    oxygen =
    json['Oxygen'] != null ? new HeartRate.fromJson(json['Oxygen']) : null;
    respiratory = json['Respiratory'] != null
        ? new HeartRate.fromJson(json['Respiratory'])
        : null;
    temperature = json['Temperature'] != null
        ? new HeartRate.fromJson(json['Temperature'])
        : null;
    haemoglobin = json['Haemoglobin'] != null
        ? new Haemoglobin.fromJson(json['Haemoglobin'])
        : null;
    glucose = json['Glucose'] != null
        ? new HeartRate.fromJson(json['Glucose'])
        : null;
    thyroid =
    json['Thyroid'] != null ? new Thyroid.fromJson(json['Thyroid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.heartRate != null) {
      data['HeartRate'] = this.heartRate!.toJson();
    }
    if (this.bloodPressure != null) {
      data['BloodPressure'] = this.bloodPressure!.toJson();
    }
    if (this.oxygen != null) {
      data['Oxygen'] = this.oxygen!.toJson();
    }
    if (this.respiratory != null) {
      data['Respiratory'] = this.respiratory!.toJson();
    }
    if (this.temperature != null) {
      data['Temperature'] = this.temperature!.toJson();
    }
    if (this.haemoglobin != null) {
      data['Haemoglobin'] = this.haemoglobin!.toJson();
    }
    if (this.glucose != null) {
      data['Glucose'] = this.glucose!.toJson();
    }
    if (this.thyroid != null) {
      data['Thyroid'] = this.thyroid!.toJson();
    }
    return data;
  }
}

class HeartRate {
  int? avgResult;
  int? latestResult;
  String? status;
  String? sId;

  HeartRate({this.avgResult, this.latestResult, this.status, this.sId});

  HeartRate.fromJson(Map<String, dynamic> json) {
    avgResult = json['Avg_result'];
    latestResult = json['Latest_result'];
    status = json['Status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avg_result'] = this.avgResult;
    data['Latest_result'] = this.latestResult;
    data['Status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class BloodPressure {
  String? avgResult;
  String? latestResult;
  String? status;
  String? sId;

  BloodPressure({this.avgResult, this.latestResult, this.status, this.sId});

  BloodPressure.fromJson(Map<String, dynamic> json) {
    avgResult = json['Avg_result'];
    latestResult = json['Latest_result'];
    status = json['Status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avg_result'] = this.avgResult;
    data['Latest_result'] = this.latestResult;
    data['Status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class Haemoglobin {
  double? avgResult;
  int? latestResult;
  String? status;
  String? sId;

  Haemoglobin({this.avgResult, this.latestResult, this.status, this.sId});

  Haemoglobin.fromJson(Map<String, dynamic> json) {
    avgResult = json['Avg_result'];
    latestResult = json['Latest_result'];
    status = json['Status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avg_result'] = this.avgResult;
    data['Latest_result'] = this.latestResult;
    data['Status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class Thyroid {
  String? status;
  String? sId;

  Thyroid({this.status, this.sId});

  Thyroid.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class LabReports {
  DiagnosticTest? diagnosticTest;
  BloodTests? bloodTests;

  LabReports({this.diagnosticTest, this.bloodTests});

  LabReports.fromJson(Map<String, dynamic> json) {
    diagnosticTest = json['Diagnostic_Test'] != null
        ? new DiagnosticTest.fromJson(json['Diagnostic_Test'])
        : null;
    bloodTests = json['Blood_Tests'] != null
        ? new BloodTests.fromJson(json['Blood_Tests'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diagnosticTest != null) {
      data['Diagnostic_Test'] = this.diagnosticTest!.toJson();
    }
    if (this.bloodTests != null) {
      data['Blood_Tests'] = this.bloodTests!.toJson();
    }
    return data;
  }
}

class DiagnosticTest {
  Covid? covid;
  Dengue? dengue;
  String? sId;

  DiagnosticTest({this.covid, this.dengue, this.sId});

  DiagnosticTest.fromJson(Map<String, dynamic> json) {
    covid = json['Covid'] != null ? new Covid.fromJson(json['Covid']) : null;
    dengue = json['Dengue'] != null ? new Dengue.fromJson(json['Dengue']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.covid != null) {
      data['Covid'] = this.covid!.toJson();
    }
    if (this.dengue != null) {
      data['Dengue'] = this.dengue!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Covid {
  String? fileName;
  String? name;
  String? sId;

  Covid({this.fileName, this.name, this.sId});

  Covid.fromJson(Map<String, dynamic> json) {
    fileName = json['File_Name'];
    name = json['Name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['File_Name'] = this.fileName;
    data['Name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

class Dengue {
  Null? fileName;
  String? name;
  String? sId;

  Dengue({this.fileName, this.name, this.sId});

  Dengue.fromJson(Map<String, dynamic> json) {
    fileName = json['File_Name'];
    name = json['Name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['File_Name'] = this.fileName;
    data['Name'] = this.name;
    data['_id'] = this.sId;
    return data;
  }
}

class BloodTests {
  CBC? cBC;
  BasicMetabolicPanel? basicMetabolicPanel;
  ComprehensiveMetabolicPanel? comprehensiveMetabolicPanel;
  ThyroidPanel? thyroidPanel;
  LipidPanel? lipidPanel;
  String? sId;

  BloodTests(
      {this.cBC,
        this.basicMetabolicPanel,
        this.comprehensiveMetabolicPanel,
        this.thyroidPanel,
        this.lipidPanel,
        this.sId});

  BloodTests.fromJson(Map<String, dynamic> json) {
    cBC = json['CBC'] != null ? new CBC.fromJson(json['CBC']) : null;
    basicMetabolicPanel = json['Basic_Metabolic_Panel'] != null
        ? new BasicMetabolicPanel.fromJson(json['Basic_Metabolic_Panel'])
        : null;
    comprehensiveMetabolicPanel = json['Comprehensive_Metabolic_Panel'] != null
        ? new ComprehensiveMetabolicPanel.fromJson(
        json['Comprehensive_Metabolic_Panel'])
        : null;
    thyroidPanel = json['ThyroidPanel'] != null
        ? new ThyroidPanel.fromJson(json['ThyroidPanel'])
        : null;
    lipidPanel = json['LipidPanel'] != null
        ? new LipidPanel.fromJson(json['LipidPanel'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cBC != null) {
      data['CBC'] = this.cBC!.toJson();
    }
    if (this.basicMetabolicPanel != null) {
      data['Basic_Metabolic_Panel'] = this.basicMetabolicPanel!.toJson();
    }
    if (this.comprehensiveMetabolicPanel != null) {
      data['Comprehensive_Metabolic_Panel'] =
          this.comprehensiveMetabolicPanel!.toJson();
    }
    if (this.thyroidPanel != null) {
      data['ThyroidPanel'] = this.thyroidPanel!.toJson();
    }
    if (this.lipidPanel != null) {
      data['LipidPanel'] = this.lipidPanel!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class CBC {
  int? basos;
  int? eOS;
  Null? fileName;
  double? haematocrit;
  Haemoglobin? haemoglobin;
  int? lymphs;
  double? mCHC;
  int? mCV;
  int? monocytes;
  String? name;
  int? neutrophils;
  int? platelets;
  double? rBC;
  double? rDW;
  double? wBC;
  String? sId;

  CBC(
      {this.basos,
        this.eOS,
        this.fileName,
        this.haematocrit,
        this.haemoglobin,
        this.lymphs,
        this.mCHC,
        this.mCV,
        this.monocytes,
        this.name,
        this.neutrophils,
        this.platelets,
        this.rBC,
        this.rDW,
        this.wBC,
        this.sId});

  CBC.fromJson(Map<String, dynamic> json) {
    basos = json['Basos'];
    eOS = json['EOS'];
    fileName = json['File_Name'];
    haematocrit = json['Haematocrit'];
    haemoglobin = json['Haemoglobin'] != null
        ? new Haemoglobin.fromJson(json['Haemoglobin'])
        : null;
    lymphs = json['Lymphs'];
    mCHC = json['MCHC'];
    mCV = json['MCV'];
    monocytes = json['Monocytes'];
    name = json['Name'];
    neutrophils = json['Neutrophils'];
    platelets = json['Platelets'];
    rBC = json['RBC'];
    rDW = json['RDW'];
    wBC = json['WBC'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Basos'] = this.basos;
    data['EOS'] = this.eOS;
    data['File_Name'] = this.fileName;
    data['Haematocrit'] = this.haematocrit;
    if (this.haemoglobin != null) {
      data['Haemoglobin'] = this.haemoglobin!.toJson();
    }
    data['Lymphs'] = this.lymphs;
    data['MCHC'] = this.mCHC;
    data['MCV'] = this.mCV;
    data['Monocytes'] = this.monocytes;
    data['Name'] = this.name;
    data['Neutrophils'] = this.neutrophils;
    data['Platelets'] = this.platelets;
    data['RBC'] = this.rBC;
    data['RDW'] = this.rDW;
    data['WBC'] = this.wBC;
    data['_id'] = this.sId;
    return data;
  }
}

class BasicMetabolicPanel {
  double? calcium;
  int? carbonDioxide;
  int? chlorine;
  double? creatine;
  Null? fileName;
  HeartRate? glucose;
  String? name;
  double? potassium;
  int? sodium;
  int? ureaNitrogen;
  String? sId;

  BasicMetabolicPanel(
      {this.calcium,
        this.carbonDioxide,
        this.chlorine,
        this.creatine,
        this.fileName,
        this.glucose,
        this.name,
        this.potassium,
        this.sodium,
        this.ureaNitrogen,
        this.sId});

  BasicMetabolicPanel.fromJson(Map<String, dynamic> json) {
    calcium = json['Calcium'];
    carbonDioxide = json['Carbon_Dioxide'];
    chlorine = json['Chlorine'];
    creatine = json['Creatine'];
    fileName = json['File_Name'];
    glucose = json['Glucose'] != null
        ? new HeartRate.fromJson(json['Glucose'])
        : null;
    name = json['Name'];
    potassium = json['Potassium'];
    sodium = json['Sodium'];
    ureaNitrogen = json['UreaNitrogen'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Calcium'] = this.calcium;
    data['Carbon_Dioxide'] = this.carbonDioxide;
    data['Chlorine'] = this.chlorine;
    data['Creatine'] = this.creatine;
    data['File_Name'] = this.fileName;
    if (this.glucose != null) {
      data['Glucose'] = this.glucose!.toJson();
    }
    data['Name'] = this.name;
    data['Potassium'] = this.potassium;
    data['Sodium'] = this.sodium;
    data['UreaNitrogen'] = this.ureaNitrogen;
    data['_id'] = this.sId;
    return data;
  }
}

class ComprehensiveMetabolicPanel {
  double? aGRatio;
  String? aLT;
  String? aST;
  double? albumin;
  String? alkalinePhosphate;
  double? bilirubin;
  double? calcium;
  int? carbonDioxide;
  int? chlorine;
  double? creatine;
  Null? fileName;
  double? globulin;
  String? name;
  double? potassium;
  double? protein;
  int? sodium;
  HeartRate? ureaNitrogen;
  String? sId;

  ComprehensiveMetabolicPanel(
      {this.aGRatio,
        this.aLT,
        this.aST,
        this.albumin,
        this.alkalinePhosphate,
        this.bilirubin,
        this.calcium,
        this.carbonDioxide,
        this.chlorine,
        this.creatine,
        this.fileName,
        this.globulin,
        this.name,
        this.potassium,
        this.protein,
        this.sodium,
        this.ureaNitrogen,
        this.sId});

  ComprehensiveMetabolicPanel.fromJson(Map<String, dynamic> json) {
    aGRatio = json['AG_Ratio'];
    aLT = json['ALT'];
    aST = json['AST'];
    albumin = json['Albumin'];
    alkalinePhosphate = json['AlkalinePhosphate'];
    bilirubin = json['Bilirubin'];
    calcium = json['Calcium'];
    carbonDioxide = json['Carbon_Dioxide'];
    chlorine = json['Chlorine'];
    creatine = json['Creatine'];
    fileName = json['File_Name'];
    globulin = json['Globulin'];
    name = json['Name'];
    potassium = json['Potassium'];
    protein = json['Protein'];
    sodium = json['Sodium'];
    ureaNitrogen = json['UreaNitrogen'] != null
        ? new HeartRate.fromJson(json['UreaNitrogen'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AG_Ratio'] = this.aGRatio;
    data['ALT'] = this.aLT;
    data['AST'] = this.aST;
    data['Albumin'] = this.albumin;
    data['AlkalinePhosphate'] = this.alkalinePhosphate;
    data['Bilirubin'] = this.bilirubin;
    data['Calcium'] = this.calcium;
    data['Carbon_Dioxide'] = this.carbonDioxide;
    data['Chlorine'] = this.chlorine;
    data['Creatine'] = this.creatine;
    data['File_Name'] = this.fileName;
    data['Globulin'] = this.globulin;
    data['Name'] = this.name;
    data['Potassium'] = this.potassium;
    data['Protein'] = this.protein;
    data['Sodium'] = this.sodium;
    if (this.ureaNitrogen != null) {
      data['UreaNitrogen'] = this.ureaNitrogen!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class ThyroidPanel {
  Null? fileName;
  double? freeThyroxineIndex;
  String? name;
  int? t3Uptake;
  double? tSH;
  Thyroxine? thyroxine;
  double? thyroxineT4FreeDirect;
  double? triiodothyronineFreeSerum;
  String? sId;

  ThyroidPanel(
      {this.fileName,
        this.freeThyroxineIndex,
        this.name,
        this.t3Uptake,
        this.tSH,
        this.thyroxine,
        this.thyroxineT4FreeDirect,
        this.triiodothyronineFreeSerum,
        this.sId});

  ThyroidPanel.fromJson(Map<String, dynamic> json) {
    fileName = json['File_Name'];
    freeThyroxineIndex = json['FreeThyroxineIndex'];
    name = json['Name'];
    t3Uptake = json['T3Uptake'];
    tSH = json['TSH'];
    thyroxine = json['Thyroxine'] != null
        ? new Thyroxine.fromJson(json['Thyroxine'])
        : null;
    thyroxineT4FreeDirect = json['ThyroxineT4FreeDirect'];
    triiodothyronineFreeSerum = json['TriiodothyronineFreeSerum'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['File_Name'] = this.fileName;
    data['FreeThyroxineIndex'] = this.freeThyroxineIndex;
    data['Name'] = this.name;
    data['T3Uptake'] = this.t3Uptake;
    data['TSH'] = this.tSH;
    if (this.thyroxine != null) {
      data['Thyroxine'] = this.thyroxine!.toJson();
    }
    data['ThyroxineT4FreeDirect'] = this.thyroxineT4FreeDirect;
    data['TriiodothyronineFreeSerum'] = this.triiodothyronineFreeSerum;
    data['_id'] = this.sId;
    return data;
  }
}

class Thyroxine {
  double? avgResult;
  double? latestResult;
  String? status;
  String? sId;

  Thyroxine({this.avgResult, this.latestResult, this.status, this.sId});

  Thyroxine.fromJson(Map<String, dynamic> json) {
    avgResult = json['Avg_result'];
    latestResult = json['Latest_result'];
    status = json['Status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avg_result'] = this.avgResult;
    data['Latest_result'] = this.latestResult;
    data['Status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class LipidPanel {
  Null? fileName;
  int? hDLCholesterol;
  int? lDLCholesterol;
  int? lDLHDLRatio;
  String? name;
  int? totalCHOLHDL;
  HeartRate? totalCholesterol;
  int? triglycerides;
  String? sId;

  LipidPanel(
      {this.fileName,
        this.hDLCholesterol,
        this.lDLCholesterol,
        this.lDLHDLRatio,
        this.name,
        this.totalCHOLHDL,
        this.totalCholesterol,
        this.triglycerides,
        this.sId});

  LipidPanel.fromJson(Map<String, dynamic> json) {
    fileName = json['File_Name'];
    hDLCholesterol = json['HDLCholesterol'];
    lDLCholesterol = json['LDLCholesterol'];
    lDLHDLRatio = json['LDLHDLRatio'];
    name = json['Name'];
    totalCHOLHDL = json['TotalCHOLHDL'];
    totalCholesterol = json['TotalCholesterol'] != null
        ? new HeartRate.fromJson(json['TotalCholesterol'])
        : null;
    triglycerides = json['Triglycerides'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['File_Name'] = this.fileName;
    data['HDLCholesterol'] = this.hDLCholesterol;
    data['LDLCholesterol'] = this.lDLCholesterol;
    data['LDLHDLRatio'] = this.lDLHDLRatio;
    data['Name'] = this.name;
    data['TotalCHOLHDL'] = this.totalCHOLHDL;
    if (this.totalCholesterol != null) {
      data['TotalCholesterol'] = this.totalCholesterol!.toJson();
    }
    data['Triglycerides'] = this.triglycerides;
    data['_id'] = this.sId;
    return data;
  }
}

class MedicalDevice {
  Fitbit? fitbit;
  Glucometer? glucometer;

  MedicalDevice({this.fitbit, this.glucometer});

  MedicalDevice.fromJson(Map<String, dynamic> json) {
    fitbit =
    json['Fitbit'] != null ? new Fitbit.fromJson(json['Fitbit']) : null;
    glucometer = json['Glucometer'] != null
        ? new Glucometer.fromJson(json['Glucometer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fitbit != null) {
      data['Fitbit'] = this.fitbit!.toJson();
    }
    if (this.glucometer != null) {
      data['Glucometer'] = this.glucometer!.toJson();
    }
    return data;
  }
}

class Fitbit {
  int? calories;
  String? cardio;
  String? distance;
  String? fatBurn;
  int? numberofSteps;
  String? peak;
  String? sId;

  Fitbit(
      {this.calories,
        this.cardio,
        this.distance,
        this.fatBurn,
        this.numberofSteps,
        this.peak,
        this.sId});

  Fitbit.fromJson(Map<String, dynamic> json) {
    calories = json['Calories'];
    cardio = json['Cardio'];
    distance = json['Distance'];
    fatBurn = json['FatBurn'];
    numberofSteps = json['NumberofSteps'];
    peak = json['Peak'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Calories'] = this.calories;
    data['Cardio'] = this.cardio;
    data['Distance'] = this.distance;
    data['FatBurn'] = this.fatBurn;
    data['NumberofSteps'] = this.numberofSteps;
    data['Peak'] = this.peak;
    data['_id'] = this.sId;
    return data;
  }
}

class Glucometer {
  int? avgResult;
  int? latestResult;
  String? sId;

  Glucometer({this.avgResult, this.latestResult, this.sId});

  Glucometer.fromJson(Map<String, dynamic> json) {
    avgResult = json['Avg_result'];
    latestResult = json['Latest_result'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Avg_result'] = this.avgResult;
    data['Latest_result'] = this.latestResult;
    data['_id'] = this.sId;
    return data;
  }
}

class Profile {
  Personal? personal;
  String? sId;
  Medical? medical;
  Lifestyle? lifestyle;

  Profile({this.personal, this.sId, this.medical, this.lifestyle});

  Profile.fromJson(Map<String, dynamic> json) {
    personal = json['Personal'] != null
        ? new Personal.fromJson(json['Personal'])
        : null;
    sId = json['_id'];
    medical =
    json['Medical'] != null ? new Medical.fromJson(json['Medical']) : null;
    lifestyle = json['Lifestyle'] != null
        ? new Lifestyle.fromJson(json['Lifestyle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personal != null) {
      data['Personal'] = this.personal!.toJson();
    }
    data['_id'] = this.sId;
    if (this.medical != null) {
      data['Medical'] = this.medical!.toJson();
    }
    if (this.lifestyle != null) {
      data['Lifestyle'] = this.lifestyle!.toJson();
    }
    return data;
  }
}

class Personal {
  String? name;
  String? contactNumber;
  String? emailId;
  String? password;
  String? maritialStatus;
  String? sId;
  String? bloodgroup;
  String? dateofBirth;
  String? gender;
  String? height;
  String? weight;
  String? address;
  String? emergencyContact;

  Personal(
      {this.name,
        this.contactNumber,
        this.emailId,
        this.password,
        this.maritialStatus,
        this.sId,
        this.bloodgroup,
        this.dateofBirth,
        this.gender,
        this.height,
        this.weight,
        this.address,
        this.emergencyContact});

  Personal.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    contactNumber = json['Contact_Number'];
    emailId = json['Email_id'];
    password = json['Password'];
    maritialStatus = json['Maritial_Status'];
    sId = json['_id'];
    bloodgroup = json['Bloodgroup'];
    dateofBirth = json['DateofBirth'];
    gender = json['Gender'];
    height = json['Height'];
    weight = json['Weight'];
    address = json['Address'];
    emergencyContact = json['Emergency_contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Contact_Number'] = this.contactNumber;
    data['Email_id'] = this.emailId;
    data['Password'] = this.password;
    data['Maritial_Status'] = this.maritialStatus;
    data['_id'] = this.sId;
    data['Bloodgroup'] = this.bloodgroup;
    data['DateofBirth'] = this.dateofBirth;
    data['Gender'] = this.gender;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['Address'] = this.address;
    data['Emergency_contact'] = this.emergencyContact;
    return data;
  }
}

class Medical {
  String? allergies;
  String? blindcondition;
  Null? chronicDiseases;
  String? currectMedications;
  Null? injuries;
  Null? surgeries;
  String? vaccination;
  String? sId;

  Medical(
      {this.allergies,
        this.blindcondition,
        this.chronicDiseases,
        this.currectMedications,
        this.injuries,
        this.surgeries,
        this.vaccination,
        this.sId});

  Medical.fromJson(Map<String, dynamic> json) {
    allergies = json['Allergies'];
    blindcondition = json['Blindcondition'];
    chronicDiseases = json['Chronic_Diseases'];
    currectMedications = json['Currect_Medications'];
    injuries = json['Injuries'];
    surgeries = json['Surgeries'];
    vaccination = json['Vaccination'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Allergies'] = this.allergies;
    data['Blindcondition'] = this.blindcondition;
    data['Chronic_Diseases'] = this.chronicDiseases;
    data['Currect_Medications'] = this.currectMedications;
    data['Injuries'] = this.injuries;
    data['Surgeries'] = this.surgeries;
    data['Vaccination'] = this.vaccination;
    data['_id'] = this.sId;
    return data;
  }
}

class Lifestyle {
  String? alcohol;
  String? foodPreference;
  String? smoking;
  String? activity;
  String? sId;

  Lifestyle(
      {this.alcohol,
        this.foodPreference,
        this.smoking,
        this.activity,
        this.sId});

  Lifestyle.fromJson(Map<String, dynamic> json) {
    alcohol = json['Alcohol'];
    foodPreference = json['Food_Preference'];
    smoking = json['Smoking'];
    activity = json['Activity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Alcohol'] = this.alcohol;
    data['Food_Preference'] = this.foodPreference;
    data['Smoking'] = this.smoking;
    data['Activity'] = this.activity;
    data['_id'] = this.sId;
    return data;
  }
}

class Medications {
  String? name;
  String? startDate;
  String? endDate;
  MealPlan? mealPlan;
  String? sId;

  Medications(
      {this.name, this.startDate, this.endDate, this.mealPlan, this.sId});

  Medications.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    startDate = json['Start_Date'];
    endDate = json['End_Date'];
    mealPlan = json['Meal_Plan'] != null
        ? new MealPlan.fromJson(json['Meal_Plan'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Start_Date'] = this.startDate;
    data['End_Date'] = this.endDate;
    if (this.mealPlan != null) {
      data['Meal_Plan'] = this.mealPlan!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class MealPlan {
  String? dose1;
  String? dose2;
  String? sId;
  String? dose3;

  MealPlan({this.dose1, this.dose2, this.sId, this.dose3});

  MealPlan.fromJson(Map<String, dynamic> json) {
    dose1 = json['Dose1'];
    dose2 = json['Dose2'];
    sId = json['_id'];
    dose3 = json['Dose3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Dose1'] = this.dose1;
    data['Dose2'] = this.dose2;
    data['_id'] = this.sId;
    data['Dose3'] = this.dose3;
    return data;
  }
}

class Visits {
  String? year;
  String? date;
  String? issue;
  String? doctor;
  String? post;
  String? sId;

  Visits({this.year, this.date, this.issue, this.doctor, this.post, this.sId});

  Visits.fromJson(Map<String, dynamic> json) {
    year = json['Year'];
    date = json['Date'];
    issue = json['Issue'];
    doctor = json['Doctor'];
    post = json['Post'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Year'] = this.year;
    data['Date'] = this.date;
    data['Issue'] = this.issue;
    data['Doctor'] = this.doctor;
    data['Post'] = this.post;
    data['_id'] = this.sId;
    return data;
  }
}

class Hospitalization {
  String? year;
  String? date;
  String? reason;
  String? doctor;
  String? sId;

  Hospitalization({this.year, this.date, this.reason, this.doctor, this.sId});

  Hospitalization.fromJson(Map<String, dynamic> json) {
    year = json['Year'];
    date = json['Date'];
    reason = json['Reason'];
    doctor = json['Doctor'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Year'] = this.year;
    data['Date'] = this.date;
    data['Reason'] = this.reason;
    data['Doctor'] = this.doctor;
    data['_id'] = this.sId;
    return data;
  }
}

class Orders {
  String? orderID;
  String? date;
  String? time;
  String? sId;

  Orders({this.orderID, this.date, this.time, this.sId});

  Orders.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    date = json['Date'];
    time = json['Time'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderID'] = this.orderID;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['_id'] = this.sId;
    return data;
  }
}

class Issues {
  String? status;
  String? info;
  String? date;
  String? time;
  String? docName;
  String? hospital;
  String? problem;
  String? treatmentPlan;
  String? diagnosis;
  String? followup;
  Recovery? recovery;
  String? sId;

  Issues(
      {this.status,
        this.info,
        this.date,
        this.time,
        this.docName,
        this.hospital,
        this.problem,
        this.treatmentPlan,
        this.diagnosis,
        this.followup,
        this.recovery,
        this.sId});

  Issues.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    info = json['Info'];
    date = json['Date'];
    time = json['Time'];
    docName = json['Doc_Name'];
    hospital = json['Hospital'];
    problem = json['Problem'];
    treatmentPlan = json['Treatment_Plan'];
    diagnosis = json['Diagnosis'];
    followup = json['Followup'];
    recovery = json['Recovery'] != null
        ? new Recovery.fromJson(json['Recovery'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Info'] = this.info;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Doc_Name'] = this.docName;
    data['Hospital'] = this.hospital;
    data['Problem'] = this.problem;
    data['Treatment_Plan'] = this.treatmentPlan;
    data['Diagnosis'] = this.diagnosis;
    data['Followup'] = this.followup;
    if (this.recovery != null) {
      data['Recovery'] = this.recovery!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Recovery {
  String? expected;
  String? actual;
  String? sId;

  Recovery({this.expected, this.actual, this.sId});

  Recovery.fromJson(Map<String, dynamic> json) {
    expected = json['Expected'];
    actual = json['Actual'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Expected'] = this.expected;
    data['Actual'] = this.actual;
    data['_id'] = this.sId;
    return data;
  }
}

class Doctors {
  String? name;
  String? degree;
  String? specs;
  String? hospital;
  String? photoUrl;
  String? sId;

  Doctors(
      {this.name,
        this.degree,
        this.specs,
        this.hospital,
        this.photoUrl,
        this.sId});

  Doctors.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    degree = json['Degree'];
    specs = json['Specs'];
    hospital = json['Hospital'];
    photoUrl = json['PhotoUrl'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Degree'] = this.degree;
    data['Specs'] = this.specs;
    data['Hospital'] = this.hospital;
    data['PhotoUrl'] = this.photoUrl;
    data['_id'] = this.sId;
    return data;
  }
}
