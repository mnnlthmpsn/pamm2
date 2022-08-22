import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/controllers/cart_controllelr.dart';
import 'package:pamm2/src/pages/itemDetails.dart';
import 'package:pamm2/src/repos/shopRepo.dart';

class StoreAnnex extends StatefulWidget {
  const StoreAnnex({Key? key}) : super(key: key);

  @override
  State<StoreAnnex> createState() => _StoreAnnexState();
}

class _StoreAnnexState extends State<StoreAnnex> {
  ShopRepo shopRepo = ShopRepo();
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: KColors.kDarkColor),
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kLightColor,
        backgroundColor: KColors.kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'eStore',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: KColors.kLightColor),
            ),
            IconButton(
                onPressed: () => newPage(context, 'billing'),
                icon: GetBuilder<CartController>(builder: (cartController) {
                  return Badge(
                      child: const Icon(Icons.shopping_cart),
                      badgeColor: KColors.kLightColor,
                      badgeContent: Text(
                        cartController.getCartLength(),
                        style: TextStyle(color: KColors.kPrimaryColor),
                      ));
                }))
          ],
        ));
  }

  Widget _itemCard(dynamic product) {
    return Builder(builder: (BuildContext context) {
      return Container(
        padding:
        const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CachedNetworkImage(
                    imageUrl: product['attributes']['images']!['data'][0]['attributes']['url'],
                    placeholder: (BuildContext context, String url) {
                      return const Icon(Icons.shopping_cart, size: 30);
                    },
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .3),
              ),
              Column(
                children: [
                  Text(product['attributes']!['category']!['data']['attributes']['title'],
                      style: const TextStyle(fontSize: 12)),
                  Text(
                    product['attributes']['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: KColors.kPrimaryColor),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ItemDetails(
                                productId: product['id']!,
                              ))),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          child: Text('Buy Now',
                              style: TextStyle(color: Colors.white))))
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      );
    });
  }

  Widget _body() {
    return FutureBuilder<List>(
        future: shopRepo.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Sorry an error occured'),
            );
          }

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return (Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: KColors.kTextColorDark),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return _itemCard(snapshot.data[i]);
                  }),
            ));
          }
          return Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          );
        });
  }
}
