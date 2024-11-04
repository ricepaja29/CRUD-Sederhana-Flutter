import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://localhost:3000/api/";

  // POST API untuk menambah person
  static Future<void> addPerson(Map<String, dynamic> pdata) async {
    var url = Uri.parse(baseUrl + "add_person");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pdata),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Data added successfully: $data");
      } else {
        print("Failed to upload DATA: ${res.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  // GET API untuk mengambil data person
  static Future<Map<String, dynamic>> getperson() async {
    var url = Uri.parse(baseUrl + "get_person");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Data retrieved successfully: $data");
        return data;
      } else {
        print("Failed to retrieve DATA: ${res.reasonPhrase}");
        return {"persons": []};
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return {"persons": []};
    }
  }

  // PUT API untuk memperbarui data person
  static Future<void> updatePerson(int id, Map<String, dynamic> updatedData) async {
    var url = Uri.parse(baseUrl + "update_person/$id");

    try {
      final res = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("Data updated successfully: $data");
      } else if (res.statusCode == 404) {
        print("Person not found: ${res.reasonPhrase}");
      } else {
        print("Failed to update DATA: ${res.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  // DELETE API untuk menghapus person
  static Future<void> deletePerson(int id) async {
    var url = Uri.parse(baseUrl + "delete/$id");

    try {
      final res = await http.delete(url);

      if (res.statusCode == 200) {
        print("Data deleted successfully");
      } else {
        print("Failed to delete DATA: ${res.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }
}
