import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sesuai gambar modul: Collection utama bernama 'todos' (bukan users -> todos)
  CollectionReference get _todosRef {
    return _db.collection('todos');
  }

  // CREATE: Tambah Todo Baru
  Future<void> addTodo(String task) async {
    await _todosRef.add({
      'task': task,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // READ: Mengambil daftar Todo secara real-time
  Stream<List<Todo>> getTodos() {
    return _todosRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
    });
  }

  // UPDATE: Mengubah status selesai (isDone)
  Future<void> updateTodoStatus(String id, bool currentStatus) async {
    await _todosRef.doc(id).update({
      'isDone': !currentStatus,
    });
  }

  // UPDATE: Mengedit task
  Future<void> updateTodo(String id, String newTask) async {
    await _todosRef.doc(id).update({
      'task': newTask,
    });
  }

  // DELETE: Menghapus Todo
  Future<void> deleteTodo(String id) async {
    await _todosRef.doc(id).delete();
  }
}
