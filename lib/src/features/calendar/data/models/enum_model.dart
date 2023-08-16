class EnumModel {
  EnumModel({
      this.type, 
      this.color,});

  EnumModel.fromJson(dynamic json) {
    type = json['type'];
    color = json['color'];
  }
  num? type;
  String? color;
EnumModel copyWith({  num? type,
  String? color,
}) => EnumModel(  type: type ?? this.type,
  color: color ?? this.color,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['color'] = color;
    return map;
  }

}