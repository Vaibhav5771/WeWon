import 'package:flutter/material.dart';
import 'audio_service.dart';
import 'category_selection.dart';


class AudioRecorderPage extends StatefulWidget {
  @override
  _AudioRecorderPageState createState() => _AudioRecorderPageState();
}

class _AudioRecorderPageState extends State<AudioRecorderPage> {
  final AudioService _audioService = AudioService();
  String? _uploadedFileUrl;
  bool _isRecording = false;
  bool _isRecordingFinished = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _audioService.initRecorder();
  }

  void _startRecording() async {
    try {
      await _audioService.startRecording();
      setState(() {
        _isRecording = true;
        _isRecordingFinished = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording started')),
      );
    } catch (e) {
      print(e);
    }
  }

  void _stopRecording() async {
    try {
      final filePath = await _audioService.stopRecording();
      if (filePath != null) {
        setState(() {
          _filePath = filePath;
          _isRecording = false;
          _isRecordingFinished = true;
        });

        // Navigate to category selection page after recording is finished
        final uploadedUrl = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionPage(
              filePath: filePath,
              uploadedFileUrl: _uploadedFileUrl,
              audioService: _audioService,
            ),
          ),
        );

        setState(() {
          _uploadedFileUrl = uploadedUrl;
        });

        if (_uploadedFileUrl != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Audio uploaded: $_uploadedFileUrl')),
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Record and Upload Your Audio',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Start/Stop Recording Button
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                _isRecording ? 'Stop Recording' : 'Start Recording',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),

            // Display uploaded file URL
            if (_uploadedFileUrl != null) ...[
              SizedBox(height: 20),
              Text(
                'Audio uploaded successfully!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Download URL: $_uploadedFileUrl',
                style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Spacer to ensure alignment and padding
            Spacer(),
          ],
        ),
      ),
    );
  }
}
