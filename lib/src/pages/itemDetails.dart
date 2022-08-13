import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/controllers/cart_controllelr.dart';
import 'package:pamm2/src/models/product_detail.dart';
import 'package:pamm2/src/repos/shopRepo.dart';

class ItemDetails extends StatefulWidget {
  final int productId;

  const ItemDetails({Key? key, required this.productId}) : super(key: key);

  static List thumbnails = [1, 2, 3, 4];

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final TextEditingController _qtyController = TextEditingController(text: '1');
  final ShopRepo shopRepo = ShopRepo();
  late final Future myFuture;

  int currentIndex = 0;

  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = shopRepo.getProduct(widget.productId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _thumbnail(thumbnail, index) {
    return Opacity(
      opacity: currentIndex == index ? 1 : .2,
      child: GestureDetector(
        onTap: () => setState(() => currentIndex = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(2),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(3)),
          child: CachedNetworkImage(
              imageUrl: thumbnail['attributes']['url'],
              placeholder: (BuildContext context, String url) {
                return const Icon(Icons.shopping_cart, size: 30);
              },
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _imageGallery(context, List images) {
    return Column(
      children: [
        Center(
          child: CachedNetworkImage(
              imageUrl: images[currentIndex]['attributes']['url'],
              placeholder: (BuildContext context, String url) {
                return const Icon(Icons.shopping_cart, size: 30);
              },
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * .5),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().map((key, value) => MapEntry(key, _thumbnail(value, key))).values.toList()
        ),
      ],
    );
  }

  Widget _productDetails(dynamic product) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 40),
          Text(product['title']!, style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          Text('GHS ${product['price'].toString()}',
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Row(
            children: <Widget>[
              const Text('Availability: '),
              Text(
                product['in_stock'] == true ? 'In stock' : 'Out of Stock',
                style: TextStyle(color: product['in_stock'] == true ? Colors.green : Colors.red),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(product['description']),
        ]);
  }

  Widget _callToAction(context, product) {
    return Row(
      children: [
        SizedBox(
            width: 70,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _qtyController,
              keyboardType: TextInputType.number,
            )),
        const SizedBox(width: 10),
        SizedBox(
          height: 48,
          width: MediaQuery.of(context).size.width * .35,
          child: TextButton(
              onPressed: () {
                cartController.addToCart({'product': product , 'qty': _qtyController.value.text});
                Get.snackbar('Title', 'Item added to cart',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.only(top:10, right: 10, left: 10, bottom: 25),
                  backgroundColor: KColors.kLightColor,
                  icon: const Icon(Icons.done, color: Colors.green)
                );
                Navigator.pop(context);
              },
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
              style:
                  TextButton.styleFrom(backgroundColor: KColors.kPrimaryColor)),
        )
      ],
    );
  }

  Widget _body() {
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            dynamic product = snapshot.data;

            return Builder(builder: (BuildContext context) {
              return (SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    _imageGallery(context, product['attributes']['images']['data']!),
                    _productDetails(product['attributes']),
                    const SizedBox(height: 18),
                    _callToAction(context, product['attributes']),
                    const SizedBox(height: 50),
                    product['attributes']['care_guide_info'] != null
                        ? _careInformation(product.careGuideInfo!)
                        : const SizedBox.shrink(),
                  ],
                ),
              )));
            });
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Sorry an error occured'));
          }
          return Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          );
        });
  }

  Widget _careInformation(String careGuidInfo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120.0),
      child: GFAccordion(
          titleChild: const Text('Care Guide Information',
              style: TextStyle(fontSize: 14)),
          content: careGuidInfo,
          collapsedIcon: const Icon(Icons.add),
          expandedIcon: const Icon(Icons.minimize),
          collapsedTitleBackgroundColor: Colors.white,
          expandedTitleBackgroundColor: KColors.kLightColor),
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
        title: const Text('Item Details', style: TextStyle(fontSize: 18)));
  }
}
