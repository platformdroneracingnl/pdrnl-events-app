import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

// import own files
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

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
              LoginCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                decoration: const InputDecoration(labelText: 'Email'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                validator: (value) {
                  // Validation condition
                  if (value!.isEmpty) {
                    return 'Password is required!';
                  }
                  return null;
                },
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(double.infinity, 36),
                  ),
                  child: const Text('Login'),
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
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: const Text(
                    'Create an account',
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
      await provider.login(
        _emailController.text,
        _passwordController.text,
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

  // Get device name
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
        _deviceName = 'Failed to get platform version.';
      });
    }
  }
}
