import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BiometricAuthDemo(),
    );
  }
}

class BiometricAuthDemo extends StatefulWidget {
  @override
  _BiometricAuthDemoState createState() => _BiometricAuthDemoState();
}

class _BiometricAuthDemoState extends State<BiometricAuthDemo> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = 'Not authenticated';

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your data',
        // useErrorDialogs: true,
        // stickyAuth: true, // Android only
        // biometricOnly: true, // Android only
      );
      // authenticated=await _localAuth.authenticate(localizedReason: localizedReason)
    } catch (e) {
      print('Error during authentication: $e');
    }

    if (authenticated) {
      setState(() {
        _authStatus = 'Authenticated successfully';
      });
    } else {
      setState(() {
        _authStatus = 'Authentication failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Authentication Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Biometric Authentication Status:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _authStatus,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authenticate with Biometrics'),
            ),
          ],
        ),
      ),
    );
  }
}
