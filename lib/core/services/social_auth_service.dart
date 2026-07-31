import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:js_interop';
import 'google_identity_interop.dart';

class GoogleIdToken {
  final String token;
  final String email;
  final String name;
  final String? picture;

  GoogleIdToken({
    required this.token,
    required this.email,
    required this.name,
    this.picture,
  });
}

class SocialAuthService {
  static const String googleClientId =
      '215370690483-meevd4ubn4mbde9ssb8545p8r9meovu0.apps.googleusercontent.com';

  late GoogleAccountsId _gis;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      _gis = googleAccountsId;

      void initCallback(GoogleIdentityResponse response) {
        // Callback handled in signInWithGoogle
      }

      final configJs = GoogleIdentityInitConfig(
        client_id: googleClientId,
        callback: initCallback.toJS as JSFunction,
      );

      _gis.initialize(configJs as JSObject);
      _initialized = true;
      debugPrint('Google Identity Services initialized');
    } catch (e) {
      debugPrint('Failed to initialize Google Identity Services: $e');
      rethrow;
    }
  }

  Future<GoogleIdToken?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        await initialize();
        return await _signInWithGIS();
      } else {
        return await _signInWithNativeFlow();
      }
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<GoogleIdToken?> _signInWithGIS() async {
    final completer = Completer<GoogleIdToken?>();

    void promptCallback(GoogleIdentityResponse response) {
      if (response.credential != null && response.credential!.isNotEmpty) {
        try {
          final idToken = _parseIdToken(response.credential!);
          completer.complete(idToken);
        } catch (e) {
          debugPrint('Failed to parse ID token: $e');
          completer.completeError(e);
        }
      } else {
        completer.complete(null);
      }
    }

    _gis.prompt(promptCallback.toJS as JSFunction);

    return completer.future;
  }

  GoogleIdToken _parseIdToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT format');
    }

    try {
      final payload = json.decode(
        utf8.decode(
          base64Url.decode(base64Url.normalize(parts[1])),
        ),
      ) as Map<String, dynamic>;

      return GoogleIdToken(
        token: token,
        email: payload['email'] as String? ?? '',
        name: payload['name'] as String? ?? '',
        picture: payload['picture'] as String?,
      );
    } catch (e) {
      throw Exception('Failed to parse JWT payload: $e');
    }
  }

  Future<GoogleIdToken?> _signInWithNativeFlow() async {
    throw UnsupportedError(
      'Native Google Sign-In flow must be implemented for Android/iOS',
    );
  }

  Future<void> signOut() async {
    try {
      if (kIsWeb && _initialized) {
        _gis.disableAutoSelect();
        debugPrint('Google Sign-Out completed');
      }
    } catch (e) {
      debugPrint('Sign Out Error: $e');
      rethrow;
    }
  }
}
