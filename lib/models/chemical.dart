class Chemical {
  final String name;
  final String formula;
  final String hazardSymbols;
  final String hazardStatements;
  final String precautionaryStatements;

  Chemical({
    required this.name,
    required this.formula,
    required this.hazardSymbols,
    required this.hazardStatements,
    required this.precautionaryStatements,
  });

  factory Chemical.fromJson(Map<String, dynamic> json) {
    return Chemical(
      name: json['name'] ?? '',
      formula: json['formula'] ?? '',
      hazardSymbols: json['hazardSymbols'] ?? '',
      hazardStatements: json['hazardStatements'] ?? '',
      precautionaryStatements: json['precautionaryStatements'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'formula': formula,
    'hazardSymbols': hazardSymbols,
    'hazardStatements': hazardStatements,
    'precautionaryStatements': precautionaryStatements,
  };
}
