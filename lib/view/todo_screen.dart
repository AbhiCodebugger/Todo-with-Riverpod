import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_todo_app/provider/service_provider.dart';
import '../common/add_new_task_widget.dart';
import '../widget/card_todo_list_widget.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataProvider = ref.watch(fetchListProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade300,
            radius: 25,
          ),
          title: const Text(
            "Hello I'm",
          ),
          subtitle: const Text(
            "Abhinav Ranjan",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.calendar)),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Task",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Monday, 28 Dec",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade100,
                          foregroundColor: Colors.blue.shade800,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () async => await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          builder: (context) => AddNewTaskModel()),
                      child: const Text("+ New Task"))
                ],
              ),
              const Gap(20),
              ListView.builder(
                  itemCount: dataProvider.value?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CardTodoListWidget(
                        index: index,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
