class globals {
   static String? currentUserId;
   static String? userName;
   static String? userEmail;
   static String? userPhone;
   static String? userAddress;
   static String userType = 'job_seeker';
}
class Job {
   final String id;
   final String title;
   final String company;
   final String location;
   final String salary;
   final String type;
   bool isApplied;

   Job({
      required this.id,
      required this.title,
      required this.company,
      required this.location,
      required this.salary,
      required this.type,
      this.isApplied = false,
   });
}
