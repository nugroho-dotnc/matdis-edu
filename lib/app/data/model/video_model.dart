class VideoModel {
  String title;
  String description;
  String thumbnailUrl;
  String videoUrl;
  String category;
  VideoModel({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
  });

  // Konversi ke Map untuk diupload ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'category': category,
    };
  }

  // Konversi dari Map ke Model
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map['title'],
      description: map['description'],
      thumbnailUrl: map['thumbnailUrl'],
      videoUrl: map['videoUrl'],
      category: map['category'],
    );
  }
}
