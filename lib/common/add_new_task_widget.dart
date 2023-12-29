import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/constants/app_style.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/provider/radio_provider.dart';
import 'package:my_todo_app/provider/service_provider.dart';
import 'package:my_todo_app/widget/date_time_widget.dart';
import 'package:my_todo_app/widget/radio_widget.dart';
import 'package:my_todo_app/widget/text_field_widget.dart';

import '../provider/date_time_provider.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });
  final titleController = TextEditingController();
  final descriptionCOntroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: double.infinity,
              child: Text(
                'New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade400,
          ),
          const Text("Title", style: AppStyle.headingone),
          const Gap(6),
          TextFieldWidget(
            controller: titleController,
            hintText: "Add Task Name",
            maxLine: 1,
          ),
          const Gap(12),
          const Text('Description', style: AppStyle.headingone),
          const Gap(6),
          TextFieldWidget(
            controller: descriptionCOntroller,
            hintText: "Description",
            maxLine: 3,
          ),
          const Gap(12),
          const Text('Category', style: AppStyle.headingone),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  valueInput: 1,
                  titleRadio: "LRN",
                  categoryColor: Colors.green,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  valueInput: 2,
                  titleRadio: "WRK",
                  categoryColor: Colors.blue.shade700,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  valueInput: 3,
                  titleRadio: "STD",
                  categoryColor: Colors.amberAccent.shade700,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              ),
            ],
          ),
          Row(
            children: [
              DateTimeWidget(
                  titleText: "Date",
                  icon: CupertinoIcons.calendar,
                  valueText: ref.watch(dateProvider),
                  onTap: () async {
                    final value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025));
                    if (value != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(value));
                    }
                  }),
              const Gap(12),
              DateTimeWidget(
                  titleText: "Time",
                  icon: CupertinoIcons.time,
                  valueText: ref.watch(timeProvider),
                  onTap: () async {
                    final value = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (value != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => value.format(context));
                    }
                  }),
            ],
          ),
          const Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"))),
              const Gap(12),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        final radioValue = ref.read(radioProvider);
                        String category = "";
                        switch (radioValue) {
                          case 1:
                            category = "Learning";
                            break;
                          case 2:
                            category = "Working";
                            break;
                          case 3:
                            category = "General";
                            break;
                        }
                        ref.read(serviceProvider).addNewTask(
                              TodoModel(
                                  titleTask: titleController.text,
                                  description: descriptionCOntroller.text,
                                  category: category,
                                  dateTask: ref.read(dateProvider),
                                  timeTask: ref.read(timeProvider),
                                  isDone: false),
                            );
                        titleController.clear();
                        descriptionCOntroller.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      },
                      child: const Text("Create"))),
            ],
          )
        ],
      ),
    );
  }
}
