import 'package:flutter/material.dart';
import 'package:frontend/services/Api.dart';

class DisplayScreen extends StatefulWidget {
  @override
  DisplayScreenState createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen> {
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
        title: Text('Person Data Display'),
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
                      print('Person: $person'); // Debugging line to check individual person data
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                              Icons.person_2,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "Nama: ${person['nama']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NIM: ${person['nim']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Jurusan: ${person['jurusan']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
