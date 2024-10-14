import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Provider/theme_provider.dart';

class MyCupertinoTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final IconData icons;
  final TextInputType? textInputType;

  const MyCupertinoTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.icons,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
      placeholder: placeholder,
      keyboardType: textInputType,
      style: TextStyle(
        color: Provider.of<ThemeController>(context).isDark
            ? CupertinoColors.white
            : CupertinoColors.black,
      ),
      controller: controller,
      prefix: Icon(icons),
      decoration: BoxDecoration(
        border: Border.all(
          color: (Provider.of<ThemeController>(context).isDark)
              ? CupertinoColors.white
              : CupertinoColors.darkBackgroundGray,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}