part of 'entities.dart';

class ApiBuyerDeliveryMarksData extends Equatable {
  final List<ApiBuyerDeliveryMark> buyerDeliveryMarks;

  const ApiBuyerDeliveryMarksData({
    required this.buyerDeliveryMarks
  });

  factory ApiBuyerDeliveryMarksData.fromJson(Map<String, dynamic> json) {
    List<ApiBuyerDeliveryMark> buyerDeliveryMarks = json['buyer_delivery_marks']
      .map<ApiBuyerDeliveryMark>((e) => ApiBuyerDeliveryMark.fromJson(e)).toList();

    return ApiBuyerDeliveryMarksData(buyerDeliveryMarks: buyerDeliveryMarks);
  }

  @override
  List<Object?> get props => [
    buyerDeliveryMarks
  ];
}
