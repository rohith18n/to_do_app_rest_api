import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_app_rest_api/data/task_model.dart';

class Api {
  static Future<List<Task>> getTasks() async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=20');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final rawbody = jsonDecode(response.body) as List;
      List<Task> taskList = rawbody.map((e) => Task.fromJson(e)).toList();
      return taskList;
    }
    return [];
  }

  static Future<bool> deleteTask(int id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    final response = await http.delete(url);
    print('delete status code ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> patchTask(Map<String, dynamic> body, id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    final jsonbody = jsonEncode(body);
    final header = {'Content-type': 'application/json; charset=UTF-8'};
    final response = await http.patch(url, body: jsonbody, headers: header);
    print(' Task Updated (patch)');
    print('patch status code ' + response.statusCode.toString());
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> updateTask(Map<String, dynamic> body, id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    final jsonbody = jsonEncode(body);
    final header = {'Content-type': 'application/json; charset=UTF-8'};
    final response = await http.put(url, body: jsonbody, headers: header);
    print(' Task updated (put)');
    print('Put status code ' + response.statusCode.toString());
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
