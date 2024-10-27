// lib/api/api_service.dart
import 'package:dio/dio.dart';
import '../models/note.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://192.168.168.1:8080'),
  );

  Future<List<Note>> getNotes() async {
    try {
      final response = await _dio.get('/products');
      final data = response.data as List;
      return data.map((json) => Note.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Note> createNote(Note note) async {
    try {
      final response = await _dio.post('/products', data: note.toJson());
      return Note.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _dio.put('/products/${note.id}', data: note.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _dio.delete('/products/$id');
    } catch (e) {
      rethrow;
    }
  }
}
