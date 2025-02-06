import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wewon/audio/services.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String category;

  const AudioPlayerScreen({required this.category});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  List<String> _audioUrls = [];
  final AudioPlayer _player = AudioPlayer();
  String? _playingUrl;
  bool _isLoading = true;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _fetchAudioFiles();

    // Listen to player state changes
    _player.playerStateStream.listen((state) {
      setState(() {
        _isPaused = state.playing == false && _playingUrl != null;
      });
    });
  }

  Future<void> _fetchAudioFiles() async {
    try {
      final urls = await AudioServices.fetchAudioFiles(widget.category);
      setState(() {
        _audioUrls = urls;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching audio files: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _togglePlayPause(String url) async {
    if (_playingUrl == url) {
      if (_player.playing) {
        await _player.pause();
      } else {
        await _player.play();
      }
    } else {
      await _player.stop();
      setState(() {
        _playingUrl = url;
        _isPaused = false;
      });

      await _player.setUrl(url);
      _player.play();

      _player.playbackEventStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          AudioServices.deleteAudioFile(url).then((_) {
            setState(() {
              _audioUrls.remove(url);
              _playingUrl = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Audio deleted')),
            );
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF3AA1ED),
          title: Text('${widget.category} ')),
      body: _isLoading
          ? Center(child: Text('Loading audio...', style: TextStyle(fontSize: 20)))
          : _audioUrls.isEmpty
          ? Center(child: Text('No audio recorded', style: TextStyle(fontSize: 20)))
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _audioUrls.length,
        itemBuilder: (context, index) {
          final url = _audioUrls[index];
          final isPlaying = url == _playingUrl && !_isPaused;
          final isPaused = url == _playingUrl && _isPaused;

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.music_note, color: Colors.white),
              ),
              title: Text('Audio ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.blueAccent,
                ),
                onPressed: () => _togglePlayPause(url),
              ),
            ),
          );
        },
      ),
    );
  }
}
