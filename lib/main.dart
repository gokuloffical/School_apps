import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const LoginPage(),
    );
  }
}

// ---------------- LOGIN ----------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username र password राख्नुहोस्।'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 90,
                color: Colors.indigo,
              ),
              const SizedBox(height: 20),
              const Text(
                'My School',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Student Login'),
              const SizedBox(height: 35),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: login,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- HOME ----------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final pages = const [
    DashboardPage(),
    SubjectsPage(),
    HomeworkPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My School'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NoticesPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Subjects',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Homework',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------------- DASHBOARD ----------------

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: const Text(
                'Welcome, Student!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Class 10 - Section A'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _menuCard(
                context,
                Icons.calendar_month,
                'Timetable',
                const TimetablePage(),
              ),
              _menuCard(
                context,
                Icons.campaign,
                'Notices',
                const NoticesPage(),
              ),
              _menuCard(
                context,
                Icons.bar_chart,
                'Results',
                const ResultsPage(),
              ),
              _menuCard(
                context,
                Icons.check_circle,
                'Attendance',
                const AttendancePage(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school),
              title: Text('Mathematics'),
              subtitle: Text('10:00 AM - Room 204'),
              trailing: Text('Today'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.science),
              title: Text('Science'),
              subtitle: Text('12:00 PM - Lab 1'),
              trailing: Text('Today'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.indigo),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- SUBJECTS ----------------

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  final subjects = const [
    ['Mathematics', 'Mr. Sharma', Icons.calculate],
    ['Science', 'Mrs. Rai', Icons.science],
    ['English', 'Mr. Thapa', Icons.language],
    ['Nepali', 'Mrs. Gurung', Icons.menu_book],
    ['Computer', 'Mr. KC', Icons.computer],
    ['Social Studies', 'Mrs. Lama', Icons.public],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(subject[2] as IconData),
            ),
            title: Text(subject[0] as String),
            subtitle: Text(subject[1] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}

// ---------------- HOMEWORK ----------------

class HomeworkPage extends StatelessWidget {
  const HomeworkPage({super.key});

  final homework = const [
    ['Mathematics', 'Complete Exercise 5.2', 'Tomorrow'],
    ['Science', 'Prepare Chapter 4 notes', 'Friday'],
    ['English', 'Write an essay', 'Sunday'],
    ['Computer', 'HTML assignment', 'Monday'],
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homework.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(homework[index][0]),
            subtitle: Text(homework[index][1]),
            trailing: Text(
              homework[index][2],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

// ---------------- TIMETABLE ----------------

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  final timetable = const [
    ['Sunday', 'Mathematics', '9:00 AM'],
    ['Sunday', 'English', '10:00 AM'],
    ['Monday', 'Science', '9:00 AM'],
    ['Monday', 'Computer', '11:00 AM'],
    ['Tuesday', 'Nepali', '9:00 AM'],
    ['Tuesday', 'Social Studies', '12:00 PM'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timetable')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: timetable.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(timetable[index][1]),
              subtitle: Text(timetable[index][0]),
              trailing: Text(timetable[index][2]),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- NOTICES ----------------

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  final notices = const [
    ['School Holiday', 'School will remain closed on Friday.'],
    ['Exam Notice', 'First terminal examination starts next week.'],
    ['Sports Day', 'Annual sports day will be held this month.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notices')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.campaign),
              title: Text(
                notices[index][0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(notices[index][1]),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- RESULTS ----------------

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  final results = const [
    ['Mathematics', 'A+'],
    ['Science', 'A'],
    ['English', 'A+'],
    ['Nepali', 'A'],
    ['Computer', 'A+'],
    ['Social Studies', 'A'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.bar_chart),
              title: Text(results[index][0]),
              trailing: Text(
                results[index][1],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- ATTENDANCE ----------------

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 65,
              child: Text(
                '92%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Overall Attendance',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const Card(
              child: ListTile(
                title: Text('Present'),
                trailing: Text('46 days'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Absent'),
                trailing: Text('4 days'),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text('Total School Days'),
                trailing: Text('50 days'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- PROFILE ----------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 55,
            child: Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 15),
          const Text(
            'Student Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('Class 10 - Section A'),
          const SizedBox(height: 25),
          const Card(
            child: ListTile(
              leading: Icon(Icons.badge),
              title: Text('Student ID'),
              subtitle: Text('STU-001'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('student@example.com'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('98XXXXXXXX'),
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
