import 'package:flutter/material.dart';
import 'package:frontend/services/Api.dart';
import 'package:frontend/edit_data.dart'; // Import the edit data screen

class UpdateScreen extends StatefulWidget {
  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  List<dynamic> personData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPersonData();
  }

  void fetchPersonData() async {
    var data = await Api.getperson();
    print('Data from API: $data'); // Debugging line to verify structure of API response
    setState(() {
      personData = data['persons'] ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Person Data'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : personData.isEmpty
              ? Center(child: Text("No person data available."))
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent],
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: personData.length,
                    itemBuilder: (context, index) {
                      final person = personData[index];
                      print('Person: $person'); // Debugging line to check individual person data
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text("Nama: ${person['nama']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NIM: ${person['nim']}"),
                              Text("Jurusan: ${person['jurusan']}"),
                            ],
                          ),
                          leading: Icon(Icons.person_2),
                          trailing: IconButton(
                            onPressed: () {
                              // Navigate to EditDataScreen when the edit icon is clicked
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditDataScreen(
                                    initialName: person['nama'],
                                    initialNIM: person['nim'],
                                    initialJurusan: person['jurusan'],
                                    id: person['id'], // Mengirim ID
                                    onUpdate: () {
                                      // Memanggil fetchPersonData untuk memperbarui daftar
                                      fetchPersonData();
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: const Color.fromARGB(255, 128, 118, 118),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}