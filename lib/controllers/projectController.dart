import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectController {
  final String apiUrl =
      'http://api.pragatione.com'; // Replace with your API base URL

  // Method to create a new project
  Future<Map<String, dynamic>> createProject(
      Map<String, dynamic> projectData, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/project'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(projectData),
      );

      print(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception('Failed to create project: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
      return {'success': false, 'error': error.toString()};
    }
  }

  Future<List<Map<String, dynamic>>> getAllProjects(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/project/all'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> projects = jsonDecode(response.body);
        return projects
            .map((project) => project as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Failed to fetch projects: ${response.body}');
      }
    } catch (error) {
      print('Error fetching projects: $error');
      return [];
    }
  }

  // Method to get a specific project by ID
  Future<Map<String, dynamic>> getProjectById(
      String projectId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/projects/$projectId'),
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch project: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Method to update a project by ID
  Future<Map<String, dynamic>> updateProject(
      String projectId, Map<String, dynamic> updatedData, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/projects/$projectId'),
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to update project: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Method to delete a project by ID
  Future<void> deleteProject(String projectId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/projects/$projectId'),
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete project: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Method to assign a supervisor to a project
  Future<Map<String, dynamic>> assignSupervisor(
      String projectId, String supervisorId, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/projects/assign-supervisor'),
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'projectId': projectId,
          'supervisorId': supervisorId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to assign supervisor: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Method to fetch all work orders for a specific project
  Future<List<Map<String, dynamic>>> getAllWorkOrders(
      String projectId, String token) async {
    try {
      print('Fetching work orders for project: $projectId'); // Debug print
      final response = await http.get(
        Uri.parse('$apiUrl/project/$projectId/work-orders'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Work orders API response: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        List<dynamic> workOrders = jsonDecode(response.body);
        var mappedOrders = workOrders
            .map((workOrder) => workOrder as Map<String, dynamic>)
            .toList();
        print('Mapped work orders: $mappedOrders'); // Debug print
        return mappedOrders;
      } else {
        print('API error: ${response.statusCode} - ${response.body}'); // Debug print
        throw Exception('Failed to fetch work orders: ${response.body}');
      }
    } catch (error) {
      print('Exception in getAllWorkOrders: $error'); // Debug print
      throw Exception('Error: $error');
    }
  }

  // Method to fetch a specific work order by ID
  Future<Map<String, dynamic>> getWorkOrderById(
      String projectId, String workOrderId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/projects/$projectId/work-orders/$workOrderId'),
        headers: {
          'Authorization': 'Bearer $token', // Send token for authentication
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch work order: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
