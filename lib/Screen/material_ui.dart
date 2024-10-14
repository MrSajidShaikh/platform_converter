import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/add_user.dart';
import '../Constants/call_screen.dart';
import '../Constants/chat_screen.dart';
import '../Constants/setting_screen.dart';
import '../Provider/platform_change_provider.dart';

class MaterialUi extends StatelessWidget {
  const MaterialUi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Platform Converter'),
          actions: [
            Consumer<PlatformChangeProvider>(builder: (context, value, child) {
              return Switch(
                value: value.isIos,
                onChanged: (value) {
                  Provider.of<PlatformChangeProvider>(context, listen: false)
                      .toggleBetweenPlatforms();
                },
              );
            }),
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: Icon(Icons.account_circle),
              ),
              Tab(text: 'CHATS'),
              Tab(text: 'CALLS'),
              Tab(text: 'SETTINGS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddUsers(),
            ChatScreen(),
            CallScreen(),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}
