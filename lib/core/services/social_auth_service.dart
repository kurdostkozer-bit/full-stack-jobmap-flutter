import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_identity_services_web/google_identity_services_web.dart';

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

  Future<GoogleIdToken?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
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
    final gis = google_identity_services_web.id;

    return await Future<GoogleIdToken?>(
      (completer) {
        gis.oneTap(OneTapRequest(
          client_id: googleClientId,
          callback: (OneTapResponse response) {
            if (response.credential != null) {
              final parts = response.credential!.split('.');
              if (parts.length != 3) {
                completer.completeError('Invalid JWT format');
                return;
              }

              final payload = json.decode(
                utf8.decode(
                  base64Url.decode(base64Url.normalize(parts[1])),
                ),
              ) as Map<String, dynamic>;

              final idToken = GoogleIdToken(
                token: response.credential!,
                email: payload['email'] as String? ?? '',
                name: payload['name'] as String? ?? '',
                picture: payload['picture'] as String?,
              );

              completer.complete(idToken);
            }
          },
          cancel_on_tap_outside: true,
        ));
      },
    );
  }

  Future<GoogleIdToken?> _signInWithNativeFlow() async {
    throw UnsupportedError(
      'Native Google Sign-In flow must be implemented for Android/iOS',
    );
  }

  Future<void> signOut() async {
    try {
      if (kIsWeb) {
        final gis = google_identity_services_web.id;
        gis.disableAutoSelect();
      }
    } catch (e) {
      debugPrint('Sign Out Error: $e');
      rethrow;
    }
  }
}
