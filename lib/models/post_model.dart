// class Post {
//   final String title;
//   final String description;
//   final List<String> sizes;
//   final List<String> fabrics;
//   final List<String> colors;
//   // final String imageUrl;
//   // final String price;
//   final DateTime createdAt;
//   final String authorId;
  
  

//   Post({
//     required this.title,
//     required this.description,
//     required this.sizes,
//     required this.fabrics,
//     required this.colors,
//     // required this.imageUrl,
//     required this.createdAt,
//     // required this.price
//     required this.authorId,

//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       title: json['title'],
//       description: json['description'],
//       sizes: List<String>.from(json['sizes']),
//       fabrics: List<String>.from(json['fabrics']),
//       colors: List<String>.from(json['colors']),
//       // price : json['price'],
//       // imageUrl: json['imageUrl'],
//       createdAt: DateTime.parse(json['createdAt']),
//        authorId: json['authorId'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'description': description,
//       'sizes': sizes,
//       'fabrics': fabrics,
//       'colors': colors,
//       // 'imageUrl': imageUrl,
//       'createdAt': createdAt.toIso8601String(),
//       'authorId': authorId,
//     };
//   }
// }





// class Post {
//   final String name;
//   final String description;
//   final List<String> sizes;
//   final List<String> fabrics;
//   final List<String> colors;
//   final String idtailor;
//   final String notes;
//   final String price;
//   final String subcategoryid;
//   final DateTime createdAt;

//   Post({
//     required this.name,
//     required this.description,
//     required this.sizes,
//     required this.fabrics,
//     required this.colors,
//     required this.idtailor,
//     required this.notes,
//     required this.price,
//     required this.subcategoryid,
//     required this.createdAt,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       name: json['name'],
//       description: json['description'],
//       sizes: List<String>.from(json['size']),
//       fabrics: List<String>.from(json['fabrics']),
//       colors: List<String>.from(json['color']),
//       idtailor: json['idtailor'],
//       notes: json['notes'],
//       price: json['price'],
//       subcategoryid: json['subcategoryid'],
//       createdAt: DateTime.parse(json['createdAt']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'description': description,
//       'size': sizes,
//       'fabrics': fabrics,
//       'color': colors,
//       'idtailor': idtailor,
//       'notes': notes,
//       'price': price,
//       'subcategoryid': subcategoryid,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
