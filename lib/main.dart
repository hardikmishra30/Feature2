import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditableList(),
  ));
}

class EditableList extends StatefulWidget {
  const EditableList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditableListState createState() => _EditableListState();
}

class _EditableListState extends State<EditableList> {
  final List<String> _items = ["Item 1", "Item 2", "Item 3"];
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each item in the list
    _controllers = List.generate(
      _items.length,
      (index) => TextEditingController(text: _items[index]),
    );
  }

  void _updateList() {
    setState(() {
      for (int i = 0; i < _items.length; i++) {
        _items[i] = _controllers[i].text;
      }
    });
  }

  @override
  void dispose() {
    // Dispose of controllers to free resources
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable List Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: 'Item ${index + 1}',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateList,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
