class DaysModel {
  DaysModel({
    this.month,
    this.year,
    this.day,
  });

  DaysModel.fromJson(dynamic json) {
    month = json['month'];
    year = json['year'];
    if (json['days'] != null) {
      day = [];
      json['days'].forEach((v) {
        day?.add(DayModel.fromJson(v));
      });
    }
  }

  String? month;
  num? year;
  List<DayModel>? day;

  DaysModel copyWith({
    String? month,
    num? year,
    List<DayModel>? day,
  }) =>
      DaysModel(
        month: month ?? this.month,
        year: year ?? this.year,
        day: day ?? this.day,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['month'] = month;
    map['year'] = year;
    if (day != null) {
      map['days'] = day?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DayModel {
  DayModel({
    this.day,
    this.type,
  });

  DayModel.fromJson(dynamic json) {
    day = json['day'];
    type = json['type'];
  }

  num? day;
  num? type;

  DayModel copyWith({
    num? day,
    num? type,
  }) =>
      DayModel(
        day: day ?? this.day,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['type'] = type;
    return map;
  }
}
