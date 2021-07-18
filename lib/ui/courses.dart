import 'package:flutter/material.dart';
import 'package:stella/ui/common.dart';
import 'package:stella/ui/neumorph.dart';
import 'package:stella/ui/player.dart';

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
      onPressed: () {
        routePush(
            context, (BuildContext context) => CourseViewRoute(course: course));
      },
    );
  }
}

class CourseViewRoute extends StatelessWidget {
  final Course course;

  CourseViewRoute({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StellaThemeData sTheme = StellaThemeData.defaultLight();
    List<Widget> _bodyChildren = <Widget>[
          Container(
            // Title
            child: Text(
              '${course.id} / ${course.name}',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: sTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            padding: EdgeInsets.only(
              top: sTheme.blockPadding,
              bottom: 12.0,
              left: sTheme.padding.left,
              right: sTheme.padding.right,
            ),
          ),
          Container(
            child: Text(
              course.lecturer.join('\n'),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: sTheme.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.justify,
            ),
            padding: EdgeInsets.only(
              bottom: 24.0,
              left: sTheme.padding.left,
              right: sTheme.padding.right,
            ),
          ),
          Container(
            // Description
            child: Text(
              course.description,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: sTheme.foregroundColor,
                  ),
              textAlign: TextAlign.justify,
            ),
            padding: EdgeInsets.only(
              bottom: 20.0,
              left: sTheme.padding.left,
              right: sTheme.padding.right,
            ),
          ),
        ] +
        _chapters(context) +
        [Container(height: 60)];
    return StellaPageScaffold(
      background: Container(
        child: Image.asset(
          course.imagePath,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        alignment: Alignment.topCenter,
      ),
      body: Column(
        children: _bodyChildren,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      topExtent: 120,
    );
  }

  List<Widget> _chapters(BuildContext context) {
    List<String> rawChapters = [
      "Week 0: Welcome to 6.036",
      "    6.036 Information",
      "    Self-Assessment",
      "Week 1: Basics",
      "    Introduction to ML",
      "    Linear classifiers",
      "    Week 1 Exercises",
      "    Homework 1",
      "Week 2: Perceptrons",
      "    The Perceptron",
      "    Week 2 Exercises",
      "    Week 2 Lab",
      "    Week 2 Homework",
      "Week 3: Features",
      "    Feature representation",
      "    Week 3 Exercises",
      "    Week 3 Lab",
      "    Week 3 Homework",
      "Week 4: Margin Maximization",
      "    Logistic Regression",
      "    Gradient Descent",
      "    Week 4 Exercises",
      "    Week 4 Lab",
      "    Week 4 Homework",
      "Week 5: Regression",
      "    Regression",
      "    Week 5 Exercises",
      "    Week 5 Lab",
      "    Week 5 Homework",
      "Week 6: Neural Networks I",
      "    Neural Networks",
      "    Week 6 Exercises",
      "    Week 6 Lab",
      "    Week 6 Homework",
      "Week 7: Neural Networks II",
      "    Making NN's Work",
      "    Week 7 Exercises",
      "    Week 7 Homework",
      "Week 8: Convolutional Neural Networks",
      "    Convolutional Neural Networks",
      "    Week 8 Exercises",
      "    Week 8 Lab",
      "    Week 8 Homework",
      "Week 9: State Machines and Markov Decision Processes",
      "    Sequential models",
      "    Week 9 Exercises",
      "    Week 9 Lab",
      "    Week 9 Homework",
      "Week 10: Reinforcement Learning",
      "    Reinforcement learning",
      "    Week 10 Exercises",
      "    Week 10 Lab",
      "    Week 10 Homework",
      "Week 11: Recurrent Neural Networks",
      "    Recurrent Neural Networks",
      "    Week 11 Exercises",
      "    Week 11 Lab",
      "    Week 11 Homework",
      "Week 12: Recommender Systems",
      "    Recommender systems",
      "    Week 12 Exercises",
      "    Week 12 Lab",
      "    Week 12 Homework",
      "Week 13: Decision Trees and Nearest Neighbors",
      "    Decision Trees and Nearest Neighbors",
      "    Week 13 Exercises",
      "    Week 13 Lab",
      "Termination",
    ];
    String curChapter = '';
    List<String> buffer = []; // where we store the subchapters
    List<Widget> col = [];
    for (String line in rawChapters) {
      if (line.startsWith(' ')) {
        buffer.add(line.trim());
        continue;
      }
      if (curChapter.isEmpty) {
        curChapter = line;
        continue;
      }
      col.add(_chapter(context, curChapter, buffer));
      curChapter = line;
      buffer.clear();
    }
    return col;
  }

  Widget _chapter(BuildContext context, String chapter, List<String> sections) {
    StellaThemeData sTheme = StellaThemeData.defaultLight();
    Widget _title = Text(
      chapter,
      style: Theme.of(context).textTheme.bodyText1,
      textScaleFactor: 1.2,
    );
    return Container(
      // add margins
      child: NeuContainer(
        // cap
        child: Container(
          // add padding
          child: Column(
            // children
            children: <Widget>[
                  _title,
                ] +
                sections
                    .map<Widget>((section) => _section(context, section))
                    .toList(),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.all(12.0),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: 28.0,
        left: sTheme.padding.left - 8.0,
        right: sTheme.padding.right - 8.0,
      ),
      alignment: Alignment.topLeft,
    );
  }

  Widget _section(BuildContext context, String section) {
    return Container(
      child: NeuButton(
        child: Container(
          child: Text(section),
          padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
        ),
        radius: 8.0,
        elevation: 4.0,
        onPressed: () {
          routePush(
              context,
              (BuildContext context) => PlayerViewRoute(
                    title: section,
                    subtitle: '${course.id} / ${course.name}',
                  ));
        },
      ),
      padding: EdgeInsets.only(top: 12.0, left: 24.0),
    );
  }
}
