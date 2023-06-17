import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/auth_widgets.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({Key? key}) : super(key: key);

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  bool passwordVisibile = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String name;
  late String email;
  late String password;

  XFile? _imageFile;
  dynamic _pickedImageError;
  final _picker = ImagePicker();

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      _pickedImageError = e;
      setState(() {});
    }
  }

  void _pickImageFromGalery() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      _pickedImageError = e;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const AuthHeaderLabel(headerLabel: 'Sign Up'),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _pickImageFromGalery();
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter name';
                            } else {
                              return null;
                            }
                          },
                          decoration: textFormDecoration,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            } else if (!value.isValidEmail()) {
                              return 'Invalid email';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Enter your email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            } else {
                              return null;
                            }
                          },
                          obscureText: passwordVisibile,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisibile = !passwordVisibile;
                                });
                              },
                              icon: Icon(
                                !passwordVisibile
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ),
                      HaveAccount(
                        haveAccount: 'Already have acount?',
                        actionLabel: 'Log In',
                        onPressed: () {},
                      ),
                      AuthMainButton(
                        mainButtonLabel: 'Sign Up',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(
                              () {
                                name = _nameController.text;
                                email = _emailController.text;
                                password = _passwordController.text;
                                print(name);
                                print(email);
                                print(password);
                              },
                            );
                          } else {
                            SnackbarHandler.showSnackBar(
                                _scaffoldKey, 'Please fill out all fields');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SnackbarHandler {
  static void showSnackBar(_scaffoldKey, text) {
    _scaffoldKey.currentState?.hideCurrentSnackBar();
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.yellow,
        duration: const Duration(seconds: 2),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
