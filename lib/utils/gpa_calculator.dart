import '../models/course.dart';

class GPACalculator {
  // Mapping of letter grades to GPA values
  static const Map<String, double> gradeValues = {
    'A+': 4.0, 'A': 4.0, 'A-': 3.7,
    'B+': 3.3, 'B': 3.0, 'B-': 2.7,
    'C+': 2.3, 'C': 2.0, 'C-': 1.7,
    'D+': 1.3, 'D': 1.0,  'D-':0.7,
    'E': 0.0,
  };

  // Function to calculate GPA
  static double calculateGPA(List<Course> courses) {
    double totalGradePoints = 0.0;
    int totalCredits = 0;

    for (var course in courses) {
      if (gradeValues.containsKey(course.grade)) {
        double gradePoint = gradeValues[course.grade]!; // Get GPA value
        totalGradePoints += gradePoint * course.credits;
        totalCredits += course.credits;
      }
    }

    // Prevent division by zero
    return (totalCredits > 0) ? totalGradePoints / totalCredits : 0.0;
  }
}



