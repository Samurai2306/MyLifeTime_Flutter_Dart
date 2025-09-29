// presentation/pages/event/event_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';

class EventFormPage extends StatefulWidget {
  final int? eventId;

  const EventFormPage({Key? key, this.eventId}) : super(key: key);

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));
  bool _isAllDay = false;
  int _selectedColor = Colors.blue.value;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _loadEventIfEditing();
  }

  void _loadEventIfEditing() {
    if (widget.eventId != null) {
      // Загрузка события для редактирования
      context.read<EventBloc>().add(LoadEventById(widget.eventId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventId == null ? 'New Event' : 'Edit Event'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveEvent,
          ),
        ],
      ),
      body: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventLoaded && widget.eventId != null) {
            _populateForm(state.event);
          } else if (state is EventOperationSuccess) {
            Navigator.of(context).pop();
          } else if (state is EventError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTitleField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                _buildDateTimeFields(),
                const SizedBox(height: 16),
                _buildCategorySelector(),
                const SizedBox(height: 16),
                _buildColorSelector(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget _buildDateTimeFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _isAllDay,
              onChanged: (value) {
                setState(() {
                  _isAllDay = value!;
                });
              },
            ),
            const Text('All day'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildDateField('Start', _startDate, (date) {
                setState(() {
                  _startDate = date;
                  if (_endDate.isBefore(_startDate)) {
                    _endDate = _startDate.add(const Duration(hours: 1));
                  }
                });
              }),
            ),
            const SizedBox(width: 8),
            if (!_isAllDay)
              Expanded(
                child: _buildTimeField(_startDate, (time) {
                  setState(() {
                    _startDate = DateTime(
                      _startDate.year,
                      _startDate.month,
                      _startDate.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildDateField('End', _endDate, (date) {
                setState(() {
                  _endDate = date;
                });
              }),
            ),
            const SizedBox(width: 8),
            if (!_isAllDay)
              Expanded(
                child: _buildTimeField(_endDate, (time) {
                  setState(() {
                    _endDate = DateTime(
                      _endDate.year,
                      _endDate.month,
                      _endDate.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime date, ValueChanged<DateTime> onChanged) {
    return ListTile(
      title: Text('$label Date'),
      subtitle: Text('${date.year}-${date.month}-${date.day}'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          onChanged(selectedDate);
        }
      },
    );
  }

  Widget _buildTimeField(DateTime date, ValueChanged<TimeOfDay> onChanged) {
    return ListTile(
      title: const Text('Time'),
      subtitle: Text('${date.hour}:${date.minute.toString().padLeft(2, '0')}'),
      trailing: const Icon(Icons.access_time),
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(date),
        );
        if (selectedTime != null) {
          onChanged(selectedTime);
        }
      },
    );
  }

  Widget _buildCategorySelector() {
    // TODO: Заменить на реальные категории из BLoC
    return DropdownButtonFormField<int>(
      value: _selectedCategoryId,
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem(value: null, child: Text('No category')),
        const DropdownMenuItem(value: 1, child: Text('Work')),
        const DropdownMenuItem(value: 2, child: Text('Personal')),
        const DropdownMenuItem(value: 3, child: Text('Health')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCategoryId = value;
        });
      },
    );
  }

  Widget _buildColorSelector() {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    return Wrap(
      spacing: 8,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = color.value;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: _selectedColor == color.value
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _saveEvent,
            child: const Text('Save Event'),
          ),
        ),
        if (widget.eventId != null) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteEvent,
            color: Colors.red,
          ),
        ],
      ],
    );
  }

  void _populateForm(EventEntity event) {
    _titleController.text = event.title;
    _descriptionController.text = event.description ?? '';
    _startDate = event.startDate;
    _endDate = event.endDate;
    _isAllDay = event.isAllDay;
    _selectedColor = event.colorValue;
    _selectedCategoryId = event.categoryId;
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final event = EventEntity(
        id: widget.eventId ?? 0,
        title: _titleController.text,
        description: _descriptionController.text.isEmpty 
            ? null 
            : _descriptionController.text,
        startDate: _startDate,
        endDate: _endDate,
        isAllDay: _isAllDay,
        colorValue: _selectedColor,
        categoryId: _selectedCategoryId,
      );

      if (widget.eventId == null) {
        context.read<EventBloc>().add(AddEventEvent(event: event));
      } else {
        context.read<EventBloc>().add(UpdateEventEvent(event: event));
      }
    }
  }

  void _deleteEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.eventId != null) {
                final event = EventEntity(
                  id: widget.eventId!,
                  title: _titleController.text,
                  startDate: _startDate,
                  endDate: _endDate,
                  isAllDay: _isAllDay,
                  colorValue: _selectedColor,
                );
                context.read<EventBloc>().add(DeleteEventEvent(event: event));
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}