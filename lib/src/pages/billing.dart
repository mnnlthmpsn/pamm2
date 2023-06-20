import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';
import 'package:pamm2/src/components/webViewBuilder.dart';
import 'package:pamm2/src/controllers/cart_controllelr.dart';
import 'package:pamm2/src/models/product.dart';

import '../repos/shopRepo.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final _formKey = GlobalKey<FormState>();

  CartController cartController = Get.find<CartController>();
  double total = 0;
  int quantity = 0;
  bool isLoading = false;
  bool _showPage = false;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (cartController.cartItems.isEmpty) {
      setState(() {
        _showPage = false;
      });
    } else {
      _showPage = true;
    }

    for (var element in cartController.cartItems) {
      int qty = int.parse(element['qty']);
      dynamic unit_price =
          int.parse((element['product'] as ProductModel).price);
      dynamic unit_total = qty * unit_price;

      setState(() {
        total += unit_total;
        quantity = qty;
      });
    }
  }

  void _placeOrder() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        dynamic payload = {
          "firstname": firstnameController.text,
          "lastname": lastnameController.text,
          "phone": phoneController.text,
          "email": emailController.text.isEmpty
              ? "noreply@email.com"
              : emailController.text,
          "country": countryController.text,
          "region": regionController.text,
          "address": addressController.text,
          "additional_info": additionalInfoController.text,
          "cartItems": cartController.cartItems.map((e) {
            return {
              "product": (e['product'] as ProductModel).id,
              "quantity": e['qty']
            };
          }).toList(),
          "quantity": quantity
        };

        ShopRepo shopRepo = ShopRepo();
        var res = await shopRepo.createOrder(payload);

        if (res["status"] == "Success") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Scaffold(
              appBar: _appBar(),
              body: WebViewBuilder(url: res["data"]["checkoutUrl"]),
            );
          }));
        } else {
          Get.snackbar('Purchase', 'An error occurred processing order',
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 25),
              backgroundColor: KColors.kLightColor,
              icon: const Icon(Icons.done, color: Colors.red));
        }

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      Get.snackbar('Purchase', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 25),
          backgroundColor: KColors.kLightColor,
          icon: const Icon(Icons.done, color: Colors.red));
    }
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kTextColorLight,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text(
          'Complete Info',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: _showPage
            ? _body()
            : const Center(
                child: Text("Please add Items to cart to continue"),
              ));
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: int.parse(cartController.getCartLength()),
                  itemBuilder: (BuildContext context, int i) {
                    dynamic cartItem = cartController.cartItems[i];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: (cartItem['product'] as ProductModel)
                                        .images
                                        .isEmpty
                                    ? const Icon(Icons.shopping_cart, size: 30)
                                    : CachedNetworkImage(
                                        imageUrl: (cartItem['product']
                                                as ProductModel)
                                            .images[0]
                                            .url,
                                        placeholder:
                                            (BuildContext context, String url) {
                                          return const Icon(Icons.shopping_cart,
                                              size: 30);
                                        },
                                        fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((cartItem['product'] as ProductModel)
                                      .title),
                                  Text(
                                      'Amount: ${cartItem['qty']} x GHS ${int.parse((cartItem['product'] as ProductModel).price)}'),
                                  Text(
                                      'Total: GHS ${double.parse(cartItem['qty']) * int.parse((cartItem['product'] as ProductModel).price)}'),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                              right: 2,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                  onPressed: () {
                                    cartController.removeFromCart(cartItem);
                                    if (cartController.cartItems.isEmpty) {
                                      setState(() {
                                        _showPage = false;
                                      });
                                    }

                                    setState(() {});
                                  },
                                  icon: Icon(Icons.close)))
                        ],
                      ),
                    );
                  }),
              const Text('Please enter Shipping/Billing Info'),
              const SizedBox(height: 20),
              KFormField(
                label: 'Firstname',
                validate: true,
                controller: firstnameController,
              ),
              const SizedBox(height: 20),
              KFormField(
                label: 'Lastname',
                validate: true,
                controller: lastnameController,
              ),
              const SizedBox(height: 20),
              KFormField(
                label: 'Phone',
                controller: phoneController,
                validate: true,
              ),
              const SizedBox(height: 20),
              KFormField(
                  label: 'Email (optional)', controller: emailController),
              const SizedBox(height: 20),
              KFormField(
                label: 'Country',
                controller: countryController,
                validate: true,
              ),
              const SizedBox(height: 20),
              KFormField(
                label: 'Region/State',
                controller: regionController,
                validate: true,
              ),
              const SizedBox(height: 20),
              KFormField(
                label: 'Address',
                controller: addressController,
                validate: true,
              ),
              const SizedBox(height: 20),
              KFormField(
                  label: 'Additional Info',
                  textarea: true,
                  controller: additionalInfoController),
              const SizedBox(height: 30),
              Text('SubTotal: GHS $total',
                  style: TextStyle(color: KColors.kPrimaryColor)),
              const SizedBox(height: 4),
              Text('Billing: GHS 20.00',
                  style: TextStyle(color: KColors.kPrimaryColor)),
              const SizedBox(height: 10),
              KButton(
                  onPressed: _placeOrder,
                  label: isLoading
                      ? '...loading'
                      : 'Confirm Order | GHS ${(total + 20).toStringAsFixed(2)}',
                  showIcon: false)
            ],
          ),
        ),
      ),
    );
  }
}
