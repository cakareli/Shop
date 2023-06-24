import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/auth_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegisterScreen extends StatefulWidget {
  const SupplierRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SupplierRegisterScreen> createState() => _SupplierRegisterScreenState();
}

class _SupplierRegisterScreenState extends State<SupplierRegisterScreen> {
  bool passwordVisibile = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late String storeName;
  late String email;
  late String password;
  late String storeLogo;

  XFile? _imageFile;
  dynamic _pickedImageError;
  final _picker = ImagePicker();
  bool processing = false;

  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

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

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try {
          storeName = _nameController.text;
          email = _emailController.text;
          password = _passwordController.text;
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          debugPrint(storeName);
          debugPrint(email);
          debugPrint(password);

          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supplier-images/$email.jpg');
          await ref.putFile(File(_imageFile!.path));
          storeLogo = await ref.getDownloadURL();
          String _uid = FirebaseAuth.instance.currentUser!.uid;
          await suppliers.doc(FirebaseAuth.instance.currentUser!.uid).set({
            'storeName': storeName,
            'email': email,
            'storeLogo': storeLogo,
            'phone': '',
            'address': '',
            'cid': _uid,
            'coverImage': '',
          });
          _formKey.currentState?.reset();
          setState(() {
            _imageFile = null;
          });
          Navigator.pushReplacementNamed(context, '/supplier_login');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            SnackbarHandler.showSnackBar(
                _scaffoldKey, 'The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            SnackbarHandler.showSnackBar(
                _scaffoldKey, 'The account already exists for that email.');
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        SnackbarHandler.showSnackBar(
            _scaffoldKey, 'Please pick an image first');
      }
    } else {
      setState(() {
        processing = false;
      });
      SnackbarHandler.showSnackBar(_scaffoldKey, 'Please fill out all fields');
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.purpleAccent,
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(
                                      File(_imageFile!.path),
                                    ),
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/customer_login');
                        },
                      ),
                      processing
                          ? const CircularProgressIndicator(
                              color: Colors.purple)
                          : AuthMainButton(
                              mainButtonLabel: 'Sign Up',
                              onPressed: () {
                                signUp();
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
