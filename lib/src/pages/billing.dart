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
import 'package:pamm2/src/repos/shopRepo.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final GlobalKey _formkey = GlobalKey<FormState>();

  CartController cartController = Get.find<CartController>();
  double total = 0;
  int quantity = 0;
  bool isLoading = false;

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

    for (var element in cartController.cartItems) {
      int qty = int.parse(element['qty']);
      dynamic unit_price = element['product']['price'];
      dynamic unit_total = qty * unit_price;

      setState(() {
        total += unit_total;
        quantity = qty;
      });
    }
  }

  void _placeOrder() async {

    setState(() {
      isLoading = true;
    });

    dynamic payload = {
      "data": {
        "firstname": firstnameController.text,
        "lastname": lastnameController.text,
        "phone": phoneController.text,
        "email": emailController.text.isEmpty ? "noreply@email.com" : emailController.text,
        "country": countryController.text,
        "region": regionController.text,
        "address": addressController.text,
        "additional_info": additionalInfoController.text,
        "products": cartController.cartItems.map((e) => e['id']).toList(),
        "quantity": quantity,
        "paid": false,
        "fulfilled": false
      }
    };

    ShopRepo shopRepo = ShopRepo();
    await shopRepo.createOrder(payload);

    dynamic paymentPayload = {
      "description":
          '${firstnameController.text} ${lastnameController.text} " - items purchase"',
      "totalAmount": total + 20
    };

    dynamic response = await shopRepo.makePayment(paymentPayload);
    dynamic payment_resp = jsonDecode(response);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WebViewBuilder(url: payment_resp["data"]["checkoutUrl"])));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: KColors.kPrimaryColor),
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kLightColor,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text('BILLING INFO', style: TextStyle(fontSize: 18)));
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
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
                                child: CachedNetworkImage(
                                    imageUrl: cartItem['product']['images']
                                        ['data'][0]['attributes']['url'],
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
                                  Text(cartItem['product']['title']),
                                  Text(
                                      'Amount: ${cartItem['qty']} x GHS ${cartItem['product']['price']}'),
                                  Text(
                                      'Total: GHS ${double.parse(cartItem['qty']) * cartItem['product']['price']}'),
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
                controller: firstnameController,
              ),
              const SizedBox(height: 20),
              KFormField(
                label: 'Lastname',
                controller: lastnameController,
              ),
              const SizedBox(height: 20),
              KFormField(
                  label: 'Phone', controller: phoneController),
              const SizedBox(height: 20),
              KFormField(label: 'Email (optional)', controller: emailController),
              const SizedBox(height: 20),
              KFormField(label: 'Country', controller: countryController),
              const SizedBox(height: 20),
              KFormField(label: 'Region/State', controller: regionController),
              const SizedBox(height: 20),
              KFormField(label: 'Address', controller: addressController),
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
                  label: isLoading ? '...loading' :
                      'Confirm Order | GHS ${(total + 20).toStringAsFixed(2)}',
                  showIcon: false)
            ],
          ),
        ),
      ),
    );
  }
}
