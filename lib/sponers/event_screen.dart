import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vega/models/company.dart';
import 'package:vega/services/firebase_db.dart';

class EventScreen extends StatelessWidget {
  final DBcompany _db = DBcompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Event Screen',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the CompanyFormScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompanyFormScreen()),
                );
              },
              child: Text('List Your Company'),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyFormScreen extends StatefulWidget {
  @override
  _CompanyFormScreenState createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  final DBcompany _db = DBcompany();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Your Company'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(
                controller: _nameController,
                labelText: 'Company Name',
                prefixIcon: Icons.title,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter the company name';
                //   }
                //   return null;
                // },
              ),
              SizedBox(height: 20),
              TagInputField(
                controller: _tagController,
                onChanged: (value) {
                  // Handle tag text changes here if needed
                },
              ),
              SizedBox(height: 20),
              DescriptionTextField(
                controller: _descriptionController,
                onChanged: (value) {
                  // Handle description text changes here if needed
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _websiteController,
                decoration: InputDecoration(labelText: 'Website (Optional)'),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process form data (e.g., save to database)
                    final title = _nameController.text;
                    final description = _descriptionController.text;
                    final tags = _tagController.text;
                    final websiteName = _websiteController.text;

                    // Perform actions based on the form data

                    _db.addCompany(Company(
                      title: title,
                      tags: tags,
                      description: description,
                      websiteName: websiteName,
                    ));
                    // Clear the form
                    _nameController.clear();
                    _descriptionController.clear();
                    _tagController.clear();
                    _websiteController.clear();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const DescriptionTextField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      radius: 10,
      child: TextField(
        onChanged: onChanged,
        maxLines: 6,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        controller: controller,
        decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Text Here',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

class NeumorphicInputField extends StatelessWidget {
  const NeumorphicInputField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final String? Function(dynamic value) validator;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: TextField(
        onChanged: (value) {},
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        controller: TextEditingController(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 3),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Text Here',
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          labelText: labelText,
        ),
      ),
    );
  }
}

class TagInputField extends StatefulWidget {
  const TagInputField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  State<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  final chips = List.generate(2, (index) => 'Chip {index + 1}').toSet();

  late FocusNode inputFieldNode;

  @override
  void initState() {
    inputFieldNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    inputFieldNode.dispose();
    super.dispose();
  }

  void _addChip(String value) {
    setState(() {
      chips.add(value);
    });
    widget.controller.clear();
    FocusScope.of(context).requestFocus(inputFieldNode);
  }

  void _removeChip(String value) {
    setState(() {
      chips.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      radius: 10,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (key) {
          if (widget.controller.text.isEmpty &&
              key is RawKeyDownEvent &&
              key.data.logicalKey == LogicalKeyboardKey.backspace) {
            setState(() {
              chips.remove(chips.last);
            });
          }
        },
        child: Center(
          child: InputDecorator(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            child: Wrap(
              spacing: 5,
              runSpacing: -7,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...chips.map(
                  (value) => Chip(
                    backgroundColor: const Color(0xFF00BAAB),
                    side: BorderSide.none,
                    label: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF222222),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onDeleted: () {
                      _removeChip(value);
                    },
                    deleteIcon: const Icon(Icons.cancel),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: widget.controller,
                    focusNode: inputFieldNode,
                    style: const TextStyle(color: Colors.black87),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        final word = value.substring(0, value.length);
                        _addChip(word);
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: 'Tags',
                      hintStyle: TextStyle(color: Color(0xFF5E5E5E)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    Key? key,
    this.radius,
    this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF1E1E1E),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
          const BoxShadow(
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black,
          ),
        ],
      ),
      child: child,
    );
  }
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
