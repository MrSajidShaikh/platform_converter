import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Provider/platform_change_provider.dart';
import '../Utils/tab_view.dart';

class CupertinoUi extends StatelessWidget {
  const CupertinoUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Platform Converter'),
        trailing:
        Consumer<PlatformChangeProvider>(builder: (context, value, child) {
          return CupertinoSwitch(
            value: value.isIos,
            onChanged: (value) {
              Provider.of<PlatformChangeProvider>(context, listen: false)
                  .toggleBetweenPlatforms();
            },
          );
        }),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index) => SafeArea(
          child: CupertinoPageScaffold(
            child: tabViewList[index],
          ),
        ),
      ),
    );
  }
}