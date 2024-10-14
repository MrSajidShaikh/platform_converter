import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Platform Converter"),
          actions: [
            Switch(
              value: false,
              onChanged: (value) {},
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person_add_alt_1_outlined),
              ),
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'CALLS',
              ),
              Tab(
                text: 'SETTINGS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.add_a_photo_outlined),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Full Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.chat),
                        hintText: 'Chat Conversation',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder()),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month),
                      ),
                      const Text('Pick Date'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.access_time),
                      ),
                      const Text('Pick Time'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  )
                  // const SizedBox(height: 10),
                ],
              ),
            ),
            const Column(),
            const Column(),
            const Column(),
          ],
        ),
      ),
    );
  }
}
