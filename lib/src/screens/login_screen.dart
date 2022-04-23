import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:login_to_do_list_app/src/services.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    'assets/banner.svg',
                    height: 300.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: const _LoginForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: GoogleFonts.alata(
            textStyle: const TextStyle(
              letterSpacing: 1.5,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 50.0),
        _emailTextField(),
        const SizedBox(height: 30.0),
        _passwordTextField(),
        const SizedBox(height: 80.0),
        _buttonSubmit(context),
      ],
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.deepPurple,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.deepPurple,
        ),
        hintText: 'Email',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      cursorColor: Colors.deepPurple,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.password,
          color: Colors.deepPurple,
        ),
        prefixIconColor: Colors.deepPurple,
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _buttonSubmit(BuildContext context) {
    return ElevatedButton(
      child: const Text('Login'),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        minimumSize: const Size(double.infinity, 50.0),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        final authServive = Provider.of<AuthService>(
          context,
          listen: false,
        );
        final String? errorMessage = await authServive.login(
          "hola",
          "loginFormProvider.password",
        );
        if (errorMessage == null) {
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          final snackBar = SnackBar(
            content: Text(errorMessage),
            action: SnackBarAction(
              label: 'Aceptar',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
