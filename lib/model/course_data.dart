import 'dart:io';

class CourseData {
  String title;
  String topics;
  Map<File, Map<String, dynamic>> files;

  CourseData({
    required this.title,
    required this.topics,
    required this.files,
  });
}

class CourseDataUpload {
  String title;
  String topics;
  Map<String, Map<String, dynamic>> files;

  CourseDataUpload({
    required this.title,
    required this.topics,
    required this.files,
  });
}
