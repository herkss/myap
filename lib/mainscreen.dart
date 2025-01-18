import 'package:flutter/material.dart';
import 'package:myapp/addtask.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//~~~~~~~~~~~~~~~~~~
  List<String> todoList = [];
//~~~~~~~~~~~~~~~~~~~~~~~~~
  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                '중복일정!',
                style: TextStyle(fontSize: 10),
              ),
              content: const Text('중복되는일정입니다!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('닫기'))
              ],
            );
          });
      return;
    }

    setState(() {
      todoList.insert(0, todoText);
    });
    writeLocalData();
    Navigator.pop(context);
  }

//~~~~~~~~~~~~~~~~

  void writeLocalData() async {
// Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todoList', todoList);
// Save an list of strings to 'items' key.
  }
//~~~~~~~~~~~~~~~~

  void loadLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

//~~~~~~~~~~~~~~~~~~~~~~
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: 250,
          child: Drawer(
              child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("HERKS"),
                accountEmail: const Text("codingchefdev@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset("lib/images/1.jpg"),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://www.youtube.com/@codingchef"));
                },
                leading: const Icon(Icons.youtube_searched_for_rounded),
                title: const Text("About me"),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://www.gmail.com"));
                },
                leading: const Icon(Icons.mail_outline_rounded),
                title: const Text("About me"),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://www."));
                },
                leading: const Icon(Icons.shape_line_outlined),
                title: const Text("Share"),
              ),
            ],
          )),
        ),
        appBar: AppBar(
          title: const Text("TODO APP"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: 200,
                          child: AddTask(
                            addTodo: addTodo,
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                todoList.removeAt(index);
                              });
                              writeLocalData();
                              Navigator.pop(context);
                            },
                            child: const Text("삭제하기")),
                      );
                    });
              },
              title: Text(todoList[index]),
            );
          },
        ));
  }
}
