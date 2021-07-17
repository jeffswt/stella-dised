import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stella/ui/common.dart';

class Course {
  final String id;
  final String name;
  final List<String> lecturer;
  final String description;
  final String imagePath;
  Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.description,
    required this.imagePath,
  });
}

List<Course> getAllCourses() {
  return [
    Course(
      id: '6.036',
      name: 'Introduction to Machine Learning',
      lecturer: [
        'Prof. Leslie Kaelbling',
        'Prof. Tomás Lozano-Pérez',
        'Prof. Isaac Chuang',
        'Prof. Duane Boning',
      ],
      description: 'This course introduces principles, algorithms, and '
          'applications of machine learning from the point of view of '
          'modeling and prediction. It includes formulation of learning '
          'problems and concepts of representation, over-fitting, and '
          'generalization. These concepts are exercised in supervised '
          'learning and reinforcement learning, with applications to images '
          'and to temporal sequences.',
      imagePath: 'assets/courses/6-036.jpg',
    ),
    Course(
      id: '6.441',
      name: 'Information Theory',
      lecturer: ['Prof. Yury Polyanskiy'],
      description: 'This is a graduate-level introduction to mathematics of '
          'information theory. We will cover both classical and modern '
          'topics, including information entropy, lossless data compression, '
          'binary hypothesis testing, channel coding, and lossy data '
          'compression.',
      imagePath: 'assets/courses/6-441.jpg',
    ),
    Course(
      id: '6.851',
      name: 'Advanced Data Structures',
      lecturer: ['Prof. Erik Demaine'],
      description: 'Data structures play a central role in modern computer '
          'science. You interact with data structures even more often than '
          'with algorithms (think Google, your mail server, and even your '
          'network routers). In addition, data structures are essential '
          'building blocks in obtaining efficient algorithms. This course '
          'covers major results and current directions of research in data '
          'structure.',
      imagePath: 'assets/courses/6-851.jpg',
    ),
    Course(
      id: '6.858',
      name: 'Computer Systems Security',
      lecturer: ['Prof. Nickolai Zeldovich'],
      description: 'Computer Systems Security is a class about the design and '
          'implementation of secure computer systems. Lectures cover threat '
          'models, attacks that compromise security, and techniques for '
          'achieving security, based on recent research papers. Topics '
          'include operating system (OS) security, capabilities, information '
          'flow control, language security, network protocols, hardware '
          'security, and security in web applications.',
      imagePath: 'assets/courses/6-858.jpg',
    ),
  ];
}

class CourseTile extends StatelessWidget {
  final Course course;

  CourseTile({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTile(
      context,
      width: 130.0,
      height: 130.0,
      title: course.name,
      imagePath: course.imagePath,
      onPressed: () {},
    );
  }
}
