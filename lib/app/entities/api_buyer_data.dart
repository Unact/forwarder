part of 'entities.dart';

class ApiBuyerData extends Equatable {
  final ApiBuyer buyer;

  const ApiBuyerData({
    required this.buyer
  });

  factory ApiBuyerData.fromJson(Map<String, dynamic> json) {
    ApiBuyer buyer = ApiBuyer.fromJson(json['buyer']);

    return ApiBuyerData(buyer: buyer);
  }

  @override
  List<Object?> get props => [
    buyer
  ];
}
