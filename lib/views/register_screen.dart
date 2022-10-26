import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

// import own files
import 'package:pdrnl_events_app/views/login_screen.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              RegisterCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterCard extends StatefulWidget {
  const RegisterCard({super.key});

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String errorMessage = '';
  late String _deviceName;

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getDeviceName();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
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
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
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
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
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
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              const SizedBox(
                height: 25,
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () => submit(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 36),
                  ),
                  child: const Text('Register'),
                ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final Auth provider = Provider.of<Auth>(context, listen: false);
      await provider.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _passwordConfirmController.text,
        _deviceName,
      );
    } catch (error) {
      setState(() {
        errorMessage = error.toString().replaceAll('Exception: ', '');
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getDeviceName() async {
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
