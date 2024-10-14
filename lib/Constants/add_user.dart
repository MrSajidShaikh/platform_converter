import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/my_cupertino_textfield.dart';
import '../Components/my_textfield.dart';
import '../Provider/platform_change_provider.dart';
import '../Provider/theme_provider.dart';
import '../provider/platform_provider.dart';

class AddUsers extends StatelessWidget {
  const AddUsers({super.key});

  @override
  Widget build(BuildContext context) {
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    var platformProviderFalse =
    Provider.of<PlatFormProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (Provider.of<PlatformChangeProvider>(context).isIos) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
              SizedBox(
                height: height * 0.02,
              ),
              MyCupertinoTextField(
                icons: CupertinoIcons.person_add,
                placeholder: 'Name',
                controller: platformProviderTrue.txtName,
              ),
              SizedBox(
                height: height * 0.025,
              ),
              MyCupertinoTextField(
                textInputType: TextInputType.phone,
                icons: CupertinoIcons.phone,
                placeholder: 'Phone',
                controller: platformProviderTrue.txtPhone,
              ),
              SizedBox(
                height: height * 0.025,
              ),
              MyCupertinoTextField(
                icons: CupertinoIcons.chat_bubble_2,
                placeholder: 'Chat Conversation',
                controller: platformProviderTrue.txtChatConversation,
              ),
              SizedBox(
                height: height * 0.025,
              ),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: height * 0.3,
                      color: Provider.of<ThemeController>(context).isDark
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (value) {
                          platformProviderFalse.addDateForCupertino(value);
                        },
                      ),
                    ),
                  );
                },
                leading: const Icon(CupertinoIcons.calendar),
                title: Consumer<PlatFormProvider>(
                    builder: (context, value, child) {
                      return Text((value.date == '') ? 'Pick Date' : value.date);
                    }),
              ),
              CupertinoListTile(
                padding: EdgeInsets.zero,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: height * 0.3,
                      color: Provider.of<ThemeController>(context).isDark
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (value) {
                          platformProviderFalse.addTimeForCupertino(value);
                        },
                      ),
                    ),
                  );
                },
                leading: const Icon(CupertinoIcons.time),
                title: Consumer<PlatFormProvider>(
                    builder: (context, value, child) {
                      return Text((value.time == '') ? 'Pick Time' : value.time);
                    }),
              ),
              SizedBox(
                height: height * 0.23,
              ),
              CupertinoButton(
                onPressed: () {
                  platformProviderFalse.addUserToDatabase(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: (!Provider.of<ThemeController>(context).isDark)
                        ? CupertinoColors.black
                        : CupertinoColors.systemGrey,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  platformProviderFalse.addProfile();
                },
                child: Consumer<PlatFormProvider>(
                  builder: (context, value, child) => CircleAvatar(
                    radius: 50,
                    backgroundImage: (value.profile != '')
                        ? FileImage(
                      File(value.profile),
                    )
                        : const NetworkImage(
                        'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              MyTextField(
                controller: platformProviderTrue.txtName,
                label: 'Name',
                prefixIcon: const Icon(Icons.person_add),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              MyTextField(
                textInputType: TextInputType.phone,
                controller: platformProviderTrue.txtPhone,
                label: 'Phone',
                prefixIcon: const Icon(Icons.call),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              MyTextField(
                controller: platformProviderTrue.txtChatConversation,
                label: 'Chat Conversation',
                prefixIcon: const Icon(Icons.chat_bubble),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      platformProviderFalse.addDate(context);
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                  Consumer<PlatFormProvider>(
                    builder: (context, value, child) => Text(
                      (value.date == '') ? 'Pick Date' : value.date,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      platformProviderFalse.addTime(context);
                    },
                    icon: const Icon(Icons.alarm),
                  ),
                  Consumer<PlatFormProvider>(builder: (context, value, child) {
                    return Text(
                      (value.time == '') ? 'Pick Time' : value.time,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(
                height: height * 0.23,
              ),
              GestureDetector(
                onTap: () async {
                  await platformProviderFalse.addUserToDatabase(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: (!Provider.of<ThemeController>(context).isDark)
                        ? Colors.black
                        : Colors.white54,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
