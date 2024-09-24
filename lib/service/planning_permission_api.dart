import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanningPermissionApi {
  final String apiUrl = "https://www.bathnes.gov.uk/webapi/api/PlanningAPI/v2/planningdata/search/";

  Future<http.Response> searchPlanningData() async {
    // Define headers
    Map<String, String> headers = {
      'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0',
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'Accept-Language': 'en-US,en;q=0.5',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'no-cors',
      'Sec-Fetch-Site': 'same-origin',
      'Content-Type': 'application/json; charset=utf-8',
      'X-Requested-With': 'XMLHttpRequest',
      'Priority': 'u=4',
      'Pragma': 'no-cache',
      'Cache-Control': 'no-cache',
    };

    // Body data as a JSON string
    /*
      "refval": null,
      "address": "23",
      "keyword": null,
      "application_type": null,
      "application_status": null,
      "appeal_status": null,
      "ward": null,
      "parish": null,
      "specialinterest": null,
      "pending": null,
      "application_validated_from": null,
      "application_validated_to": null,
      "actual_commitee_from": null,
      "actual_commitee_to": null,
      "application_decided_from": null,
      "application_decided_to": null,
      "appeal_started_from": null,
      "appeal_started_to": null,
      "appeal_decided_from": null,
      "appeal_decided_to": null
     */
    String body = jsonEncode({
      "address": "23",
    });

    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body, // Set the body
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Successfully processed request
      return response;
    } else {
      // Error handling
      throw Exception('Failed to fetch planning data');
    }
  }

  PlanningPermissionApi();
}