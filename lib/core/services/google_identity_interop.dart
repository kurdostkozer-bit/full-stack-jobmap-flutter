import 'dart:js_interop';

@JS('google.accounts.id')
external GoogleAccountsId get googleAccountsId;

@JS()
@staticInterop
class GoogleAccountsId {}

extension GoogleAccountsIdExtension on GoogleAccountsId {
  external void initialize(GoogleIdentityInitConfig config);

  external void prompt();

  @JS('disableAutoSelect')
  external void disableAutoSelect();
}

@JS()
@staticInterop
@anonymous
class GoogleIdentityInitConfig {
  external factory GoogleIdentityInitConfig({
    String client_id,
    JSFunction callback,
  });
}

@JS()
@staticInterop
class GoogleIdentityResponse {}

extension GoogleIdentityResponseExtension on GoogleIdentityResponse {
  external String? get credential;

  external String? get select_by;
}