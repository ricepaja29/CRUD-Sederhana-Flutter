import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditDataScreen extends StatelessWidget {
  final String initialName;
  final String initialNIM;
  final String initialJurusan;
  final int id; // Menambahkan ID
  final Function() onUpdate; // Callback untuk pembaruan UI

  EditDataScreen({
    required this.initialName,
    required this.initialNIM,
    required this.initialJurusan,
    required this.id, // Menerima ID
    required this.onUpdate, // Menerima fungsi callback
  });

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: initialName);
    var nimController = TextEditingController(text: initialNIM);
    var jurusanController = TextEditingController(text: initialJurusan);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Edit Data",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: nimController,
                      decoration: InputDecoration(
                        labelText: 'NIM',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: jurusanController,
                      decoration: InputDecoration(
                        labelText: 'Jurusan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        var updatedData = {
                          'nama': nameController.text,
                          'nim': nimController.text,
                          'jurusan': jurusanController.text,
                        };

                        // Ubah URL untuk menggunakan ID
                        var url = Uri.parse('http://localhost:3000/api/update_person/$id');
                        final response = await http.put(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode(updatedData),
                        );

                        if (response.statusCode == 200) {
                          // Jika respons server OK, panggil fungsi callback untuk memperbarui UI
                          onUpdate(); 
                          Navigator.pop(context);
                        } else {
                          // Tangani respons kesalahan
                          print("Failed to update data: ${response.body}");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
