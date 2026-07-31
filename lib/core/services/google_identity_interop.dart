import 'dart:js_interop';

@JS('google.accounts.id')
external GoogleAccountsId get googleAccountsId;

@JS()
extension type GoogleAccountsId(JSObject _) implements JSObject {
  external void initialize(JSObject config);
  external void prompt(JSFunction callback);
  external void disableAutoSelect();
}

@JS()
@staticInterop
class GoogleIdentityInitConfig {
  external factory GoogleIdentityInitConfig({
    required String client_id,
    required JSFunction callback,
  });
}

@JS()
extension type GoogleIdentityResponse(JSObject _) implements JSObject {
  external String? get credential;
}

typedef GoogleIdentityCallback = void Function(GoogleIdentityResponse response);





