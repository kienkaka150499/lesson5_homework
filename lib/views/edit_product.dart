import 'package:flutter/material.dart';

import '../models/product.dart';

class EditScreen extends StatefulWidget {
 Product? product;
  EditScreen({this.product=null,Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageURLController = TextEditingController();

  String imgURL='';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.product!=null){
      nameController.text = widget.product!.name;
      priceController.text = widget.product!.price.toString();
      descriptionController.text = widget.product!.description;
      imageURLController.text = widget.product!.imageURL;
      imgURL = widget.product!.imageURL;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.product);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        title: Text(widget.product!=null?
          'Edit Product':'Add Product',
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();
                  widget.product = Product(
                      name: nameController.text,
                      imageURL: imageURLController.text,
                      description: descriptionController.text,
                      price: double.tryParse(priceController.text)!);
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const Text(
                      'Expanded',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            backgroundColor: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 1),
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      controller: nameController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty == true) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter is price';
                        }
                        if (double.tryParse(value!) == null) {
                          return 'Please enter is valid number';
                        }
                        if (double.tryParse(value)! <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      controller: descriptionController,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty == true) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.grey)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                imgURL,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, object, StackTrace? strace) {
                                  return const SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.image,
                                      size: 80,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Image URL',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              maxLines: 1,
                              controller: imageURLController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              onChanged: (value){
                                setState((){
                                  imgURL=value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
