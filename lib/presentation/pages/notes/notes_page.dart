// lib/presentation/pages/notes/notes_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/presentation/blocs/note/note_bloc.dart';
import 'package:mylifetime/domain/entities/note_entity.dart';
import 'package:mylifetime/presentation/widgets/common/glass_container.dart';
import 'package:mylifetime/presentation/widgets/common/loading_indicator.dart';
import 'package:mylifetime/presentation/widgets/common/error_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewNote,
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<NoteBloc>().add(LoadNotes());
          } else if (state is NoteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is NoteLoading) {
            return const LoadingIndicator();
          } else if (state is NotesLoaded) {
            return _buildNotesGrid(state.notes);
          } else if (state is NoteError) {
            return ErrorWidget(
              message: state.message,
              onRetry: () => context.read<NoteBloc>().add(LoadNotes()),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildNotesGrid(List<NoteEntity> notes) {
    if (notes.isEmpty) {
      return _buildEmptyState();
    }

    // Separate pinned and unpinned notes
    final pinnedNotes = notes.where((note) => note.isPinned).toList();
    final unpinnedNotes = notes.where((note) => !note.isPinned).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (pinnedNotes.isNotEmpty) ...[
          Text(
            'Pinned',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildNotesList(pinnedNotes),
          const SizedBox(height: 16),
        ],
        if (unpinnedNotes.isNotEmpty) ...[
          Text(
            'All Notes',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildNotesList(unpinnedNotes),
        ],
      ],
    );
  }

  Widget _buildNotesList(List<NoteEntity> notes) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return _buildNoteCard(note);
      },
    );
  }

  Widget _buildNoteCard(NoteEntity note) {
    return GlassContainer(
      onTap: () => _showNoteDetails(note),
      onLongPress: () => _showNoteOptions(note),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (note.isPinned) ...[
            const Icon(Icons.push_pin, size: 16),
            const SizedBox(height: 4),
          ],
          Text(
            note.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (note.content != null) ...[
            Expanded(
              child: Text(
                note.content!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ] else ...[
            const Spacer(),
          ],
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _formatDate(note.updatedAt),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No Notes Yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first note to capture your thoughts',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addNewNote,
            child: const Text('Create First Note'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _addNewNote() {
    // TODO: Navigate to note form
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: const Text('Note creation form will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showNoteDetails(NoteEntity note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note.title),
        content: SingleChildScrollView(
          child: Text(note.content ?? 'No content'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showNoteOptions(NoteEntity note) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Note'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Navigate to note edit
            },
          ),
          ListTile(
            leading: Icon(note.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            title: Text(note.isPinned ? 'Unpin Note' : 'Pin Note'),
            onTap: () {
              Navigator.of(context).pop();
              context.read<NoteBloc>().add(ToggleNotePin(noteId: note.id));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Note'),
            onTap: () {
              Navigator.of(context).pop();
              _showDeleteConfirmation(note);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(NoteEntity note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<NoteBloc>().add(DeleteNoteEvent(noteId: note.id));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}