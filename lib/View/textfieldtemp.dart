import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextFieldTemp extends StatefulWidget {
  const TextFieldTemp({Key? key}) : super(key: key);

  @override
  _TextFieldTempState createState() => _TextFieldTempState();
}

class _TextFieldTempState extends State<TextFieldTemp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inputField('Username', 'images/mail.svg', usernameController, false,
              () {}, false, usernameFocusNode, true),
          inputField(
            'Password',
            'images/lock.svg',
            passwordController,
            true,
            () {
              setState(() {
                isShowPassword = !isShowPassword;
              });
            },
            isShowPassword,
            passwordFocusNode,
            true,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Perform login logic using the entered username and password
              String username = usernameController.text;
              String password = passwordController.text;
              // Add your authentication logic here
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 45,
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(
    String hint,
    String svgPath,
    TextEditingController controller,
    bool isPass,
    Function fun,
    isShowPass,
    FocusNode focusNode,
    bool isEditable,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            enabled: isEditable,
            style: TextStyle(
              color: controller.text.isNotEmpty ? Colors.black : Colors.black45,
            ),
            controller: controller,
            obscureText: isShowPass,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black),
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SvgPicture.asset(
                  svgPath,
                  height: 10,
                  width: 10,
                  color:
                      controller.text.isNotEmpty ? Colors.grey : Colors.black87,
                ),
              ),
              suffixIcon: isPass
                  ? GestureDetector(
                      onTap: () {
                        fun();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: SvgPicture.asset(
                          'images/eye.svg',
                          height: 10,
                          width: 10,
                          colorFilter: ColorFilter.mode(
                              isShowPass ? Colors.cyan : Colors.black,
                              BlendMode.srcIn),
                          // color: isShowPass ? Colors.cyan : Colors.black,
                        ),
                      ),
                    )
                  : null,
            ),
            focusNode: focusNode,
          ),
        ),
      ),
    );
  }
}
