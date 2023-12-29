import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:my_todo_app/service/todo_service.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchListProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection("todoApp")
      .snapshots()
      .map((event) =>
          event.docs.map((snap) => TodoModel.fromSnapShot(snap)).toList());
  yield* getData;
});
