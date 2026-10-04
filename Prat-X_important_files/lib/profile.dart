import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:part_time_jobs/global.dart';
import 'package:part_time_jobs/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
  Map<dynamic, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    if (globals.currentUserId != null) {
      final snapshot = await _dbRef.child(globals.currentUserId!).get();
      if (snapshot.exists) {
        setState(() {
          userData = snapshot.value as Map<dynamic, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.person_outline, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              "My Profile",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6C7FFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => _navigateToEditProfile(),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFCFAF7),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF6C7FFF),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              _buildInfoCard(
                  Icons.person, "Full Name", userData!['name'] ?? "Not provided"),
              const SizedBox(height: 20),
              _buildInfoCard(
                  Icons.email, "Email", userData!['email'] ?? "Not provided"),
              const SizedBox(height: 20),
              _buildInfoCard(
                  Icons.phone, "Phone", userData!['phone'] ?? "Not provided"),
              const SizedBox(height: 20),
              _buildInfoCard(Icons.location_on, "address",
                  userData!['address'] ?? "Not provided"),
              const SizedBox(height: 20),
              _buildUserTypeCard(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6C7FFF), size: 30),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.work_outline, color: Color(0xFF6C7FFF), size: 30),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Type",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Chip(
                  label: Text(
                    (userData!['userType'] ?? 'job_seeker').toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xFF6C7FFF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(userData: userData!),
      ),
    ).then((_) => _loadUserData());
  }
}

class EditProfileScreen extends StatefulWidget {
  final Map<dynamic, dynamic> userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Add edit form implementation here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      body: const Center(
        child: Text('Edit Profile Implementation'),
      ),
    );
  }
}