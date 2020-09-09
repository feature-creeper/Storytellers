import 'package:flutter/material.dart';

class Featured extends StatelessWidget {
  final VoidCallback goToDetails;
  const Featured(this.goToDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text("Featured",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemExtent: 110,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: goToDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 105,
                          width: 90,
                          child: Image.asset(
                            "assets/images/rd_cbucket1.jpg",
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Book Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Author",
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 15)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
