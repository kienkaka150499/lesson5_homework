import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          icon: Icon(
            Icons.chevron_left,
            size: ScreenUtil().setHeight(60),
          ),
        ),
        title: Text(widget.product!=null?
          'Edit Product':'Add Product',
          style: TextStyle(fontSize: ScreenUtil().setHeight(40)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setHeight(30)),
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
              icon: Icon(
                Icons.save,
                color: Colors.white,
                size: ScreenUtil().setHeight(60),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setHeight(20)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(100),
                child: Row(
                  children: [
                    Text(
                      'Expanded',
                      style: TextStyle(fontSize: ScreenUtil().setHeight(40)),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
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
                              fontSize: ScreenUtil().setHeight(30),
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
                            fontSize: ScreenUtil().setHeight(30),
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
                              fontSize: ScreenUtil().setHeight(30),
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
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                        ),
                      ),
                      controller: nameController,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(50),
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty == true) {
                          return 'Title is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                        ),
                      ),
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(50),
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
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                        ),
                      ),
                      controller: descriptionController,
                      style: TextStyle(
                        fontSize: ScreenUtil().setWidth(50),
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
                      height: ScreenUtil().setHeight(200),
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
                                width: ScreenUtil().setWidth(200),
                                height: ScreenUtil().setHeight(200),
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, object, StackTrace? strace) {
                                  return SizedBox(
                                    width: ScreenUtil().setWidth(200),
                                    height: ScreenUtil().setHeight(200),
                                    child: const Icon(
                                      Icons.image,
                                      size: 80,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Image URL',
                                labelStyle: TextStyle(
                                  fontSize: ScreenUtil().setWidth(50),
                                ),
                              ),
                              maxLines: 1,
                              controller: imageURLController,
                              style: TextStyle(
                                fontSize: ScreenUtil().setWidth(50),
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
