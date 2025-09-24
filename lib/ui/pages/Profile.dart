import 'package:epic_gallery/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/categoryList.dart';
import '../../network/postUser.dart';
import '../../util/Validator.dart';
import '../../util/harshPassword.dart';
import '../components/PasswordField.dart';
import '../components/text_field.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});


  @override
  ConsumerState<Profile> createState()=>_ProfileState();


}

class _ProfileState extends   ConsumerState<Profile>{

  final fullNameControler = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  FocusNode emailFocus = FocusNode();
  FocusNode namefocus = FocusNode();
  FocusNode passFocus = FocusNode();

  FocusNode confirmPassFocus = FocusNode();




  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    var width = MediaQuery
        .of(context)
        .size
        .width / 1.1;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [


                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 800;

                    return Wrap(
                      spacing: 20,
                      runSpacing: 16,
                      children: [

                        Column(
                          children: [
                            const Icon(Icons.account_circle, size: 100,
                                color: Colors.black54),
                            const SizedBox(height: 10),
                            Text(
                             ref.watch(fullName),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),


                        Form(
                          key: _formKey,
                          child:

                          LayoutBuilder(
                            builder: (context, constraints) {
                              bool isWide = constraints.maxWidth > 400;

                              return Wrap(
                                spacing: 20,
                                runSpacing: 16,
                                children: [

                                  MyTextField(
                                    label: 'Full Name',
                                    placeHolder: 'first name last name',
                                    controller: fullNameControler,
                                    icon: Icon(Icons.person),
                                    fieldValidator: Validators
                                        .fullNameValidator,
                                    focusNode: namefocus,
                                    width: width,
                                    onChange:()=>ref.read(fullName.notifier).state=fullNameControler.text,
                                    onSubmit: () {
                                      FocusScope.of(context).requestFocus(
                                          namefocus);
                                    },
                                    inputAction: TextInputAction.next,
                                  ),


                                  MyTextField(
                                    label: 'Email',
                                    placeHolder: 'abc@gmail.com',
                                    controller: emailController,
                                    icon: Icon(Icons.email),
                                    fieldValidator: Validators.emailValidator,
                                    focusNode: emailFocus,
                                    width: width,
                                    onSubmit: () {
                                      FocusScope.of(context).requestFocus(
                                          passFocus);
                                    },
                                    inputAction: TextInputAction.next,
                                  ),



                                  PasswordField(
                                    label: 'Password',
                                    placeHolder: 'Enter your password',
                                    controller: passController,
                                    hidePassword: Icon(Icons.visibility_off),
                                    showPassword: Icon(Icons.visibility),
                                    fieldValidator: Validators
                                        .passwordValidator,
                                    focusNode: passFocus,
                                    width: width,
                                    onSubmit: () {
                                      FocusScope.of(context).requestFocus(
                                          confirmPassFocus);
                                    },
                                    inputAction: TextInputAction.next,
                                  ),
                                  PasswordField(
                                    label: 'Confirm Password',
                                    placeHolder: 'Confirm your password',
                                    controller: confirmPassController,
                                    hidePassword: Icon(Icons.visibility_off),
                                    showPassword: Icon(Icons.visibility),
                                    fieldValidator: (value) =>
                                        Validators.confirmPasswordValidator(
                                            value, passController.text),
                                    focusNode: confirmPassFocus,
                                    width: width,
                                    inputAction: TextInputAction.done,
                                  ),




                                ]
                                    .map((field) =>
                                    SizedBox(
                                      width: isWide ? (constraints.maxWidth /
                                          2) - 30 : double.infinity,
                                      child: field,
                                    ))
                                    .toList(),
                              );
                            },
                          ),

                        ),   Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Select favorite category "),
                            DropdownButton<String>(
                                value: ref.watch(favCategories),
                                items: categories
                                    .map<DropdownMenuItem<String>>((
                                    String fav) {
                                  return DropdownMenuItem<String>(
                                    value: fav,
                                    child: Text(fav),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                   ref.read(favCategories.notifier).state =  newValue!;
                                }),
                          ],
                        ),


                      ]
                          .map((field) =>
                          SizedBox(
                            width: isWide
                                ? (constraints.maxWidth / 2) - 30
                                : double.infinity,
                            child: field,
                          ))
                          .toList(),
                    );
                  },
                ),


                const SizedBox(height: 40),



                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                  if (_formKey.currentState!.validate()) {


                    submitData(fullNameControler.text, emailController.text, hashPassword(passController.text), ref.watch(favCategories), context,ref);

                 if( ref.watch(userCreated)){
                   _formKey.currentState!.reset();
                   // fullNameControler.clear();
                   // emailController.clear();
                   // passController.clear();
                   // confirmPassController.clear();
                   ref.read(userCreated.notifier).state = false;
                 }



                  }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
