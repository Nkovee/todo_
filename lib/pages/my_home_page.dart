import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/model.dart';
import 'package:flutter_application_2/pages/user_page.dart';
import 'package:flutter_application_2/services/data_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Model> todoList = [];

final futureProviderData = FutureProvider<List<Model>>((ref) async {
  final data = await DataBaseHelper.instance.gettodos();
  return todoList = data;
});

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    ref.read(futureProviderData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userTodoList = ref.watch(futureProviderData);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("ToDo"),
        centerTitle: true,
      ),
      body: userTodoList.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: todoList.length,
                  itemBuilder: ((_, index) {
                    ref.read(futureProviderData);
                    return Card(
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              await DataBaseHelper.instance
                                  .deleteUser(todoList[index].id);
                             final r= ref.refresh(futureProviderData);
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            )),
                        title: Text(todoList[index].name),
                        subtitle: Text(
                          todoList[index].address,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
