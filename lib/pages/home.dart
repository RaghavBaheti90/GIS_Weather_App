import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gis_weather_app/compnonts/my_textfild.dart';
import 'package:gis_weather_app/pages/weather_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final TextEditingController _City = TextEditingController();

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Center(
              child: Text(
                "Enter The City Name",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade300),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MYTextFidls(
                hintText: "City",
                obscure: false,
                // Creating a TextEditingController instance for capturing city input
                Controller: _City,
              ),
            ),
          ),
          const SizedBox(
            height:
                30, // Adds vertical spacing between the text field and the button
          ),
          ElevatedButton(
            onPressed: () {
              print(
                  _City); // Debugging: prints the current value of _City to console
              String Cityww = _City
                  .text; // Extracts the text from the TextEditingController
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => weather_page(
                          city:
                              Cityww, // Passes the extracted city name to the weather_page
                        )),
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blue), // Button color
                textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 15, color: Colors.black))),
            child: const Text(
              "Search",
              style: TextStyle(color: Colors.black),
            ),
          )
          // Container(
          //   height: 50,
          //   width: 100,
          //   decoration: BoxDecoration(
          //       color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          //   child: InkWell(
          //       onTap: () {}, child: const Center(child: Text("Search"))),
          // )
        ],
      ),
    );
  }
}
