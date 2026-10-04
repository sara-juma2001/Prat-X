import 'package:flutter/material.dart';
import 'package:part_time_jobs/checkout.dart';
import 'package:part_time_jobs/global.dart';
import 'package:part_time_jobs/job_listings.dart';
import 'package:part_time_jobs/login_screen.dart';
import 'package:part_time_jobs/my_job.dart';
import 'package:part_time_jobs/profile.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              globals.userName ?? "Guest",
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              globals.userEmail ?? "guest@example.com",
              style: const TextStyle(color: Colors.white70),
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF6C7FFF),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: globals.userName != null
                  ? Text(
                globals.userName![0],
                style: const TextStyle(
                  color: Color(0xFF6C7FFF),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : const Icon(
                Icons.person,
                color: Color(0xFF6C7FFF),
                size: 50,
              ),
            ),
          ),
          const Divider(),

          // Job Listings
          ListTile(
            title: const Text("Job Listings"),
            leading: const Icon(Icons.work_outline),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const JobListings()),
            ),
          ),
          const Divider(),

          // Profile
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(Icons.person),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            ),
          ),
          const Divider(),

          ListTile(
            title: const Text("job Details"),
            leading: const Icon(Icons.work),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyJobsPage()),
            ),
          ),
          const Divider(),

          // Logout
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              // Clear user data
              globals.userName = null;
              globals.userEmail = null;
              globals.userPhone = null;
              globals.userAddress = null;
              globals.currentUserId = null;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}