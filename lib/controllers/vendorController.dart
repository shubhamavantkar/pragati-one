import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to create a vendor and return the response
Future<Map<String, dynamic>> createVendor({
  required String vendorName,
  required String mobileNumber,
  required String email,
  required String vendorType,
  required List<Map<String, dynamic>> assignedWorkPackages,
}) async {
  final String baseUrl = "{{URL}}"; // Replace with your actual base URL
  final url = Uri.parse('$baseUrl/vendor/create');

  // Prepare the dynamic vendor data
  final Map<String, dynamic> vendorData = {
    "vendorName": vendorName,
    "mobileNumber": mobileNumber,
    "email": email,
    "vendorType": vendorType,
    "assignedWorkPackages": assignedWorkPackages,
  };

  try {
    // Send the POST request to create the vendor
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(vendorData),
    );

    // Handle the response
    if (response.statusCode == 201) {
      // Return the successful response body as a Map
      return {
        'status': 'success',
        'message': 'Vendor created successfully',
        'data': json.decode(response.body),
      };
    } else {
      // Return error response with message
      return {
        'status': 'error',
        'message': 'Failed to create vendor: ${response.statusCode}',
        'data': json.decode(response.body),
      };
    }
  } catch (e) {
    // Handle any error in the process and return the error response
    return {
      'status': 'error',
      'message': 'Error creating vendor: $e',
      'data': {},
    };
  }
}
