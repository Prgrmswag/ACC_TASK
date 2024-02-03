import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 29, 239, 239)),
      ),
      home: const MyHomePage(title: 'NGO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String funded = '0';
  String goal = '0';
  String a_funded = '0';
  String a_goal = '0';

//API CALL FOR SMILE FOUNDATION
  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.jsonkeeper.com/b/W694'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if "Records" array exists in the response
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('Records')) {
          final List<dynamic> records = responseData['data']['Records'];

          final List<dynamic> smileCrowdfundingRecords = records
              .where((record) => record['title'] == 'Smile Crowdfunding')
              .toList();

          if (smileCrowdfundingRecords.isNotEmpty) {
            final Map<String, dynamic> latestSmileCrowdfundingData =
                smileCrowdfundingRecords.last;

            print(
                'API Response for Latest Smile Crowdfunding Data: $latestSmileCrowdfundingData');

            setState(() {
              funded = latestSmileCrowdfundingData['collectedValue'].toString();
              goal = latestSmileCrowdfundingData['totalValue'].toString();
            });
          }
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

// API CALL FOR ANIMAL FOUNDATION

  Future<void> fetchAnimalFundingData() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.jsonkeeper.com/b/W694'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('Records')) {
          final List<dynamic> records = responseData['data']['Records'];

          final List<dynamic> animalFundingRecords = records
              .where((record) => record['title'] == 'Animal Funding')
              .toList();

          if (animalFundingRecords.isNotEmpty) {
            final Map<String, dynamic> latestAnimalFundingData =
                animalFundingRecords.last;

            print(
                'API Response for Latest Animal Funding Data: $latestAnimalFundingData');

            setState(() {
              a_funded = latestAnimalFundingData['collectedValue'].toString();
              a_goal = latestAnimalFundingData['totalValue'].toString();
            });
          }
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // For general data fetching
    fetchAnimalFundingData(); // For fetching data related to Animal Funding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.only(right: 140),
              child: Text(
                'Record List ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 450,
                  color: const Color(0xFF1A8FB0),
                ),
                Container(
                  child: Image.asset('assets/img1.jpg'),
                ),
                Positioned(
                  bottom: 150,
                  left: 10,
                  child: Container(
                    width: 250,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Smile Crowdfunding',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 40),
                            Icon(Icons.favorite, color: Colors.red),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This foundation will bring a smile to their faces',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  right: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 7, 59, 101),
                    ),
                    child: const Center(
                      child: Text(
                        '100  %',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 340,
                  child: Row(
                    children: [
                      const Text(
                        '₹',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        funded,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        '₹',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        goal,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 29),
                      const Text(
                        '36',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 360,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Text(
                        'PLEDGE',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 10,
                  top: 400,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'FUNDED',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          SizedBox(width: 24),
                          Text(
                            'GOALS',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          SizedBox(width: 25),
                          Text(
                            'ENDS IN ',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 450, // Adjust height as needed
                  color: const Color(0xFF1A8FB0),
                ),
                Container(
                  child: Image.asset('assets/img2.jpg'),
                ),
                Positioned(
                  bottom: 150,
                  left: 10,
                  child: Container(
                    width: 250,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Animal funding',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 70),
                            Icon(Icons.favorite, color: Colors.red),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'This foundation will help animals',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  right: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 7, 59, 101),
                    ),
                    child: const Center(
                      child: Text(
                        '100  %',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 340,
                  child: Row(
                    children: [
                      const Text(
                        '₹',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        a_funded,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        '₹',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        a_goal,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 40),
                      const Text(
                        '32',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 360,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: const Text(
                        'PLEDGE',
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 10,
                  top: 400,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'FUNDED',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          SizedBox(width: 24),
                          Text(
                            'GOALS',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          SizedBox(width: 25),
                          Text(
                            'ENDS IN ',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
