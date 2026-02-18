import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: paste from Google Cloud Console
  static const String webClientId = 'PASTE_WEB_CLIENT_ID_HERE';
  static const String clientSecret = 'PASTE_CLIENT_SECRET_HERE';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      return _signInWithGooglePackage();
    }

    if (defaultTargetPlatform == TargetPlatform.windows) {
      return _signInWithCustomOAuth();
    }

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      return _signInWithGooglePackage();
    }

    throw UnsupportedError('Unsupported platform');
  }

  // ================= MOBILE / WEB =================
  Future<UserCredential> _signInWithGooglePackage() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account == null) {
      throw FirebaseAuthException(
        code: 'CANCELLED',
        message: 'User cancelled sign in',
      );
    }

    final GoogleSignInAuthentication auth = await account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  // ================= WINDOWS CUSTOM FLOW =================
  Future<UserCredential> _signInWithCustomOAuth() async {
    const redirectUri = 'http://localhost:8080';

    final authUrl = Uri.parse(
      'https://accounts.google.com/o/oauth2/v2/auth'
          '?response_type=code'
          '&client_id=$webClientId'
          '&redirect_uri=$redirectUri'
          '&scope=openid%20email%20profile',
    );

    final code = await _listenForCode(authUrl, redirectUri);

    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': webClientId,
        'client_secret': clientSecret,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
      },
    );

    final body = jsonDecode(response.body);

    final credential = GoogleAuthProvider.credential(
      idToken: body['id_token'],
      accessToken: body['access_token'],
    );

    return _auth.signInWithCredential(credential);
  }

  Future<String> _listenForCode(Uri url, String redirectUri) async {
    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      Uri.parse(redirectUri).port,
    );

    await launchUrl(url);

    final completer = Completer<String>();

    server.listen((request) async {
      final code = request.uri.queryParameters['code'];

      request.response
        ..statusCode = 200
        ..headers.contentType = ContentType.html
        ..write('<h2>You may close this window</h2>');

      await request.response.close();
      await server.close();

      if (code != null) {
        completer.complete(code);
      } else {
        completer.completeError('No code returned');
      }
    });

    return completer.future;
  }

  // ================= SIGN OUT =================
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    await _auth.signOut();
  }
}
