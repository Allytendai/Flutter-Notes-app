import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => NoteProvider()..fetchNotes(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteScreen(),
    );
  }
}

class NoteScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: ListView.builder(
        itemCount: provider.notes.length,
        itemBuilder: (context, index) {
          final note = provider.notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => provider.deleteNote(note.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('New Note'),
              content: Column(
                children: [
                  TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
                  TextField(controller: contentController, decoration: InputDecoration(labelText: 'Content')),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    provider.addNote(titleController.text, contentController.text);
                    titleController.clear();
                    contentController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
