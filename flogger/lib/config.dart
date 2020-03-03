export 'package:flogger/config.dart' show FloggerConfig;
class FloggerConfig {
  bool _logEnabled = false;

  FloggerConfig(this._logEnabled);

  bool get logEnabled => _logEnabled;
}