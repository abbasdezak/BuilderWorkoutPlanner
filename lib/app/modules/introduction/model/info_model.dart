import 'dart:convert';

class InfoModel {
  final bool? isMale;
  final String? age;
  final String? height;
  final String? weight;
  InfoModel({
    this.isMale,
    this.age,
    this.height,
    this.weight,
  });

  InfoModel copyWith({
    bool? isMale,
    String? age,
    String? height,
    String? weight,
  }) {
    return InfoModel(
      isMale: isMale ?? this.isMale,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isMale': isMale,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      isMale: map['isMale'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) =>
      InfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfoModel(isMale: $isMale, age: $age, height: $height, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InfoModel &&
        other.isMale == isMale &&
        other.age == age &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return isMale.hashCode ^ age.hashCode ^ height.hashCode ^ weight.hashCode;
  }
}

