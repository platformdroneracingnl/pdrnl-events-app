import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

// import own files
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/widgets/auth/submit_button.dart';
import 'package:pdrnl_events_app/widgets/auth/header.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const <Widget>[
          AuthHeader('Register'),
          RegisterForm(),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String errorMessage = '';
  late String _deviceName;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getDeviceName();
  }

  // Error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
            bottom: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  controller: _passwordConfirmController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Repeat password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                AuthSubmitButton('Register', _isLoading, _submit),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .popAndPushNamed(LoginScreen.routeName);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _passwordConfirmController.text,
        _deviceName,
      );

      // Redirect to home screen
      if (!mounted) return;
      Navigator.of(context).pushNamed(BaseScreen.routeName);
    } catch (error) {
      _showErrorDialog(error.toString().replaceAll('Exception: ', ''));
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          _deviceName = build.model;
        });
      } else if (Platform.isIOS) {
        var build = await deviceInfoPlugin.iosInfo;
        setState(() {
          _deviceName = build.model!;
        });
      }
    } on PlatformException {
      setState(() {
        _deviceName = 'Failed to get platform version';
      });
    }
  }
}
