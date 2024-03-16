import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vega/models/myevents.dart';
import 'package:vega/services/firebase_db.dart';

class EventSection extends StatefulWidget {
  final String? title;
  final String? description;
  final DateTime? date;
  final TimeOfDay? time;
  final String? location;
  final String? imageUrl;

  const EventSection({
    Key? key,
    this.title,
    this.description,
    this.date,
    this.time,
    this.location,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<EventSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late DateTime _selectedDate = widget.date ?? DateTime.now();
  late TimeOfDay _selectedTime = widget.time ?? TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _locationController = TextEditingController(text: widget.location);
  }

  final DBservEvents _db = DBservEvents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title != null ? 'Edit Event' : 'Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _titleController,
                labelText: 'Title',
                prefixIcon: Icons.title,
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _descriptionController,
                labelText: 'Description',
                prefixIcon: Icons.description,
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildTextFormField(
                      controller: TextEditingController(
                          text:
                              '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                      labelText: 'Date',
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      prefixIcon: Icons.calendar_today,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextFormField(
                      controller: TextEditingController(
                          text:
                              '${_selectedTime.hour}:${_selectedTime.minute}'),
                      labelText: 'Time',
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      prefixIcon: Icons.access_time,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                controller: _locationController,
                labelText: 'Location',
                prefixIcon: Icons.location_on,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                    widget.title != null ? 'Update Event' : 'Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    IconData? prefixIcon,
    bool readOnly = false,
    GestureTapCallback? onTap,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            Color.fromARGB(255, 250, 250, 250), // Add the background color here
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process form data (e.g., save to database)
      final title = _titleController.text;
      final description = _descriptionController.text;
      final date = _selectedDate;
      final time = _selectedTime;
      final location = _locationController.text;
      // Perform actions based on the form data
      print('Title: $title');
      print('Description: $description');
      print('Date: $date');
      print('Time: $time');
      print('Location: $location');

      _db.addEvent(myEvents(
          title: title,
          description: description,
          location: location,
          datetime: Timestamp.fromDate(date),
          isLive: false,
          owner: 'user1'));
      // Clear the form
      _titleController.clear();
      _descriptionController.clear();
      _locationController.clear();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
