import 'package:flutter/material.dart';
import '../models/course.dart';
import '../utils/gpa_calculator.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Course> _courses = [
    Course(name: 'Object Oriented Programming', credits: 3, grade: 'B-'),
    Course(name: 'Introductory Calculus', credits: 2, grade: 'B-'),
    Course(name: 'Business Analysis and Software Design', credits: 2, grade: 'A'),
    Course(name: 'Human Factors in Computer system ', credits: 4, grade: 'B'),
    Course(name: 'Computing Fundamentals Cloud', credits: 3, grade: 'A'),
    Course(name: 'Internet Technologies', credits: 2, grade: 'B-'),
  ];

  void _addCourse() {
    setState(() {
      _courses.add(Course(name: '', credits: 0, grade: 'A'));
    });
  }

  void _clearCourses() {
    setState(() {
      _courses.clear();
      _courses.add(Course(name: '', credits: 0, grade: 'A'));
    });
  }

  void _calculateGPA() {
    if (_formKey.currentState!.validate()) {
      double gpa = GPACalculator.calculateGPA(_courses);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(gpa: gpa)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Calculator')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Modify the values and click the Calculate button to use",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 185, 102, 169)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Course (optional)", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Credits", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Grade", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (int index = 0; index < _courses.length; index++)
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _courses[index].name,
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (value) {
                            _courses[index].name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: _courses[index].credits.toString(),
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _courses[index].credits = int.tryParse(value) ?? 0;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty || int.tryParse(value) == null) {
                              return '!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: _courses[index].grade,
                          isExpanded: true,
                          items: GPACalculator.gradeValues.keys
                              .map((grade) => DropdownMenuItem(value: grade, child: Text(grade)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _courses[index].grade = value!;
                            });
                          },
                        ),
                      ),
                    ]),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _addCourse,
              child: Text("+ Add More Courses", style: TextStyle(color: const Color.fromARGB(255, 240, 33, 243))),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateGPA,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 216, 219, 49)),
                    child: Text("Calculate"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clearCourses,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 158, 16, 16)),
                    child: Text("Clear"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






