import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/db_helper.dart';
import '../Modal/user_model.dart';

class PlatFormProvider extends ChangeNotifier {
  String profile = '', date = '', time = '';
  var txtName = TextEditingController();
  var txtCurrentUserName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtChatConversation = TextEditingController();
  var txtCurrentUserChat = TextEditingController();
  List userData = [];
  GlobalKey<FormState> validateKey = GlobalKey();
  bool profileUpdate = false;
  SharedPreferences? sharedPreferences;

  void toggleProfileUpdate() {
    profileUpdate = !profileUpdate;
    notifyListeners();
  }

  Future<void> iniDatabase() async {
    await DatabaseHelper.databaseHelper.database;
  }

  void addDateForCupertino(DateTime value) {
    date = '${value.day}/${value.month}/${value.year}';
    notifyListeners();
  }

  void addTimeForCupertino(DateTime value) {
    time = '${value.hour % 12}:${value.minute} PM';
    notifyListeners();
  }

  Future<void> addDate(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime(1937),
      lastDate: DateTime.now(),
    );
    date = '${dateTime!.day}/${dateTime.month}/${dateTime.year}';
    notifyListeners();
  }

  Future<void> addTime(BuildContext context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    time =
    '${timeOfDay!.hour % 12}:${timeOfDay.minute} ${timeOfDay.period.name.toUpperCase()}';
    notifyListeners();
  }

  Future<void> addProfile() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    FileImage fileImage = FileImage(File(xFile!.path));
    profile = fileImage.file.path;
    notifyListeners();
  }

  Future<void> addUserToDatabase(BuildContext context) async {
    if (txtName.text.isNotEmpty) {
      if (txtPhone.text.isNotEmpty) {
        if (txtChatConversation.text.isNotEmpty) {
          if (date.isNotEmpty) {
            if (time.isNotEmpty) {
              await DatabaseHelper.databaseHelper.addUserToDatabase(
                name: txtName.text,
                phone: txtPhone.text,
                chatConversation: txtChatConversation.text,
                profile: (profile.isNotEmpty && profile != '')
                    ? profile
                    : 'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png',
                date: date,
                time: time,
              );
              toMap(
                UserModal(
                  name: txtName.text,
                  phone: txtPhone.text,
                  chatConversation: txtChatConversation.text,
                  profile: profile,
                  date: date,
                  time: time,
                ),
              );
              clearAllVar();
              readDataFromDatabase();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pick Time'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pick Date'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enter chat conversation'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter Phone Number'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter name'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<List<Map<String, Object?>>> readDataFromDatabase() async {
    return userData =
    await DatabaseHelper.databaseHelper.readDataFromDatabase();
  }

  Future<void> deleteUserFromDb(int index) async {
    await DatabaseHelper.databaseHelper
        .deleteUserFromDatabase(userData[index]['id']);
    notifyListeners();
  }

  Future<void> updateDataInDb(String name, String phone,
      String chatConversation, String profile, int id) async {
    await DatabaseHelper.databaseHelper.updateNameInDatabase(
      name,
      phone,
      chatConversation,
      profile,
      id,
    );
    clearAllVar();
  }

  void clearAllVar() {
    txtName.clear();
    txtPhone.clear();
    txtChatConversation.clear();
    time = '';
    date = '';
    profile = '';
    txtCurrentUserChat.clear();
    txtCurrentUserName.clear();
    notifyListeners();
  }

  PlatFormProvider() {
    iniDatabase();
  }
}
