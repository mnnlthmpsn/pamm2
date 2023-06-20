import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';

import '../../repos/miscRepo.dart';

class Testimony extends StatefulWidget {
  const Testimony({Key? key}) : super(key: key);

  @override
  State<Testimony> createState() => _TestimonyState();
}

class _TestimonyState extends State<Testimony> {
  final TextEditingController _countryLabel =
      TextEditingController(text: 'Country/Region');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _prayerController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        'Share Testimony',
        style: TextStyle(fontSize: 16),
      ),
      elevation: 0,
      backgroundColor: KColors.kPrimaryColor,
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Image.asset('assets/images/testimony.jpg'),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _prayerText(),
                  const SizedBox(
                    height: 25,
                  ),
                  _fullname(),
                  const SizedBox(
                    height: 20,
                  ),
                  _country(),
                  const SizedBox(
                    height: 20,
                  ),
                  _email(),
                  const SizedBox(
                    height: 20,
                  ),
                  _phone(),
                  const SizedBox(
                    height: 20,
                  ),
                  _prayerRequest(),
                  const SizedBox(
                    height: 20,
                  ),
                  _submitTestimony()
                ],
              ),
            )
          ]),
        )
      ],
    );
  }

  Widget _prayerText() {
    return const Text(
      'Please share your testimonies with us!',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _fullname() {
    return KFormField(label: 'Fullname', icon: Icons.person, controller: _fullnameController,);
  }

  Widget _country() {
    return Builder(
      builder: (BuildContext context) {
        return TextField(
          onTap: () {
            showCountryPicker(
                context: context,
                onSelect: (country) {
                  setState(() => _countryLabel.text = country.name);
                });
          },
          controller: _countryLabel,
          style: TextStyle(fontSize: 14),
          readOnly: true,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: Colors.grey.withOpacity(.5))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(.5), width: 1))),
        );
      },
    );
  }

  Widget _email() {
    return KFormField(
      label: 'Email',
      icon: Icons.email_rounded,
      enabledBorder: KColors.kPrimaryColor,
      controller: _emailController,
    );
  }

  Widget _phone() {
    return KFormField(
        label: 'Phone Number', controller: _phoneController,);
  }

  Widget _prayerRequest() {
    return KFormField(
      label: 'Testimony',
      icon: Icons.favorite_rounded,
      textarea: true,
      controller: _prayerController,
    );
  }

  Widget _submitTestimony() {
    return KButton(
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        var payload = {
          "fullname": _fullnameController.value.text,
          "country": _countryLabel.text,
          "email": _emailController.value.text,
          "phoneNumber": _phoneController.value.text,
          "requestType": "TESTIMONY",
          "content": _prayerController.value.text
        };

        MiscRepo miscRepo = MiscRepo();

        try {
          await miscRepo.submitRequest(payload);
          Get.snackbar('Testimony', 'Testimony request submitted Successfully',
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 25),
              backgroundColor: KColors.kLightColor,
              icon: const Icon(Icons.check, color: Colors.green));

          setState(() {
            isLoading = false;
          });
        }
        catch (e) {
          Get.snackbar('Prayer', 'An error occurred submitting prayer request',
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 25),
              backgroundColor: KColors.kLightColor,
              icon: const Icon(Icons.error, color: Colors.red));
        }
      },
      label: isLoading ? '...loading' :'Submit',
      showIcon: false,
      color: KColors.kPrimaryColor,
    );
  }
}
