import 'package:flutter/material.dart';
import 'package:frontend/services/api.dart';

class CreateScreen extends StatefulWidget {
  @override
  CreateScreenState createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final jurusanController = TextEditingController();
  bool isLoading = false;
  String feedbackMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Person Data"),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main Input Container
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text Fields
                  _buildTextField(namaController, "Nama"),
                  SizedBox(height: 15),
                  _buildTextField(nimController, "NIM"),
                  SizedBox(height: 15),
                  _buildTextField(jurusanController, "Jurusan"),
                  SizedBox(height: 20),
                  // Submit Button with Loading Indicator
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  SizedBox(height: 20),
                  // Feedback Message
                  if (feedbackMessage.isNotEmpty)
                    Text(
                      feedbackMessage,
                      style: TextStyle(
                        color: feedbackMessage.contains("Success") ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }

  void _handleSubmit() async {
    setState(() {
      isLoading = true;
      feedbackMessage = '';
    });

    var data = {
      "nama": namaController.text,
      "nim": nimController.text,
      "jurusan": jurusanController.text,
    };

    try {
      await Api.addPerson(data);
      setState(() {
        feedbackMessage = "Success: Person data added!";
        namaController.clear();
        nimController.clear();
        jurusanController.clear();
      });
    } catch (e) {
      setState(() {
        feedbackMessage = "Error: Unable to add person data.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
