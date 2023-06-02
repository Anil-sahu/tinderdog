// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinderdog/RemoteService/authService.dart';
import 'package:tinderdog/view/auth/signin.dart';
import 'package:tinderdog/view/widget/button.dart';
import 'package:tinderdog/view/widget/textField.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
 String emailRegX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  bool loading = false;
  String errorString = "";
  var connetionStatus = false;
  setLoading(bool loading) => setState(() => this.loading = loading);
  startLoading() => setLoading(true);
  stopLoading() => setLoading(false);

  setError(String error) => setState(() => errorString = error);


  bool validateUName() {
    if (_userNameController.text.length < 3) {
      setError("PLease Enter A valid userName");
      return false;
    }
    return true;
  }

  bool validateEmail() {
    if (!RegExp(emailRegX).hasMatch(_emailController.text)) {
      setError("Please Provide A Valid Email");
      return false;
    }
    return true;
  }

  bool validatePassword() {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setError("Password cannot be Empty");
      return false;
    }
    return true;
  }



  bool validateData() =>
      validatePassword() &&
      validateEmail() &&
      validateUName();
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
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                               
                                Image.asset(
                                  "images/logo.png",
                                  height: MediaQuery.of(context).size.width / 2,
                                ),
                             
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextField(
                                          controller: _userNameController,
                                          hintText: 'Username',
                                          isObs: false,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                   
                                        CustomTextField(
                                          controller: _emailController,
                                          hintText: 'Email',
                                          isObs: false,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextField(
                                          controller: _passwordController,
                                          hintText: 'Password',
                                          isObs: true,
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
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: CustomButton(
                                            text: 'Sign up',
                                            onTap: () {
                                              if (!validateData()) return;
                                              setState(() => loading = true);
                                             

                                              AuthonticationService
                                                      .registerUser(_userNameController.text,_emailController.text.trim(),_passwordController.text.trim())
                                                  .whenComplete(() {
                                                setState(() => loading = false);
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextButton(onPressed: (){
                                          Get.to(()=>LoginScreen());
                                        }, child: Text("If You have an account? signIn",style: TextStyle(color: Colors.blueGrey),))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
              child: Center(child: const CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

}
