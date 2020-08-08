import 'package:flutter/material.dart';
import 'package:storytellers/live_screen.dart';

class RoleSelect extends StatefulWidget {
  @override
  _RoleSelectState createState() => _RoleSelectState();
}

class _RoleSelectState extends State<RoleSelect> {
  void _goToLiveView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiveScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Choose your parts",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          CharacterCell("Charlie", "Me"),
          CharacterCell("Willy Wonka", "Uncle Jim"),
          CharacterCell("Augustus Gloop", "Aunt Liz"),
          SizedBox(height: 25),
          GestureDetector(
            onTap: _goToLiveView,
            child: Container(
              // color: Colors.blueAccent,
              decoration: BoxDecoration(
                  color: Colors.greenAccent[400],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.all(22),
              child: Text(
                "Start story",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class CharacterCell extends StatelessWidget {
  final String characterName;
  final String personName;
  const CharacterCell(this.characterName, this.personName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              // border: BoxBorder(),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 30),
              Text(
                characterName,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "Choose who you will play in the story",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                personName,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
