import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/models/product.dart';
import 'package:pamm2/src/pages/itemDetails.dart';
import 'package:pamm2/src/repos/shopRepo.dart';

List items = [
  {
    'title': 'Respect the Prophets',
    'img':
        'https://images.unsplash.com/photo-1648737154448-ccf0cafae1c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'title': 'Respect the Prophets',
    'img':
        'https://images.unsplash.com/photo-1648737965255-e1e6f33f0937?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'
  },
  {
    'title': 'Respect the Prophets',
    'img':
        'https://images.unsplash.com/photo-1652538302725-0ee98032dcad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'
  },
  {
    'title': 'Respect the Prophets',
    'img':
        'https://images.unsplash.com/photo-1652551161938-bb90715aeaa3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'
  },
];

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  ShopRepo shopRepo = ShopRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _itemCard(Product product) {
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
                    imageUrl: product.images![0],
                    placeholder: (BuildContext context, String url) {
                      return const Icon(Icons.shopping_cart, size: 30);
                    },
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .3),
              ),
              Column(
                children: [
                  Text(product.category!.title!,
                      style: const TextStyle(fontSize: 12)),
                  Text(
                    product.title!,
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
                                    productId: product.id!,
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
    return FutureBuilder<List<Product>>(
        future: shopRepo.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            List<Product> products = snapshot.data;

            return Container(
              decoration: BoxDecoration(color: KColors.kTextColorDark),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int i) {
                          return _itemCard(products[i]);
                        }),
                  ),
                  const SizedBox(height: 25)
                ],
              ),
            );
          }

          return Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          );
        });
  }
}
