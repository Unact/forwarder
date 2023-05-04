part of 'entities.dart';

class ApiRecept extends Equatable {
  final int id;
  final double summ;
  final DateTime ddate;

  const ApiRecept({
    required this.id,
    required this.summ,
    required this.ddate,
  });

  factory ApiRecept.fromJson(Map<String, dynamic> json) {
    return ApiRecept(
      id: json['id'],
      ddate: Parsing.parseDate(json['ddate'])!,
      summ: Parsing.parseDouble(json['summ'])!
    );
  }

  Recept toDatabaseEnt() {
    return Recept(
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
