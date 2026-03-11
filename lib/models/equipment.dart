class Equipment {
  final String id;
  final String name;
  final String description;
  final String type; // 'container', 'heating', 'measuring', 'mixing', 'holding'
  final String modelPath; // Path to 3D model

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.modelPath,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'container',
      modelPath: json['modelPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'type': type,
    'modelPath': modelPath,
  };
}

const List<Equipment> defaultEquipment = [
  Equipment(
    id: 'beaker',
    name: 'Beaker',
    description: 'A cylindrical glass container for mixing and heating solutions',
    type: 'container',
    modelPath: 'assets/models/beaker.glb',
  ),
  Equipment(
    id: 'test_tube',
    name: 'Test Tube',
    description: 'A small glass tube used in laboratory work',
    type: 'container',
    modelPath: 'assets/models/test_tube.glb',
  ),
  Equipment(
    id: 'conical_flask',
    name: 'Conical Flask',
    description: 'A flask with a conical body and narrow neck',
    type: 'container',
    modelPath: 'assets/models/conical_flask.glb',
  ),
  Equipment(
    id: 'burette',
    name: 'Burette',
    description: 'A graduated glass tube with a tap at one end, for delivering known volumes',
    type: 'measuring',
    modelPath: 'assets/models/burette.glb',
  ),
  Equipment(
    id: 'pipette',
    name: 'Pipette',
    description: 'A slender glass tube used to extract a liquid sample',
    type: 'measuring',
    modelPath: 'assets/models/pipette.glb',
  ),
  Equipment(
    id: 'glass_rod',
    name: 'Glass Rod',
    description: 'Used for stirring and mixing',
    type: 'mixing',
    modelPath: 'assets/models/glass_rod.glb',
  ),
  Equipment(
    id: 'funnel',
    name: 'Funnel',
    description: 'Used to pour liquids into vessels with narrow openings',
    type: 'mixing',
    modelPath: 'assets/models/funnel.glb',
  ),
  Equipment(
    id: 'bunsen_burner',
    name: 'Bunsen Burner',
    description: 'A gas heater used in laboratory experiments',
    type: 'heating',
    modelPath: 'assets/models/bunsen_burner.glb',
  ),
  Equipment(
    id: 'evaporating_dish',
    name: 'Evaporating Dish',
    description: 'A shallow ceramic bowl used for heating and evaporation',
    type: 'heating',
    modelPath: 'assets/models/evaporating_dish.glb',
  ),
  Equipment(
    id: 'measuring_cylinder',
    name: 'Measuring Cylinder',
    description: 'A graduated cylinder used to measure volumes of liquids',
    type: 'measuring',
    modelPath: 'assets/models/measuring_cylinder.glb',
  ),
  Equipment(
    id: 'tripod_stand',
    name: 'Tripod Stand',
    description: 'A three-legged stand for holding containers during heating',
    type: 'holding',
    modelPath: 'assets/models/tripod_stand.glb',
  ),
  Equipment(
    id: 'wire_gauze',
    name: 'Wire Gauze',
    description: 'A loosely woven wire mesh used to distribute heat',
    type: 'heating',
    modelPath: 'assets/models/wire_gauze.glb',
  ),
  Equipment(
    id: 'test_tube_holder',
    name: 'Test Tube Holder',
    description: 'Used to hold test tubes during experiments',
    type: 'holding',
    modelPath: 'assets/models/test_tube_holder.glb',
  ),
  Equipment(
    id: 'reagent_bottle',
    name: 'Reagent Bottle',
    description: 'A bottle for storing laboratory chemicals',
    type: 'container',
    modelPath: 'assets/models/reagent_bottle.glb',
  ),
];
