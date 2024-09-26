import 'dart:convert';
import 'dart:math';
import 'package:demopro/service/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../components/plan.dart';
import '../model/JsonPlan/json_plan.dart';

class PlanningPermissionApi {
  final String apiUrl =
      "https://www.bathnes.gov.uk/webapi/api/PlanningAPI/v2/planningdata/search/";

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of the Earth in kilometers
    final latDistance = _degreesToRadians(lat2 - lat1);
    final lonDistance = _degreesToRadians(lon2 - lon1);

    final a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<Iterable<Plan>> getPlansNearLocation() async {
    // Define headers
    Map<String, String> headers = {
      'User-Agent':
          'Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0',
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

    var location = await LocationService.findLocation();

    String body = jsonEncode({"address": "23"});

    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body, // Set the body
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Successfully processed request
      var utf8Body = utf8.decode(response.bodyBytes);
      var myMap = jsonDecode(utf8Body) as List<dynamic>;

      var jsonPlans = myMap.map((e) => JsonPlan.fromJson(e));
      // 51.40005, -2.42022 - 51.34990, -2.31984
      var currentLocation = await Location().getLocation();
      var filteredLocationPlans = jsonPlans.where((JsonPlan element) =>
          calculateDistance(element.latitude, element.longitude,
              currentLocation.latitude!, currentLocation.longitude!) <
          5);

      print(jsonPlans.length);
      print(filteredLocationPlans.length);

      var rows = filteredLocationPlans.map((e) => Plan(
            address: e.address ?? "No address",
            reference: e.refval!,
            status: e.dcstat!,
            dataReceived: e.dateactcom?.toString() ?? "No date",
            proposal: e.proposal!,
          ));

      return rows;
    } else {
      // Error handling
      throw Exception('Failed to fetch planning data');
    }
  }

  PlanningPermissionApi();
}
