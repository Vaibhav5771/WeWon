import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class AudioService {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

    await _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (!_isRecording) {
      await _recorder.startRecorder(
        toFile: _generateFileName(),
      );
      _isRecording = true;
    }
  }

  Future<String?> stopRecording() async {
    if (_isRecording) {
      final filePath = await _recorder.stopRecorder();
      _isRecording = false;
      return filePath;
    }
    return null;
  }

  String _generateFileName() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
    return 'audio_record_$formattedDate.aac'; // File name with date and time
  }

  Future<String> uploadToFirebase(String filePath, String category) async {
    final File audioFile = File(filePath);
    final String formattedDate = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());

    // Convert category to lowercase
    final String categoryLower = category.toLowerCase();

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('audio_files/$categoryLower/audio_record_$formattedDate.aac');

    final uploadTask = storageRef.putFile(audioFile);
    final snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }


  void disposeRecorder() {
    _recorder.closeRecorder();
  }
}
