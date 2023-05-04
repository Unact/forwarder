part of 'entities.dart';

class ApiIncome extends Equatable {
  final int id;
  final double summ;
  final DateTime ddate;

  const ApiIncome({
    required this.id,
    required this.summ,
    required this.ddate,
  });

  factory ApiIncome.fromJson(dynamic json) {
    return ApiIncome(
      id: json['id'],
      ddate: Parsing.parseDate(json['ddate'])!,
      summ: Parsing.parseDouble(json['summ'])!
    );
  }

  Income toDatabaseEnt() {
    return Income(
      id: id,
      summ: summ,
      ddate: ddate
    );
  }

  @override
  List<Object> get props => [
    id,
    summ,
    ddate,
  ];
}
