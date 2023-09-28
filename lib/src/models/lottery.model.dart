import 'package:cloud_firestore/cloud_firestore.dart';

class Lottery{
  final Timestamp lotteryBoughtOn;
  final String lotteryNumber;

  Lottery({
    required this.lotteryNumber,
    required this.lotteryBoughtOn,
  });


  factory Lottery.fromJson(Map<String, dynamic> json) {
    return Lottery(
      lotteryNumber: json['lotteryNumber'],
      lotteryBoughtOn: json['lotteryBoughtOn'],
    );
  }

  Map<String, dynamic> toJson() => {
    'lotteryNumber': lotteryNumber,
    'lotteryBoughtOn': lotteryBoughtOn,
  };

  @override
  String toString() {
    return 'Lottery(lotteryNumber: $lotteryNumber, lotteryBoughtOn: $lotteryBoughtOn)';
  }
}