import 'package:flopps/entities/users/signUp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _LoginMain();
  }
}

class _LoginMain extends StatefulWidget {
  const _LoginMain({Key? key}) : super(key: key);

  @override
  State<_LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<_LoginMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(ProjectColors.lightBlue),
          Color(ProjectColors.strongBlue)
        ], begin: Alignment.topLeft, end: Alignment.topRight)),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .65,
              padding: const EdgeInsets.all(20),
              decoration: formBoxStyle,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(20)),
                    const Text(
                      Strings.login,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: const LoginForm()),
                  ],
                ),
              ))
        ],
      ),
    ]));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final formController = Get.put(SignUpController());
  bool isPasswordVisible = true;

  changePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(20)),
          TextFormField(
            controller: formController.email,
            style: const TextStyle(
                color: Color(0xffffffff), fontWeight: FontWeight.w500),
            keyboardType: TextInputType.emailAddress,
            decoration: textFieldStyle(
                suffixIcon: FontAwesomeIcons.user,
                hint: Strings.email,
                onIconTab: () {}),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Strings.enterText;
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(20)),
          TextFormField(
            controller: formController.password,
            style: const TextStyle(
                color: Color(0xffffffff), fontWeight: FontWeight.w500),
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswordVisible,
            decoration: textFieldStyle(
                suffixIcon: FontAwesomeIcons.eye,
                hint: Strings.password,
                onIconTab: changePasswordVisibility),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Strings.enterText;
              }
              return null;
            },
          ),
          const Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                SignUpController.instance.registerUserWithPassword(
                    formController.email.text.trim(),
                    formController.password.text.trim());
              }
            },
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )),
                backgroundColor:
                    MaterialStatePropertyAll(Color(ProjectColors.blue)),
                minimumSize: MaterialStatePropertyAll(Size(183, 40))),
            child: const Text(Strings.loginPassword),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
            onPressed: () {
              SignUpController.instance.loginWithGoogle();
            },
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )),
                backgroundColor: MaterialStatePropertyAll(
                    Color(ProjectColors.grayBackground)),
                minimumSize: MaterialStatePropertyAll(Size(225, 34))),
            child: const Text(Strings.loginGoogle),
          ),
        ]),
      ),
    );
  }

  InputDecoration textFieldStyle(
      {required IconData suffixIcon,
      required String hint,
      required onIconTab}) {
    return InputDecoration(
        filled: true,
        fillColor: const Color(ProjectColors.grayBackground),
        suffixIconColor: const Color(0xffe2e2e2),
        labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xffe7e7e7)),
        suffixIcon: hint == Strings.email
            ? IconButton(onPressed: onIconTab, icon: Icon(suffixIcon))
            : IconButton(
                onPressed: onIconTab,
                icon: !isPasswordVisible
                    ? Icon(suffixIcon)
                    : const Icon(FontAwesomeIcons.eyeSlash)),
        label: Text(hint),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              style: BorderStyle.solid, color: Color(ProjectColors.blue)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(ProjectColors.blue), width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(ProjectColors.blue),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Color(ProjectColors.blue),
                width: 2)),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(style: BorderStyle.solid, color: Color(0x00f52626)),
        ));
  }
}

var formBoxStyle = const BoxDecoration(
    color: Color(ProjectColors.blackBackground),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    ),
    boxShadow: [
      BoxShadow(
          color: Colors.black12,
          offset: Offset(0, -1),
          spreadRadius: 5,
          blurRadius: 5)
    ]);
