import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/my_cupertino_textfield.dart';
import '../Components/my_textfield.dart';
import '../Modal/user_model.dart';
import '../Provider/platform_change_provider.dart';
import '../Provider/theme_provider.dart';
import '../provider/platform_provider.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    var platformProviderFalse =
    Provider.of<PlatFormProvider>(context, listen: false);
    var themeProviderTrue = Provider.of<ThemeController>(context);
    var height = MediaQuery.of(context).size.height;
    if (Provider.of<PlatformChangeProvider>(context).isIos) {
      return FutureBuilder(
        future: platformProviderFalse.readDataFromDatabase(),
        builder: (context, snapshot) {
          List<UserModal> userData = platformProviderTrue.userData
              .map(
                (e) => UserModal.fromMap(e),
          )
              .toList();

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Consumer<PlatFormProvider>(
                  builder: (context, value, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: CupertinoListTile(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Container(
                              width: double.infinity,
                              color: themeProviderTrue.isDark
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: (userData[index].profile ==
                                          'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                          ? NetworkImage(userData[index].profile)
                                          : FileImage(
                                        File(userData[index].profile),
                                      ),
                                      radius: 50,
                                    ),
                                    SizedBox(
                                      height: height * 0.004,
                                    ),
                                    Text(
                                      userData[index].name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.002,
                                    ),
                                    Text(
                                      userData[index].chatConversation,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            value.txtChatConversation.text =
                                                userData[index].chatConversation;
                                            value.txtName.text =
                                                userData[index].name;
                                            value.txtPhone.text =
                                                userData[index].phone;
                                            value.profile = userData[index].profile;
                                            Navigator.pop(context);
                                            showCupertinoDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoAlertDialog(
                                                    title: const Text('Update User'),
                                                    actions: [
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              platformProviderFalse
                                                                  .addProfile();
                                                            },
                                                            child: Consumer<
                                                                PlatFormProvider>(
                                                              builder: (context, value,
                                                                  child) =>
                                                                  CircleAvatar(
                                                                    radius: 50,
                                                                    backgroundImage: (value
                                                                        .profile ==
                                                                        'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                                                        ? NetworkImage(
                                                                        value.profile)
                                                                        : FileImage(
                                                                      File(value
                                                                          .profile),
                                                                    ),
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyCupertinoTextField(
                                                            controller:
                                                            platformProviderTrue
                                                                .txtName,
                                                            placeholder: 'Name',
                                                            icons: CupertinoIcons
                                                                .person_add,
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyCupertinoTextField(
                                                            textInputType:
                                                            TextInputType.phone,
                                                            controller:
                                                            platformProviderTrue
                                                                .txtPhone,
                                                            placeholder: 'Phone',
                                                            icons: CupertinoIcons.phone,
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyCupertinoTextField(
                                                            controller:
                                                            platformProviderTrue
                                                                .txtChatConversation,
                                                            placeholder:
                                                            'Chat Conversation',
                                                            icons: CupertinoIcons
                                                                .chat_bubble_2,
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  value.clearAllVar();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  value.updateDataInDb(
                                                                    value.txtName.text,
                                                                    value.txtPhone.text,
                                                                    value
                                                                        .txtChatConversation
                                                                        .text,
                                                                    value.profile,
                                                                    userData[index].id!,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text('OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            value.deleteUserFromDb(index);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: (value.userData[index]['profile'] ==
                              'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                              ? NetworkImage(value.userData[index]['profile'])
                              : FileImage(
                            File(value.userData[index]['profile']),
                          ),
                        ),
                        title: Text(value.userData[index]['name']),
                        subtitle: Text(value.userData[index]['chatConversation']),
                        trailing: Text(
                            '${value.userData[index]['date']}, ${value.userData[index]['time']}'),
                      ),
                    );
                  });
            },
          );
        },
      );
    } else {
      return FutureBuilder(
        future: platformProviderFalse.readDataFromDatabase(),
        builder: (context, snapshot) {
          List<UserModal> userData = platformProviderTrue.userData
              .map(
                (e) => UserModal.fromMap(e),
          )
              .toList();

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Consumer<PlatFormProvider>(
                  builder: (context, value, child) {
                    return ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: (userData[index].profile ==
                                        'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                        ? NetworkImage(userData[index].profile)
                                        : FileImage(
                                      File(userData[index].profile),
                                    ),
                                    radius: 50,
                                  ),
                                  SizedBox(
                                    height: height * 0.004,
                                  ),
                                  Text(
                                    userData[index].name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.002,
                                  ),
                                  Text(
                                    userData[index].chatConversation,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          value.txtChatConversation.text =
                                              userData[index].chatConversation;
                                          value.txtName.text = userData[index].name;
                                          value.txtPhone.text =
                                              userData[index].phone;
                                          value.profile = userData[index].profile;
                                          Navigator.pop(context);
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) =>
                                                SingleChildScrollView(
                                                  child: AlertDialog(
                                                    title: const Text('Update User'),
                                                    actions: [
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              platformProviderFalse
                                                                  .addProfile();
                                                            },
                                                            child: Consumer<
                                                                PlatFormProvider>(
                                                              builder: (context, value,
                                                                  child) =>
                                                                  CircleAvatar(
                                                                    radius: 50,
                                                                    backgroundImage: (value
                                                                        .profile ==
                                                                        'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                                                        ? NetworkImage(
                                                                        value.profile)
                                                                        : FileImage(
                                                                      File(value
                                                                          .profile),
                                                                    ),
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyTextField(
                                                            controller:
                                                            platformProviderTrue
                                                                .txtName,
                                                            label: 'Name',
                                                            prefixIcon: const Icon(Icons.person_add),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyTextField(
                                                            textInputType:
                                                            TextInputType.phone,
                                                            controller:
                                                            platformProviderTrue
                                                                .txtPhone,
                                                            label: 'Phone',
                                                            prefixIcon: const Icon(Icons.call),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          MyTextField(
                                                            controller:
                                                            platformProviderTrue
                                                                .txtChatConversation,
                                                            label: 'Chat Conversation',
                                                            prefixIcon: const Icon(Icons.chat_bubble),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  value.clearAllVar();
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  value.updateDataInDb(
                                                                    value.txtName.text,
                                                                    value.txtPhone.text,
                                                                    value
                                                                        .txtChatConversation
                                                                        .text,
                                                                    value.profile,
                                                                    userData[index].id!,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text('OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          value.deleteUserFromDb(index);
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: (value.userData[index]['profile'] ==
                            'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                            ? NetworkImage(value.userData[index]['profile'])
                            : FileImage(
                          File(value.userData[index]['profile']),
                        ),
                      ),
                      title: Text(value.userData[index]['name']),
                      subtitle: Text(value.userData[index]['chatConversation']),
                      trailing: Text(
                          '${value.userData[index]['date']}, ${value.userData[index]['time']}'),
                    );
                  });
            },
          );
        },
      );
    }
  }
}
