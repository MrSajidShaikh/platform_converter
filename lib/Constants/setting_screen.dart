import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/my_cupertino_textfield.dart';
import '../Components/my_textfield.dart';
import '../Provider/platform_change_provider.dart';
import '../Provider/theme_provider.dart';
import '../provider/platform_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProviderTrue = Provider.of<ThemeController>(context);
    var themeProviderFalse =
    Provider.of<ThemeController>(context, listen: false);
    var platformProviderFalse =
    Provider.of<PlatFormProvider>(context, listen: false);
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    if (Provider.of<PlatformChangeProvider>(context).isIos) {
      return ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: CupertinoListTile(
              leading: const Icon(CupertinoIcons.person_add),
              title: const Text('Profile'),
              subtitle: const Text('Update Profile Data'),
              trailing: CupertinoSwitch(
                value: platformProviderTrue.profileUpdate,
                onChanged: (value) {
                  platformProviderFalse.toggleProfileUpdate();
                },
              ),
            ),
          ),
          (platformProviderTrue.profileUpdate)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Consumer<PlatFormProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          platformProviderFalse.addProfile();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: (value.profile != '')
                              ? FileImage(
                            File(value.profile),
                          )
                              : const NetworkImage(
                              'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                MyCupertinoTextField(
                  placeholder: 'Name',
                  controller: platformProviderTrue.txtCurrentUserName,
                  icons: CupertinoIcons.person_add,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyCupertinoTextField(
                  placeholder: 'Chat Conversation',
                  controller: platformProviderTrue.txtCurrentUserChat,
                  icons: CupertinoIcons.chat_bubble_2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        platformProviderFalse.clearAllVar();
                      },
                      child: const Text('Clear'),
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          )
              : Container(),
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.moon),
            title: const Text('Theme'),
            subtitle: const Text('Change Theme'),
            trailing: CupertinoSwitch(
              value: themeProviderTrue.isDark,
              onChanged: (value) {
                themeProviderFalse.toggleTheme();
              },
            ),
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            subtitle: const Text('Update Profile Data'),
            trailing: Switch(
              value: platformProviderTrue.profileUpdate,
              onChanged: (value) {
                platformProviderFalse.toggleProfileUpdate();
              },
            ),
          ),
          (platformProviderTrue.profileUpdate)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Consumer<PlatFormProvider>(
                  builder: (context, value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          platformProviderFalse.addProfile();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: (value.profile != '')
                              ? FileImage(
                            File(value.profile),
                          )
                              : const NetworkImage(
                              'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  label: 'Name',
                  controller: platformProviderTrue.txtCurrentUserName,
                  prefixIcon: const Icon(Icons.person_add),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  label: 'Chat Conversation',
                  controller: platformProviderTrue.txtCurrentUserChat,
                  prefixIcon: const Icon(Icons.chat_bubble),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        platformProviderTrue.clearAllVar();
                      },
                      child: const Text('Clear'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          )
              : Container(),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            subtitle: const Text('Change Theme'),
            trailing: Switch(
              value: themeProviderTrue.isDark,
              onChanged: (value) {
                themeProviderFalse.toggleTheme();
              },
            ),
          ),
        ],
      );
    }
  }
}
