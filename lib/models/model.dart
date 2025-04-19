class Model {
  final List<String> colors;
  String description;
  List<String> fabrics;
  String modelId;
  String idTailor;
  String name;
  String notes;
  String price;
  final List<String> sizes;
  String subcategoryId;
  String idcategory;

  Model({
    required this.colors,
    required this.description,
    required this.fabrics,
    required this.modelId,
    required this.idTailor,
    required this.name,
    required this.notes,
    required this.price,
    required this.sizes,
    required this.subcategoryId,
    required this.idcategory,
  });


  Map<String, dynamic> toMap() {
    return {
      'colors': colors,
      'description': description,
      'fabrics': fabrics,
      'modelId': modelId,
      'idTailor': idTailor,
      'name': name,
      'notes': notes,
      'price': price,
      'sizes': sizes,
      'subcategoryId': subcategoryId,
      'idcategory':idcategory,
    };
  }


  factory Model.fromMap(Map<String, dynamic> map) {
  print('Model data: $map');  // Debug log for inspecting the incoming data

  return Model(
  colors: map['colors'] != null ? List<String>.from(map['colors']) : [],
  sizes: map['sizes'] != null ? List<String>.from(map['sizes']) : [],
    description: map['description'] ?? '',
    fabrics: map['fabrics'] != null ? List<String>.from(map['fabrics']) : [],
    modelId: map['modelId'] ?? '',
    idTailor: map['idTailor'] ?? '',
    name: map['name'] ?? '',
    notes: map['notes'] ?? '',
    price: map['price'] ?? '',
    subcategoryId: map['subcategoryId'] ?? '',
    idcategory: map['idcategory'] ?? '',
  );
}



}
