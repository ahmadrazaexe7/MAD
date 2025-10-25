import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/description_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController =
  TextEditingController(text: 'Ahmad Raza');
  String _displayName = 'Ahmad Raza';
  String _validationMessage = '';

  final String _email = 'ahmadrazaexe7@gmail.com';
  final String _sapId = '54471';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    final text = _nameController.text.trim();
    FocusScope.of(context).unfocus();
    setState(() {
      if (text.isEmpty) {
        _validationMessage = 'Name cannot be empty.';
      } else {
        _validationMessage = '';
        _displayName = text;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name saved')),
        );
      }
    });
  }

  void _cancelEdit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _nameController.text = _displayName;
      _validationMessage = '';
    });
  }

  void _resetName() {
    FocusScope.of(context).unfocus();
    setState(() {
      _nameController.text = 'Ahmad Raza';
      _displayName = 'Ahmad Raza';
      _validationMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ProfileHeader(
              displayName: _displayName,
              email: _email,
              sapId: _sapId,
              onReset: _resetName,
            ),
            const SizedBox(height: 20),
            const DescriptionBox(
              text:
              'Short description: Hello! My name is Ahmad. I am a student learning Flutter and I enjoy creating simple and beautiful mobile apps.',
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Edit username',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _nameController.clear(),
                ),
              ),
            ),
            if (_validationMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(_validationMessage, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 12),
            Row(children: [
              ElevatedButton(onPressed: _saveName, child: const Text('Save')),
              const SizedBox(width: 8),
              TextButton(onPressed: _cancelEdit, child: const Text('Cancel')),
            ]),
            const Spacer(),
            Center(
              child: Text(
                'Orientation: ${isPortrait ? 'Portrait' : 'Landscape'}',
                style: TextStyle(
                    fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
