import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matdis_edu/app/data/model/video_model.dart';


class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VideoModel>> getUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('videos').get();
    return snapshot.docs.map((doc) {
      return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
