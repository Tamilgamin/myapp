class Equipment {
  final String id;
  final String name;
  final String type; // beaker, test_tube, burette, etc.
  final String description;
  final List<String> uses;
  final String material;
  final double capacity; // in ml
  final String? model3d; // reference to 3D model
  final String? imageUrl;

  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.uses,
    required this.material,
    required this.capacity,
    this.model3d,
    this.imageUrl,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      uses: List<String>.from(json['uses']),
      material: json['material'],
      capacity: json['capacity'],
      model3d: json['model3d'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'description': description,
    'uses': uses,
    'material': material,
    'capacity': capacity,
    'model3d': model3d,
    'imageUrl': imageUrl,
  };
}
