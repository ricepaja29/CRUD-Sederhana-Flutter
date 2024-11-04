import 'package:flutter/material.dart';
import 'package:frontend/services/Api.dart';

class DeleteScreen extends StatefulWidget {
  @override
  DeleteScreenState createState() => DeleteScreenState();
}

class DeleteScreenState extends State<DeleteScreen> {
  List<dynamic> personData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPersonData();
  }

  // Fungsi untuk mengambil data dari API
  void fetchPersonData() async {
    var data = await Api.getperson();
    setState(() {
      personData = data['persons'] ?? [];
      isLoading = false;
    });
  }

  // Fungsi untuk menghapus data berdasarkan ID
  void deletePerson(int id) async {
    await Api.deletePerson(id);
    fetchPersonData(); // Refresh data setelah menghapus
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Person Data'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : personData.isEmpty
              ? Center(child: Text("No person data available."))
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: personData.length,
                    itemBuilder: (context, index) {
                      final person = personData[index];
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
                          leading: Icon(Icons.person),
                          trailing: IconButton(
                            onPressed: () {
                              // Konfirmasi sebelum menghapus
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Hapus Data"),
                                    content: Text(
                                        "Apakah Anda yakin ingin menghapus data ini?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Batal"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deletePerson(person['id']);
                                        },
                                        child: Text("Hapus"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
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
