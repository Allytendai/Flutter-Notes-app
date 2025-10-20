import 'package:flutter/material.dart';
import 'note_database.dart';
import 'note_model.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    _notes = await NoteDatabase.instance.getNotes();
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    await NoteDatabase.instance.insert(Note(title: title, content: content));
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await NoteDatabase.instance.delete(id);
    await fetchNotes();
  }
}
