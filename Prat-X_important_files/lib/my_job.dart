import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'global.dart';

class Application {
  final String id;
  final String jobId;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String status;
  final dynamic appliedAt;

  Application({
    required this.id,
    required this.jobId,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.status,
    required this.appliedAt,
  });
}

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  List<Application> _applications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  void _loadApplications() {
    final ref = FirebaseDatabase.instance.ref('userApplications/${globals.currentUserId}');

    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      final List<Application> loadedApplications = [];

      if (data != null) {
        data.forEach((key, value) {
          loadedApplications.add(Application(
            id: key.toString(),
            jobId: value['jobId'] ?? '',
            title: value['title'] ?? 'No Title',
            company: value['company'] ?? 'No Company',
            location: value['location'] ?? 'No Location',
            salary: value['salary'] ?? 'Not Specified',
            type: value['type'] ?? 'Full-Time',
            status: value['status'] ?? 'pending',
            appliedAt: value['appliedAt'],
          ));
        });
      }

      if (mounted) {
        setState(() {
          _applications = loadedApplications;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Job Applications'),
        backgroundColor: const Color(0xFF6C7FFF),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _applications.isEmpty
          ? const Center(child: Text('No applications found'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _applications.length,
        itemBuilder: (context, index) {
          final application = _applications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(application.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(application.company),
                  Text(application.location),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(application.status.toUpperCase(),
                        style: TextStyle(
                            color: _getStatusColor(application.status))),
                    backgroundColor: _getStatusBackground(application.status),
                  ),
                ],
              ),
              trailing: Text(application.type),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return const Color(0xFF6C7FFF);
    }
  }

  Color _getStatusBackground(String status) {
    switch (status) {
      case 'approved':
        return Colors.green.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return const Color(0xFFE8EBFF);
    }
  }
}