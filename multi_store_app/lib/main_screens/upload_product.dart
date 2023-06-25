import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/auth/supplier_login.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String productId;
  String mainCategoryValue = 'men';
  String subcategoryValue = '';
  List<String> imagesUrlList = [];
  List<XFile> imagesListFile = [];
  dynamic _pickedImageError;
  List<DropdownMenuItem<String>>? subcategoryItems;
  final _picker = ImagePicker();
  bool processing = false;

  void pickProductImages() async {
    try {
      final pickedImage = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        imagesListFile = pickedImage;
      });
    } catch (e) {
      _pickedImageError = e;
      setState(() {});
    }
  }

  void uploadProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imagesListFile.isEmpty) {
        SnackbarHandler.showSnackBar(_scaffoldKey, 'Please pick images');
      } else {
        debugPrint('images picked');
        setState(() {
          processing = true;
        });
        try {
          for (var image in imagesListFile) {
            firebase_storage.Reference ref = firebase_storage
                .FirebaseStorage.instance
                .ref('products/${path.basename(image.path)}');
            await ref.putFile(File(image.path)).whenComplete(() async {
              await ref.getDownloadURL().then((value) {
                imagesUrlList.add(value);
              });
            });
          }
          CollectionReference productRef =
              FirebaseFirestore.instance.collection('products');

          productId = const Uuid().v4();

          await productRef.doc(productId).set({
            'productId': productId,
            'mainCategory': mainCategoryValue,
            'subCategory': subcategoryValue,
            'price': price,
            'instock': quantity,
            'productName': productName,
            'productDescription': productDescription,
            'sid': FirebaseAuth.instance.currentUser!.uid,
            'productImages': imagesUrlList,
            'discount': 0,
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      debugPrint('valid');
      debugPrint(price.toString());
      debugPrint(quantity.toString());
      debugPrint(productName);
      debugPrint(productDescription);
      setState(() {
        imagesUrlList = [];
        imagesListFile = [];
        mainCategoryValue = 'men';
        subcategoryValue = '';
        processing = false;
      });
      _formKey.currentState!.reset();
    } else {
      SnackbarHandler.showSnackBar(_scaffoldKey, 'Please fill put all fileds');
    }
  }

  void filterSubcategoryItems() {
    if (mainCategoryValue == 'men') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = men[0];
      }
      subcategoryItems = men
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'women') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = women[0];
      }
      subcategoryItems = women
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'electronics') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = electronics[0];
      }
      subcategoryItems = electronics
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'accessories') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = accessories[0];
      }
      subcategoryItems = accessories
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'shoes') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = shoes[0];
      }
      subcategoryItems = shoes
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'home & garden') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = homeandgarden[0];
      }
      subcategoryItems = homeandgarden
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'beauty') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = beauty[0];
      }
      subcategoryItems = beauty
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'kids') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = kids[0];
      }
      subcategoryItems = kids
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    } else if (mainCategoryValue == 'bags') {
      if (subcategoryValue.isEmpty) {
        subcategoryValue = bags[0];
      }
      subcategoryItems = bags
          .map<DropdownMenuItem<String>>(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.substring(0, 1).toUpperCase() + e.substring(1, e.length),
              ),
            ),
          )
          .toList();
    }
  }

  Widget previewImages() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onLongPress: () {
              imagesListFile.removeAt(index);
              setState(() {});
            },
            child: Image.file(
              File(
                imagesListFile[index].path,
              ),
            ),
          ),
        );
      },
      itemCount: imagesListFile.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    filterSubcategoryItems();
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: imagesListFile.isNotEmpty
                                  ? previewImages()
                                  : const Center(
                                      child: Text(
                                        'You have not\n\n picked images yet',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                            ),
                            imagesListFile.isNotEmpty
                                ? IconButton(
                                    onPressed: () {
                                      imagesListFile = [];
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Select Main Category:'),
                              DropdownButton(
                                value: mainCategoryValue,
                                items: maincateg
                                    .map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.substring(0, 1).toUpperCase() +
                                              e.substring(1, e.length),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    subcategoryValue = '';
                                    mainCategoryValue = value.toString();
                                  });
                                },
                              ),
                              const Text('Select SubCategory:'),
                              DropdownButton(
                                value: subcategoryValue,
                                items: subcategoryItems,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      subcategoryValue = value.toString();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter price';
                        } else if (!value.isValidPrice()) {
                          return 'Invalid price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        price = double.parse(value!);
                      },
                      decoration: textFormDecoration,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter quantity';
                        } else if (!value.isValidQuantity()) {
                          return 'Invalid Quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          textFormDecoration.copyWith(labelText: 'Quantity'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        productName = value!;
                      },
                      decoration: textFormDecoration.copyWith(
                          labelText: 'Product Name'),
                      maxLines: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter product description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        productDescription = value!;
                      },
                      decoration: textFormDecoration.copyWith(
                          labelText: 'Product Description'),
                      maxLines: 3,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  pickProductImages();
                },
                child: const Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
                backgroundColor: Colors.yellow,
              ),
            ),
            FloatingActionButton(
              onPressed: processing
                  ? null
                  : () {
                      uploadProduct();
                    },
              child: processing
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
              backgroundColor: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'Price',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^\d{0,8}(\.\d{1,4})?$').hasMatch(this);
  }
}

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}
