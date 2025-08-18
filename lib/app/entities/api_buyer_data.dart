part of 'entities.dart';

class ApiBuyerData extends Equatable {
  final ApiBuyer buyer;
  final List<ApiBuyerDeliveryMark> buyerDeliveryMarks;

  const ApiBuyerData({
    required this.buyer,
    required this.buyerDeliveryMarks
  });

  factory ApiBuyerData.fromJson(Map<String, dynamic> json) {
    ApiBuyer buyer = ApiBuyer.fromJson(json['buyer']);
    List<ApiBuyerDeliveryMark> buyerDeliveryMarks = json['buyer_delivery_marks']
      .map<ApiBuyerDeliveryMark>((e) => ApiBuyerDeliveryMark.fromJson(e)).toList();

    return ApiBuyerData(buyer: buyer, buyerDeliveryMarks: buyerDeliveryMarks);
  }

  @override
  List<Object?> get props => [
    buyer,
    buyerDeliveryMarks
  ];
}
