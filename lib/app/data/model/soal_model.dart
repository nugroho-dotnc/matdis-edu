class SoalModel {
  String id;
  String title;
  String description;
  String category;
  String soal;
  String uploaded;
  SoalModel({
    required this.title,
    required this.description,
    required this.category,
    required this.soal,
    required this.id,
    required this.uploaded
  });

  // Konversi ke Map untuk diupload ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'soal': soal,
      'id': id,
      'category': category,
      'uploaded': uploaded
    };
  }

  // Konversi dari Map ke Model
  factory SoalModel.fromMap(Map<String, dynamic> map) {
    return SoalModel(
        title: map['title'],
        description: map['description'],
        soal: map['soal'],
        category: map['category'],
        id: map['id'],
        uploaded: map['uploaded']
    );
  }
}
