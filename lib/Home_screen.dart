import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_project5/models/university.dart';
import 'package:flutter_project5/university_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('УНИВЕРСИТЕТТЕР ТІЗІМІ'),
        backgroundColor: Colors.white,  // Белый фон AppBar
        elevation: 0,  // Убираем тень
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(  // Поисковая строка займет все доступное пространство
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) {
                      print('Поиск: $value');
                    },
                  ),
                ),
              //Картинка Filter

                SizedBox(width: 8),  // Закомментировали отступ
                Container(           // Закомментировали контейнер с иконкой
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/filter_icon.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      print('Открыть фильтры');
                    },
                  ),
                ),


                //Картинка Filter
              ],
            ),
          ),
        )
      ),
      backgroundColor: Colors.white,  // Белый фон для всего экрана
      body: UniversitiesListPage(),
    );
  }
}

class UniversitiesListPage extends StatefulWidget {
  @override
  _UniversitiesListPageState createState() => _UniversitiesListPageState();
}

class _UniversitiesListPageState extends State<UniversitiesListPage> {
  List<University> universities = [];

  @override
  void initState() {
    super.initState();
    loadUniversities();
  }

  Future<void> loadUniversities() async {
    final String jsonString = await rootBundle.loadString('univers.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    setState(() {
      universities = jsonList.map((json) => University.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: universities.length,
      itemBuilder: (context, index) {
        final university = universities[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2,
          child: ListTile(
            leading: Image.asset('assets/images/${university.image}'),
            title: Text(university.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(university.city),
                Text(university.phoneNumber),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UniversityScreen(
                    university: university,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
