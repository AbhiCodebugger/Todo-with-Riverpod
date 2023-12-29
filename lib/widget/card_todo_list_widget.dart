import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  final int index;
  const CardTodoListWidget({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchListProvider);
    return todoData.when(
        data: (todoData) {
          final getCategory = todoData[index].category;
          Color categoryColor = Colors.green;
          switch (getCategory) {
            case "Learning":
              categoryColor = Colors.green;
              break;
            case "Working":
              categoryColor = Colors.blue.shade700;

            case "General":
              categoryColor = Colors.amber.shade700;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            todoData[index].titleTask,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[index].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          subtitle: Text(
                            todoData[index].description,
                            maxLines: 1,
                            style: TextStyle(
                                decoration: todoData[index].isDone
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: CupertinoCheckbox(
                                activeColor: Colors.blue.shade800,
                                shape: const CircleBorder(side: BorderSide()),
                                value: todoData[index].isDone,
                                onChanged: (val) {
                                  ref
                                      .read(serviceProvider)
                                      .updateTask(todoData[index].docID, val);
                                }),
                          ),
                        ),
                        Column(
                          children: [
                            Divider(color: Colors.grey.shade300),
                            Row(
                              children: [
                                Text(todoData[index].dateTask),
                                const Gap(10),
                                Text(todoData[index].timeTask),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      ref
                                          .read(serviceProvider)
                                          .deleteTask(todoData[index].docID);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        error: (err, st) => Text("Error : $err"),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
