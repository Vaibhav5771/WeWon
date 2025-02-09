import 'package:flutter/material.dart';
import 'audio_service.dart';

class CategorySelectionPage extends StatelessWidget {
  final String filePath;
  final String? uploadedFileUrl;
  final AudioService audioService;
  CategorySelectionPage({
    required this.filePath,
    required this.uploadedFileUrl,
    required this.audioService,
  });

  final List<String> categories = ['Career', 'Relationship', 'Health', 'Emotional'];

  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories.first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Category for your Audio:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (newCategory) {
                selectedCategory = newCategory!;
              },
              items: categories
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final url = await audioService.uploadToFirebase(filePath, selectedCategory);
                Navigator.pop(context, url);
              },
              child: Text('Upload Audio'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
