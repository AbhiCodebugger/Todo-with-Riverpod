import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_todo_app/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection("todoApp");

// Create task
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

// Update task
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      "isDone": valueUpdate,
    });
  }

// Delete task
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
