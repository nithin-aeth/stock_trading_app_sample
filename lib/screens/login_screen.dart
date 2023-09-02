import 'package:flutter/material.dart';
import 'package:stock_trading_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      emailController.clear();
      passController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.black,
        title: const Text(
          "-Login ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmailTextField(),
                const SizedBox(height: 20),
                _buildPasswordTextField(),
                const SizedBox(height: 100),
                _buildLoginButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: const InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.mail),
      ),
      validator: (value) {
        bool emailValid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);

        if (value.isEmpty) {
          return "Enter Email";
        } else if (!emailValid) {
          return "Enter Valid Email";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: passController,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: InkWell(
          onTap: _togglePasswordVisibility,
          child: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Password";
        } else if (passController.text.length < 6) {
          return "Password Length Should be more than 6 characters";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: _login,
        style: TextButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Log In", style: TextStyle(
            color: Colors.white, fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
