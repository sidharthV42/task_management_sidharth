import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final Box myBox = Hive.box("myBox");

  void addData() {
    if (controller.text.isNotEmpty) {
      myBox.add(controller.text);
      controller.clear();
      setState(() {});
    }
  }

  void deleteData(int index) {
    myBox.deleteAt(index);
    setState(() {});
  }

  void editData(int index, String newValue) {
    myBox.putAt(index, newValue);
    setState(() {});
  }

  void logout() {
    final box = Hive.box("myBox");
    box.put("isLoggedIn", false);
    
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => LoginScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataList = myBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Task Manager"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tasks 🔨",
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    addData();
                    print("Tapped Add");
                  },
                  child: Container(
                    width: 90,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.deepPurple,
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataList[index].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          final editController = TextEditingController(
                            text: dataList[index].toString(),
                          );

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Edit Item"),
                                content: TextField(
                                  controller: editController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter new value",
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      editData(index, editController.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Save"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.deepPurple),
                      ),
                      IconButton(
                        onPressed: () => deleteData(index),
                        icon: const Icon(Icons.delete, color: Colors.black45),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
