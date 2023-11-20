import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<UserListScreen> {
  final List<Map<String, dynamic>> _allUsers = [
    {
      "id": 1,
      "name": "Abdul Hadi",
    },
    {
      "id": 2,
      "name": "Abrar",
    },
    {
      "id": 3,
      "name": "Ahmad Raza",
    },
    {
      "id": 4,
      "name": "Amir Sohail",
    },
    {
      "id": 5,
      "name": "Aqsa",
    },
    {
      "id": 6,
      "name": "Asif",
    },
    {
      "id": 7,
      "name": "Faisal",
    },
    {
      "id": 8,
      "name": "Abdul Wahab",
    },
    {
      "id": 9,
      "name": "Uzair Mateen",
    },
    {
      "id": 10,
      "name": "Zeeshan",
    },
    {
      "id": 11,
      "name": "Rida",
    },
    {
      "id": 12,
      "name": "Syed Ahmad",
    },
    {
      "id": 13,
      "name": "Waleed Riaz",
    },
    {
      "id": 14,
      "name": "Talha",
    },
    {
      "id": 15,
      "name": "Sawair Arshad",
    },
    {
      "id": 16,
      "name": "Afifa",
    },
    {
      "id": 17,
      "name": "Hazkeel ",
    },
    {
      "id": 18,
      "name": "Khawar",
    },
    {
      "id": 19,
      "name": "Haseeb",
    },
    {
      "id": 20,
      "name": "Haider",
    },
    {
      "id": 21,
      "name": "Umais",
    },
    {
      "id": 22,
      "name": "Tayyab Zaman",
    },
    {
      "id": 14,
      "name": "Talha",
    },
    {
      "id": 15,
      "name": "Sawair Arshad",
    },
    {
      "id": 16,
      "name": "Afifa",
    },
    {
      "id": 17,
      "name": "Hazkeel ",
    },
    {
      "id": 18,
      "name": "Khawar",
    },
    {
      "id": 19,
      "name": "Haseeb",
    },
    {
      "id": 20,
      "name": "Haider",
    },
    {
      "id": 21,
      "name": "Umais",
    },
    {
      "id": 22,
      "name": "Tayyab Zaman",
    },
    {
      "id": 14,
      "name": "Talha",
    },
    {
      "id": 15,
      "name": "Sawair Arshad",
    },
    {
      "id": 16,
      "name": "Afifa",
    },
    {
      "id": 17,
      "name": "Hazkeel ",
    },
    {
      "id": 18,
      "name": "Khawar",
    },
    {
      "id": 19,
      "name": "Haseeb",
    },
    {
      "id": 20,
      "name": "Haider",
    },
    {
      "id": 21,
      "name": "Umais",
    },
    {
      "id": 22,
      "name": "Tayyab Zaman",
    },
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
    } else {
      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Listview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(_foundUsers[index]['name'],
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
