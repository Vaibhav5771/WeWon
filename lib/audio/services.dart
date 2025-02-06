import 'package:firebase_storage/firebase_storage.dart';

class AudioServices {
  static Future<List<String>> fetchAudioFiles(String category) async {
    final storageRef = FirebaseStorage.instance.ref().child('audio_files/$category');
    final result = await storageRef.listAll();
    final urls = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()),
    );
    return urls;
  }

  static Future<void> deleteAudioFile(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);
    await ref.delete();
  }
}
