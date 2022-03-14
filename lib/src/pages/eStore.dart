import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {

  static const testItems = [
    {
      'label': 'T-Shirt',
      'image':
      'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2hpcnR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'
    },
    {
      'label': 'Milk & Honey',
      'image':
      'https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Ym9va3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
    },
    {
      'label': 'Shoe',
      'image':
      'https://images.unsplash.com/photo-1608231387042-66d1773070a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c2hvZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
    },
    {
      'label': 'Church Mug',
      'image':
      'https://images.unsplash.com/photo-1516390118834-21602d501886?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bXVnfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Material(child: _giveParent(context)));
  }

  Widget _giveParent(BuildContext context) {
    return Wrap(
      alignment: testItems.length % 2 == 0 ? WrapAlignment.center : WrapAlignment.start,
      children: testItems
          .map((testItem) => storeItem(context, testItem))
          .toList(),
    );
  }

  Widget storeItem(context, item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextButton(
                onPressed: (){},
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .40,
                      height: MediaQuery.of(context).size.width * .40,
                      child: Hero(
                        tag: item['label'],
                        child: CachedNetworkImage(
                            placeholder: (BuildContext context, url) => Icon(
                                Icons.shopping_cart_rounded,
                                size: 100,
                                color: Colors.grey.withOpacity(.2)),
                            fit: BoxFit.cover,
                            imageUrl: item['image']),
                      ),
                    ))),
          ),
          const SizedBox(height: 5),
          Text(item['label']),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
