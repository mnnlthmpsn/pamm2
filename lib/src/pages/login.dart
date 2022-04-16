import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/components/kButton.dart';
import 'package:pamm2/src/components/kFormField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void continueAsGuest() {
    print('Continue as guest');
  }

  void login() {
    newPageDestroyPrevious(context, 'home');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _parentWidget()));
  }

  Widget _parentWidget() {
    return CustomScrollView(
      slivers: [
        _appBar(context),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .05),
                      Text('Hey,', style: TextStyle(fontSize: 18)),
                      Text('Login Now.',
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(height: 25),
                      _createAccountBtn(),
                      SizedBox(height: 20),
                      _loginForm()
                    ],
                  )
                ])))
      ],
    );
  }

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: false,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.3,
      expandedHeight: 80,
      title: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('PAMM',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Ministries',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      backgroundColor: KColors.kPrimaryColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: KColors.kPrimaryColor,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                      KColors.kLightColor.withOpacity(.6),
                      BlendMode.dstATop),
                  image: const AssetImage('assets/images/3.png'))),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _emailField(),
          SizedBox(height: 20),
          _passwordField(),
          SizedBox(height: 20),
          _passwordReset(),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          _loginBtn(),
          SizedBox(height: 5),
          _guestLogin(),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  Widget _createAccountBtn() {
    return Row(
      children: <Widget>[
        Text('If you are new / ', style: Theme.of(context).textTheme.subtitle1),
        InkWell(
            splashColor: KColors.kLightColor,
            onTap: () {},
            child: Text('Create an Account',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 14)))
      ],
    );
  }

  Widget _emailField() {
    return const KFormField(label: 'Email', icon: Icons.alternate_email,);
  }

  Widget _passwordField() {
    return const KFormField(label: 'Password', icon: Icons.lock);
  }

  Widget _passwordReset() {
    return Row(
      children: <Widget>[
        Text('Forgot Password / ',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontSize: 12)),
        InkWell(
            splashColor: KColors.kLightColor,
            onTap: () {},
            child: Text('Reset',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 14)))
      ],
    );
  }

  Widget _loginBtn() {
    return SizedBox(
      width: double.infinity,
      child: KButton(label: 'Login', onPressed: login, icon: Icons.login, color: KColors.kPrimaryColor,),
    );
  }

  Widget _guestLogin() {
    return SizedBox(
      width: double.infinity,
      child: KButton(
        label: 'Continue as Guest',
        color: KColors.kDarkColor,
        onPressed: continueAsGuest,
      ),
    );
  }
}
