import 'package:flopps/screens/signUp/signUpMain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../entities/users/SignInController.dart';
import '../../utils/ProjectColors.dart';
import '../../utils/Strings.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginFormPortrait extends StatefulWidget {
  const LoginFormPortrait({Key? key,}) : super(key: key);



  @override
  State<LoginFormPortrait> createState() => _LoginFormPortraitState();
}

class _LoginFormPortraitState extends State<LoginFormPortrait> {
  final _formKey = GlobalKey<FormState>();
  final formController = Get.put(SignInController());
  bool isPasswordVisible = true;
  bool isSignInGoogle = false;
  bool isSignInEmail = false;
  bool mailValidated=true;
  bool passwordValidated=true;


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
          const Padding(padding: EdgeInsets.all(15)),
          SizedBox(
            height: mailValidated? 48: 72,
            child: TextFormField(
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
                  setState(() {
                    mailValidated=false;
                  });
                  return Strings.enterText;
                }
                setState(() {
                  mailValidated=true;
                });
                return null;
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(15)),
          SizedBox(
            height: passwordValidated? 48: 72,
            child: TextFormField(
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
                  setState(() {
                    passwordValidated=false;
                  });
                  return Strings.enterText;
                }
                setState(() {
                  passwordValidated=true;
                });
                return null;
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(15)),
          EmailAuthButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                SignInController.instance.loginUserWithPassword(
                    formController.email.text.trim(),
                    formController.password.text.trim());
                setState(() {
                  isSignInEmail=true;
                });
              }
            },
            isLoading: isSignInEmail,

            style: const AuthButtonStyle(
                textStyle: TextStyle(color: Color(0xffffffff))),
            materialStyle: const ButtonStyle(
              elevation: MaterialStatePropertyAll(5),
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )),
                backgroundColor:
                    MaterialStatePropertyAll(Color(ProjectColors.blue)),
              fixedSize: MaterialStatePropertyAll(Size(220, 40)),),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          GoogleAuthButton(
            isLoading: isSignInGoogle,
            onPressed: () {
              SignInController.instance.loginWithGoogle();
              setState(() {
                isSignInGoogle=true;
              });
            },
            style: const AuthButtonStyle(
              textStyle: TextStyle(
                color: Color(0xffffffff)
              )
            ),
            materialStyle: const ButtonStyle(
                elevation: MaterialStatePropertyAll(5),
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )),
                backgroundColor: MaterialStatePropertyAll(
                    Color(ProjectColors.grayBackground)),
                fixedSize: MaterialStatePropertyAll(Size(220, 34))),

          ),
         const Padding(padding: EdgeInsets.all(10)),
         GestureDetector(
           onTap: () {
             Get.off(() => const SignUpMain(),
                 transition: Transition.rightToLeft,
                 duration: const Duration(milliseconds: 500));
           },
           child: const Text.rich(
             TextSpan(
               style: TextStyle(
                 fontFamily: "sourceSansPro",
                 fontWeight: FontWeight.w400,
                 fontSize: 12,
                 color:Color(0xffffffff)
               ),
               text: Strings.notHaveAccount,
               children: [
                 TextSpan(
                   text: Strings.signUpHere, style: TextStyle(
                     fontFamily: "sourceSansPro",
                     fontWeight: FontWeight.w700,
                     fontSize: 14,
                     color:Color(ProjectColors.blue)
                 )
                 ),

               ]
             )
           ),
         )
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
        suffixIconColor: const Color(0xffffffff),
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: "sourceSansPro",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xffefefef)),
        labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "sourceSansPro",
            color: Color(0xffe7e7e7)),
        suffixIcon: hint == Strings.email
            ? IconButton(onPressed: onIconTab, icon: Icon(suffixIcon))
            : IconButton(
                onPressed: onIconTab,
                icon: !isPasswordVisible
                    ? Icon(suffixIcon)
                    : const Icon(FontAwesomeIcons.eyeSlash)),
        label: Text(hint, style:const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "sourceSansPro",
            color: Color(0xffefefef)) ),
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