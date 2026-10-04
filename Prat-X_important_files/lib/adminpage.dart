import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:part_time_jobs/login_screen.dart';
import 'global.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final DatabaseReference _jobsRef = FirebaseDatabase.instance.ref('jobs');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  String _selectedType = 'Full-Time';
  String message = "";

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _submitJob() async {
    try {
      final newJobRef = _jobsRef.push();
      await newJobRef.set({
        'title': _titleController.text,
        'company': _companyController.text,
        'location': _locationController.text,
        'salary': _salaryController.text,
        'type': _selectedType,
      });

      // Clear form after submission
      _titleController.clear();
      _companyController.clear();
      _locationController.clear();
      _salaryController.clear();

      setState(() {
        message = "Job posted successfully!";
      });
    } catch (e) {
      setState(() {
        message = "Error posting job: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings),
            SizedBox(width: 10),
            Text(
              "Admin Dashboard",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      backgroundColor: const Color(0xFFFCFAF7),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 1),
              Center(
                child: Icon(
                  Icons.work_outline,
                  size: 70,
                  color: Color(0xFF6C7FFF),
                ),
              ),
              const SizedBox(height: 1),
              const Center(
                child: Text(
                  "Post New Job",
                  style: TextStyle(
                    color: Color(0xFF6C7FFF),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Job Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(
                  hintText: "Company Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "Location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(
                  hintText: "Salary",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: const [
                  DropdownMenuItem(value: 'Full-Time', child: Text('Full-Time')),
                  DropdownMenuItem(value: 'Part-Time', child: Text('Part-Time')),
                  DropdownMenuItem(value: 'Contract', child: Text('Contract')),
                  DropdownMenuItem(value: 'Remote', child: Text('Remote')),
                ],
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(
                  hintText: "Job Type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C7FFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Post Job",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (message.isNotEmpty)
                Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: message.contains("successful")
                          ? Colors.green
                          : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C7FFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}