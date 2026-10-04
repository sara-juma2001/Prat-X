import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:part_time_jobs/checkout.dart';
import 'package:part_time_jobs/global.dart';
import 'package:part_time_jobs/job_details.dart';

class JobListings extends StatefulWidget {
  const JobListings({super.key});

  @override
  State<JobListings> createState() => _JobListingsState();
}

class _JobListingsState extends State<JobListings> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('jobs');
  List<Job> jobListings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  void _loadJobs() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      final List<Job> loadedJobs = [];

      if (data != null) {
        data.forEach((key, value) {
          loadedJobs.add(Job(
            id: key.toString(),
            title: value['title'] ?? 'No Title',
            company: value['company'] ?? 'No Company',
            location: value['location'] ?? 'No Location',
            salary: value['salary'] ?? 'Not Specified',
            type: value['type'] ?? 'Full-Time',
          ));
        });
      }

      if (mounted) {
        setState(() {
          jobListings = loadedJobs;
          _isLoading = false;
        });
      }
    }, onError: (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _toggleApplication(Job job) {
    setState(() {
      job.isApplied = !job.isApplied;
    });
  }

  void _viewJobDetails(Job job) {
    // Get user data from globals
    final userInfo = {
      'Name': globals.userName,
      'Email': globals.userEmail,
      'Phone': globals.userPhone,
      'Address': globals.userAddress,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobCheckoutPage(
          userInfo: userInfo,
          job: job,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int applicationCount = jobListings.where((job) => job.isApplied).length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C7FFF),
        elevation: 0,
        title: const Text(
          "Job Listings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Available Positions",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...jobListings.map((job) => _buildJobCard(job)).toList(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: applicationCount > 0
          ? FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF6C7FFF),
        icon: const Icon(Icons.checklist),
        label: Text("Applications ($applicationCount)"),
      )
          : null,
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => _viewJobDetails(job),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C7FFF),
                    ),
                  ),
                  Chip(
                    label: Text(job.type),
                    backgroundColor: const Color(0xCAD9E5FF),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                job.company,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(job.location),
                  const Spacer(),
                  const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(job.salary),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}