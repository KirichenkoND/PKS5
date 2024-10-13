import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Кириченко Никита Денисович';
  String group = 'ЭФБО-03-22';
  String phoneNumber = '+7 (987) 654-32-10';
  String email = 'kirichenko.n.d@edu.mirea.ru';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _groupController.text = group;
    _phoneController.text = phoneNumber;
    _emailController.text = email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _groupController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      if (isEditing) {
        name = _nameController.text;
        group = _groupController.text;
        phoneNumber = _phoneController.text;
        email = _emailController.text;
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEditing,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isEditing ? _buildEditProfile() : _buildProfileInfo(),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          group,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          'Телефон: $phoneNumber',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          'Email: $email',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildEditProfile() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Имя'),
          ),
          TextField(
            controller: _groupController,
            decoration: const InputDecoration(labelText: 'Группа'),
          ),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Телефон'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleEditing,
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
