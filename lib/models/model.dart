class Model {
  List<String> colors;
  String description;
  List<String> fabrics;
  String? modelId;
  String idTailor;
  String name;
  String notes;
  String price;
  List<String>? sizes;
  String subcategoryId;
  String idcategory;
  String? imageUrl;
  
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
    this.imageUrl,
  });


  Map<String, dynamic> toMap() {
    return {
      'colors': colors,
      'description': description,
      'fabrics': fabrics,
      'idModel': modelId,
      'idTailor': idTailor,
      'name': name,
      'notes': notes,
      'price': price,
      'sizes': sizes,
      'subcategoryId': subcategoryId,
      'idcategory':idcategory,
      'imageUrl': imageUrl ?? '',
    };
  }


factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      modelId: json['idModel'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '',
      idTailor: json['idTailor'] ?? '',
      idcategory: json['idcategory'] ?? '',
      subcategoryId: json['subcategoryId']?.toString() ?? '',
      colors: json['colors'] is List ? List<String>.from(json['colors']) : <String>[],
      sizes: json['sizes'] is List ? List<String>.from(json['sizes']) : <String>[],
      fabrics: json['fabrics'] is List ? List<String>.from(json['fabrics']) : <String>[],
      notes: json['notes'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }



}
