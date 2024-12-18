import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:matdis_edu/app/data/model/soal_model.dart';


class SoalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> addSoal(SoalModel soal) async {
    try {
      DocumentReference documentReference = await _firestore.collection('soal').add(soal.toMap());
      soal.id = documentReference.id;
      documentReference.update({'id':soal.id});
      Get.snackbar("Success", "Soal berhasil ditambahkan");
      return true;
    } catch (e) {
      Get.snackbar("Error", "Gagal menambahkan soal: $e");
      return false;
    }
  }
  Future<void> updateSoal(String id, SoalModel updatedSoal) async {
    try {
      await _firestore.collection('soal').doc(id).update(updatedSoal.toMap());
      Get.snackbar("Success", "Soal berhasil diperbarui");
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui soal: $e");
    }
  }
  Stream<List<SoalModel>> getAllSoal() {
    return FirebaseFirestore.instance.collection('soal').snapshots().map(
            (snapshot) => snapshot.docs
            .map<SoalModel>((doc) => SoalModel.fromMap(doc.data()))
            .toList());
  }
  Future<List<SoalModel>> getSoalByCategories(String category) async {
    List<SoalModel> soal = [];
    QuerySnapshot snapshot = await _firestore.collection('soals').where('category', isEqualTo: category).get();
    soal.addAll(snapshot.docs.map((doc) {
      return SoalModel.fromMap(doc.data() as Map<String, dynamic>);;
    }));
    return soal;
  }
  Future<void> deleteSoal(String id) async {
    try {
      await _firestore.collection('soal').doc(id).delete();
      Get.snackbar("Success", "Soal berhasil dihapus");
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus soal: $e");
    }
  }
}
