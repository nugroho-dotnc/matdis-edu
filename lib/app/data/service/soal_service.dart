import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Future<List<SoalModel>> getSoal() async {
    List<SoalModel> soal = [];
    QuerySnapshot snapshot = await _firestore.collection('soal').get();
    soal.addAll(snapshot.docs.map((doc) {
      return SoalModel.fromMap(doc.data() as Map<String, dynamic>);
    }));
    return soal;
  }
  Future<List<SoalModel>> getSoalByCategories(String category) async {
    List<SoalModel> soal = [];
    QuerySnapshot snapshot = await _firestore.collection('soal').where('category', isEqualTo: category).get();
    soal.addAll(snapshot.docs.map((doc) {
      return SoalModel.fromMap(doc.data() as Map<String, dynamic>);;
    }));
    return soal;
  }
  Future<void> deleteSoal(SoalModel soal) async {
    try {
      await deleteFileIfExists(soal.soal);
      await _firestore.collection('soal').doc(soal.id).delete();
      Get.snackbar("Success", "Soal berhasil dihapus");
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus soal: $e");
    }
  }
  Future<bool> checkFileExists(String filePath) async {
    try {
      // Coba ambil metadata file
      await FirebaseStorage.instance.refFromURL(filePath).getMetadata();
      return true; // File ada
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        return false; // File tidak ditemukan
      }
      rethrow; // Lempar ulang error jika bukan karena file tidak ada
    }
  }

  Future<void> deleteFileIfExists(String filePath) async {
    bool exists = await checkFileExists(filePath);
    if (exists) {
      try {
        // Hapus file jika ditemukan
        await FirebaseStorage.instance.refFromURL(filePath).delete();
        print("File berhasil dihapus.");
      } catch (e) {
        print("Gagal menghapus file: $e");
      }
    } else {
      print("File tidak ditemukan.");
    }
  }
}
