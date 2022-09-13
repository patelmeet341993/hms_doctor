import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/parsing_helper.dart';

class VisitBillingModel {
  String doctorId = "", doctorName = "", paymentId = "", paymentMode = "";
  double fee = 0, discount = 0, totalFees = 0;
  Timestamp? createdTime;

  VisitBillingModel({
    this.doctorId = "",
    this.doctorName = "",
    this.paymentId = "",
    this.paymentMode = "",
    this.fee = 0,
    this.discount = 0,
    this.totalFees = 0,
    this.createdTime,
  });

  VisitBillingModel.fromMap(Map<String, dynamic> map) {
    doctorId = ParsingHelper.parseStringMethod(map['doctorId']);
    doctorName = ParsingHelper.parseStringMethod(map['doctorName']);
    paymentId = ParsingHelper.parseStringMethod(map['paymentId']);
    paymentMode = ParsingHelper.parseStringMethod(map['paymentMode']);
    fee = ParsingHelper.parseDoubleMethod(map['fee']);
    discount = ParsingHelper.parseDoubleMethod(map['discount']);
    totalFees = ParsingHelper.parseDoubleMethod(map['totalFees']);
    createdTime = ParsingHelper.parseTimestampMethod(map['createdTime']);
  }

  void updateFromMap(Map<String, dynamic> map) {
    doctorId = ParsingHelper.parseStringMethod(map['doctorId']);
    doctorName = ParsingHelper.parseStringMethod(map['doctorName']);
    paymentId = ParsingHelper.parseStringMethod(map['paymentId']);
    paymentMode = ParsingHelper.parseStringMethod(map['paymentMode']);
    fee = ParsingHelper.parseDoubleMethod(map['fee']);
    discount = ParsingHelper.parseDoubleMethod(map['discount']);
    totalFees = ParsingHelper.parseDoubleMethod(map['totalFees']);
    createdTime = ParsingHelper.parseTimestampMethod(map['createdTime']);
  }

  Map<String, dynamic> toMap({bool json = false}) {
    return <String, dynamic>{
      "doctorId" : doctorId,
      "doctorName" : doctorName,
      "paymentId" : paymentId,
      "paymentMode" : paymentMode,
      "fee" : fee,
      "discount" : discount,
      "totalFees" : totalFees,
      "createdTime" : json ? createdTime?.toDate().toIso8601String() : createdTime,
    };
  }

  @override
  String toString({bool json = false}) {
    return toMap(json: json).toString();
  }
}