import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pamm2/config.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';
import 'package:pamm2/src/models/requestType.dart';
import 'package:pamm2/src/repos/miscRepo.dart';

class Prayer extends StatefulWidget {
  final String? src;
  const Prayer({Key? key, this.src}) : super(key: key);

  @override
  State<Prayer> createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  final TextEditingController _countryLabel =
      TextEditingController(text: 'Country/Region');
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _prayerController = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.src == null ? appBar() : inVincible(),
      body: _body(context),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        'Request Prayer',
        style: TextStyle(fontSize: 16),
      ),
      elevation: 0,
      backgroundColor: KColors.kPrimaryColor,
    );
  }

  PreferredSizeWidget inVincible() {
    return AppBar(
      toolbarHeight: 0,
    );
  }

  Widget _body(context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Image.asset('assets/images/prayer.jpg'),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).size.height * .2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prayer Request', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: KColors.kDarkColor),),
                  const SizedBox(height: 20,),
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
                  _submitPrayer()
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
      'I want to pray with you! Please share your prayer needs so we can agree together',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _fullname() {
    return KFormField(label: 'Fullname', icon: Icons.person, controller: _fullnameController);
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
    return KFormField(label: 'Email', icon: Icons.email_rounded, controller: _emailController,);
  }

  Widget _phone() {
    return KFormField(label: 'Phone Number', icon: Icons.phone_enabled_rounded, controller: _phoneController,);
  }

  Widget _prayerRequest() {
    return KFormField(
      label: 'Prayer Request',
      icon: Icons.favorite_rounded,
      textarea: true,
      controller: _prayerController,
    );
  }

  Widget _submitPrayer() {
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
          "requestType": "PRAYER",
          "content": _prayerController.value.text
        };

        MiscRepo miscRepo = MiscRepo();

        try {
          await miscRepo.submitRequest(payload);
          Get.snackbar('Prayer', 'Prayer request submitted Successfully',
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
