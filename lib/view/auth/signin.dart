// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinderdog/view/auth/signup.dart';
import 'package:tinderdog/view/widget/textField.dart';

import '../../RemoteService/authService.dart';
import '../widget/button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorString = "";

  bool loading = false;
  setLoading(bool loading) => setState(() => this.loading = loading);
  startLoading() => setLoading(true);
  stopLoading() => setLoading(false);

  setError(String error) => setState(() => errorString = error);

  bool validateTextField() {
    final text = _userNameController.value.text;
    if (text.isEmpty && text.length <= 3) return false;
    return true;
  }

  bool validatePassword() => _passwordController.text.isNotEmpty;

  bool validateData() => validateTextField() && validatePassword();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                    
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // alignment: Alignment.bottomRight,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: AppBar().preferredSize.height,
                              ),
                            
                              Image.asset(
                                "images/logo.png",
                                height: 150,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      controller: _userNameController,
                                      hintText: 'Enter email id',
                                      isObs: false,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      controller: _passwordController,
                                      hintText: 'Enter password',
                                      isObs: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      errorString,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: CustomButton(
                                        text: 'Login',
                                        onTap: () {
                                          setState(() => loading = true);
                                          // if (connectionStatus) {
                                          AuthonticationService.login(
                                                  _userNameController.text
                                                      .trim(),
                                                  _passwordController.text
                                                      .trim())
                                              .whenComplete(() {
                                            setState(() => loading = false);
                                          }).whenComplete(() {
                                           
                                          });
                                       
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  
                                    const SizedBox(
                                      height: 40,
                                    ),
                                       TextButton(onPressed: (){
                                          Get.to(()=>RegisterPage());
                                        }, child: Text("If You have an account? signIn",style: TextStyle(color: Colors.blueGrey),))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              color: Colors.grey.shade50.withOpacity(0.4),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

}
