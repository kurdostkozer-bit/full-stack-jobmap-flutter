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
class GoogleIdentityInitConfig {
  external factory GoogleIdentityInitConfig({
    required String client_id,
    required JSFunction callback,
    bool? auto_select,
    bool? cancel_on_tap_outside,
    String? context,
    String? ux_mode,
  });
}

@JS()
@staticInterop
class GoogleIdentityResponse {}

extension GoogleIdentityResponseExtension on GoogleIdentityResponse {
  external String? get credential;

  external String? get select_by;
}