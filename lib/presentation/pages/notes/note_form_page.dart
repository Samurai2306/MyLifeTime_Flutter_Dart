// lib/presentation/pages/note/note_form_page.dart
import 'package:flutter/material.dart';

class NoteFormPage extends StatelessWidget {
  final int? noteId;

  const NoteFormPage({Key? key, this.noteId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noteId == null ? 'New Note' : 'Edit Note'),
      ),
      body: const Center(
        child: Text('Note Form - To be implemented'),
      ),
    );
  }
}