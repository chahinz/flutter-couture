// import 'package:cloud_firestore/cloud_firestore.dart';

// class Booking {
//   final String id;
//   final String userId;
//   final String tailorId;
//   final String modelId;
//   final List<String> colors;
//   final List<String> sizes;
//   final String status;
//   final String intialprice;
//   final String modifiedprice;
//   final DateTime createdAt;
//   final String categoryId;
//   final String note;

//   Booking({
//     required this.id,
//     required this.userId,
//     required this.tailorId,
//     required this.modelId,
//     required this.intialprice,
//     required this.modifiedprice,
//     required this.sizes,
//     required this.colors,
//     required this.status,
//     required this.createdAt,
//     required this.categoryId,
//     required this.note,
//   });

//   factory Booking.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Booking(
//       id: doc.id,
//       categoryId: data['categoryid'],
//       userId: data['userId'],
//       tailorId: data['tailorId'],
//       modelId: data['modelId'],
//       intialprice: data['intialprice'],
//       modifiedprice: data['modifiedprice'],
//       colors: List<String>.from(data['colors']),
//       sizes: List<String>.from(data['sizes']),
//       status: data['status'],
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//       note: data['note'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "userId": userId,
//       "tailorId": tailorId,
//       "modelId": modelId,
//       "size": sizes,
//       "color": colors,
//       "status": status,
//       "createdAt": createdAt,
//       "categoryid": categoryId,
//     };
//   }
// }






// import 'package:cloud_firestore/cloud_firestore.dart';

// class Booking {
//   final String id;
//   final String categoryId;
//   final String userId;
//   final String tailorId;
//   final String modelId;
//   final String intialprice;
//   final String modifiedprice;
//   final List<String> colors;
//   final List<String> sizes;
//   final String status;
//   final DateTime createdAt;
//   final String note;

//   Booking({
//     required this.id,
//     required this.categoryId,
//     required this.userId,
//     required this.tailorId,
//     required this.modelId,
//     required this.intialprice,
//     required this.modifiedprice,
//     required this.colors,
//     required this.sizes,
//     required this.status,
//     required this.createdAt,
//     required this.note,
//   });

//   factory Booking.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     // Helper to safely extract IDs, whether it's a full ref or string
//     String extractId(dynamic ref) {
//       if (ref is DocumentReference) return ref.id;
//       if (ref is String) return ref.split('/').last;
//       return '';
//     }

//     return Booking(
//       id: doc.id,
//       categoryId: extractId(data['categoryId']),
//       userId: extractId(data['userId']),
//       tailorId: extractId(data['tailorId']),
//       modelId: extractId(data['modelId']),
//       intialprice: data['intialprice'] ?? '',
//       modifiedprice: data['modifiedprice'] ?? '',
//       colors: List<String>.from(data['colors'] ?? []),
//       sizes: List<String>.from(data['sizes'] ?? []),
//       status: data['status'] ?? '',
//       createdAt: (data['createdAt'] as Timestamp).toDate(),
//       note: data['note'] ?? '',
//     );
//   }
// }







// import 'package:cloud_firestore/cloud_firestore.dart';

// class Booking {
//   final String id;
//   final String categoryId;
//   final String userId;
//   final String tailorId;
//   final String modelId;
//   final String initialprice;  
//   final String modifiedprice;
//   final List<String>? colors;
//   final List<String>? sizes;
//   final String status;
//   final DateTime createdAt;
//   final String note;

//   Booking({
//     required this.id,
//     required this.categoryId,
//     required this.userId,
//     required this.tailorId,
//     required this.modelId,
//     required this.initialprice,
//     required this.modifiedprice,
//     this.colors,
//     this.sizes,
//     required this.status,
//     required this.createdAt,
//     required this.note,
//   });

//   factory Booking.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     return Booking(
//   id: doc.id,  
//   categoryId: data['categoryId'] ?? '',  
//   userId: data['userId'] ?? '',  
//   tailorId: data['tailorId'] ?? '',  
//   modelId: data['modelId'] ?? '', 
//   initialprice: data['initialprice'] ?? '',  
//   modifiedprice: data['modifiedprice'] ?? '', 
//   // colors : List<String>.from(data['colors']) , 
//   // sizes : List<String>.from(data['sizes']) ,
//   colors: data['colors'] != null ? List<String>.from(data['colors']) : [],
//   sizes: data['sizes'] != null ? List<String>.from(data['sizes']) : [],
//   status: data['status'] ?? '', 
//   createdAt: data['createdAt'] != null && data['createdAt'] is Timestamp
//       ? (data['createdAt'] as Timestamp).toDate() 
//       : DateTime.now(), 
//   note: data['note'] ?? '',  
// );

//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String categoryId;
  final String userId;
  final String tailorId;
  final String modelId;
  final String initialprice;  
  final String modifiedprice;
  final List<String>? colors;
  final List<String>? sizes;
  final String status;
  final DateTime createdAt;
  final String note;
  final int progress;

  Booking({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.tailorId,
    required this.modelId,
    required this.initialprice,
    required this.modifiedprice,
    this.colors,
    this.sizes,
    required this.status,
    required this.createdAt,
    required this.note,
    required this.progress,
  });

  // factory Booking.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Booking(
  //     id: doc.id,  
  //     categoryId: data['categoryId'] ?? '',  
  //     userId: data['userId'] ?? '',  
  //     tailorId: data['tailorId'] ?? '',  
  //     modelId: data['modelId'] ?? '', 
  //     initialprice: data['initialprice'] ?? '',  
  //     modifiedprice: data['modifiedprice'] ?? '', 
  //     colors: (data['colors'] is List) ? List<String>.from(data['colors']) : [],
  //     sizes: (data['sizes'] is List) ? List<String>.from(data['sizes']) : [],
  //     status: data['status'] ?? '', 
  //     createdAt: data['createdAt'] != null && data['createdAt'] is Timestamp
  //         ? (data['createdAt'] as Timestamp).toDate() 
  //         : DateTime.now(), 
  //     note: data['note'] ?? '',  
  //   );
  // }

//   factory Booking.fromFirestore(DocumentSnapshot doc) {
//   final data = doc.data() as Map<String, dynamic>;
//   return Booking(
//     id: doc.id,
//     categoryId: data['categoryId'] ?? '',
//     userId: data['userId'] ?? '',
//     tailorId: data['tailorId'] ?? '',
//     modelId: data['modelId'] ?? '',
//     initialprice: data['initialprice'] ?? '',
//     modifiedprice: data['modifiedprice'] ?? '',
//     colors: (data['colors'] is List) ? List<String>.from(data['colors']) : [], // Defensive check for list
//     sizes: (data['sizes'] is List) ? List<String>.from(data['sizes']) : [],   // Defensive check for list
//     status: data['status'] ?? '',
//     createdAt: (data['createdAt'] != null && data['createdAt'] is Timestamp)
//         ? (data['createdAt'] as Timestamp).toDate()
//         : DateTime.now(),
//     note: data['note'] ?? '',
//   );
// }




// factory Booking.fromFirestore(DocumentSnapshot doc) {
//   final data = doc.data() as Map<String, dynamic>?;

//   if (data == null) {
//     throw Exception("Booking data is null");
//   }

//   return Booking(
//     id: doc.id,
//     categoryId: data['categoryId'] ?? '',
//     userId: data['userId'] ?? '',
//     tailorId: data['tailorId'] ?? '',
//     modelId: data['modelId'] ?? '',
//     initialprice: data['initialprice'] ?? '',
//     modifiedprice: data['modifiedprice'] ?? '',
//     // colors: (data['colors'] is List) ? List<String>.from(data['colors']) : <String>[],
//     // sizes: (data['sizes'] is List) ? List<String>.from(data['sizes']) : <String>[],
//     colors: data['colors'] is List ? List<String>.from(data['colors'].map((e) => e.toString())): [],
//     sizes: data['sizes'] is List ? List<String>.from(data['sizes'].map((e) => e.toString())): [],
//     status: data['status'] ?? '',
//     createdAt: (data['createdAt'] is Timestamp)
//         ? (data['createdAt'] as Timestamp).toDate()
//         : DateTime.now(),
//     note: data['note'] ?? '',
//   );
// }


factory Booking.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>?;

  if (data == null) {
    throw Exception("Booking data is null");
  }

  List<String> safeConvertList(dynamic rawList) {
    if (rawList == null || rawList is! Iterable) return <String>[];
    return rawList.map((e) => e.toString()).toList();
  }

  return Booking(
    id: doc.id,
    categoryId: data['categoryId'] ?? '',
    userId: data['userId'] ?? '',
    tailorId: data['tailorId'] ?? '',
    modelId: data['modelId'] ?? '',
    initialprice: data['initialprice'] ?? '',
    modifiedprice: data['modifiedprice'] ?? '',
    colors: safeConvertList(data['colors']),
    sizes: safeConvertList(data['sizes']),
    status: data['status'] ?? '',
    createdAt: data['createdAt'] is Timestamp
        ? (data['createdAt'] as Timestamp).toDate()
        : DateTime.now(),
    note: data['note'] ?? '',
    progress: data['progress'] is int
        ? data['progress'] as int
        : int.tryParse(data['progress']?.toString() ?? '') ?? 0,
  );
}
}
