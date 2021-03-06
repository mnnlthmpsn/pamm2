import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';
import 'package:pamm2/src/controllers/cart_controllelr.dart';
import 'package:geolocator/geolocator.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final GlobalKey _formkey = GlobalKey<FormState>();

  CartController cartController = Get.find<CartController>();
  double total = 0;

  @override
  void initState() {
    super.initState();

   for (var element in cartController.cartItems) {
      int qty = int.parse(element['qty']);
      double unit_price = element['product'].amount;
      double unit_total = qty * unit_price;

      setState(() {
        total += unit_total;
      });
    }
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
        title: const Text('Billing Info', style: TextStyle(fontSize: 18)));
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
                                    imageUrl: cartItem['product'].images[0],
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
                                  Text(cartItem['product'].title),
                                  Text(
                                      'Amount: ${cartItem['qty']} x GHS ${cartItem['product'].amount}'),
                                  Text(
                                      'Total: GHS ${double.parse(cartItem['qty']) * cartItem['product'].amount}'),
                                ],
                              )
                            ],
                          ),
                          Positioned(
                              right: 2,
                              top: 0,
                              bottom: 0,
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.close)))
                        ],
                      ),
                    );
                  }),
              const Text('Please enter Shipping/Billing Info'),
              const SizedBox(height: 20),
              const KFormField(label: 'Firstname'),
              const SizedBox(height: 20),
              const KFormField(label: 'Lastname'),
              const SizedBox(height: 20),
              const KFormField(label: 'Phone (optional)'),
              const SizedBox(height: 20),
              const KFormField(label: 'Email'),
              const SizedBox(height: 20),
              const KFormField(label: 'Country'),
              const SizedBox(height: 20),
              const KFormField(label: 'Region/State'),
              const SizedBox(height: 20),
              const KFormField(label: 'Address'),
              const SizedBox(height: 20),
              const KFormField(label: 'Additional Info', textarea: true),
              const SizedBox(height: 30),
              Text('SubTotal: GHS $total', style: TextStyle(color: KColors.kPrimaryColor)),
              const SizedBox(height: 4),
              Text('Billing: GHS 20.00', style: TextStyle(color: KColors.kPrimaryColor)),
              const SizedBox(height: 10),
              KButton(onPressed: () {}, label: 'Confirm Order | GHS ${(total + 20).toStringAsFixed(2)}', showIcon: false)
            ],
          ),
        ),
      ),
    );
  }
}
