import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';

class Prayer extends StatefulWidget {
  const Prayer({Key? key}) : super(key: key);

  @override
  State<Prayer> createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  final TextEditingController _countryLabel =
      TextEditingController(text: 'Country');

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
        'Request Prayer',
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
            Image.asset('assets/images/prayer.jpg'),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Padding(
              padding: const EdgeInsets.all(20),
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
    return KFormField(label: 'Fullname', icon: Icons.person);
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
    return KFormField(label: 'Email', icon: Icons.email_rounded);
  }

  Widget _phone() {
    return KFormField(label: 'Phone Number', icon: Icons.phone_enabled_rounded);
  }

  Widget _prayerRequest() {
    return const KFormField(
      label: 'Prayer Request',
      icon: Icons.favorite_rounded,
      textarea: true,
    );
  }

  Widget _submitPrayer() {
    return KButton(
      onPressed: () {},
      label: 'Submit',
      showIcon: false,
      color: KColors.kPrimaryColor,
    );
  }
}
