class Chemical {
  final String name;
  final String formula;
  final String hazards;
  final String state; // solid, liquid, gas
  final String color;
  final double molarMass;
  final String? imageUrl;

  Chemical({
    required this.name,
    required this.formula,
    required this.hazards,
    required this.state,
    required this.color,
    required this.molarMass,
    this.imageUrl,
  });

  factory Chemical.fromJson(Map<String, dynamic> json) {
    return Chemical(
      name: json['name'],
      formula: json['formula'],
      hazards: json['hazards'],
      state: json['state'],
      color: json['color'],
      molarMass: json['molarMass'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'formula': formula,
    'hazards': hazards,
    'state': state,
    'color': color,
    'molarMass': molarMass,
    'imageUrl': imageUrl,
  };
}
