import 'package:equatable/equatable.dart';

import 'package:forwarder/app/utils/nullify.dart';

class Income extends Equatable {
  final int id;
  final double summ;
  final DateTime ddate;

  const Income({
    required this.id,
    required this.summ,
    required this.ddate,
  });

  @override
  List<Object> get props => [
    id,
    summ,
    ddate,
  ];

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      ddate: Nullify.parseDate(json['ddate'])!,
      summ: Nullify.parseDouble(json['summ'])!
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ddate': ddate.toIso8601String(),
      'summ': summ
    };
  }

  @override
  String toString() => 'Income { id: $id }';
}
