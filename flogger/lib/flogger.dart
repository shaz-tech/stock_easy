library flogger;

import 'config.dart';

export 'package:flogger/config.dart' show FloggerConfig;
export 'package:flogger/flogger.dart' show Flogger;

/// A flutter logging sdk

enum MessageType { warning, info, error }

class Flogger {
  static final Flogger _instance = Flogger._internal();
  static String _defaultSourceName = 'Flogger';

  static FloggerConfig _floggerConfig;

  Flogger._internal();

  factory Flogger.init(FloggerConfig floggerConfig, {appName: String}) {
    if (_floggerConfig == null) {
      //_defaultSourceName = appName ?? _defaultSourceName;
      _floggerConfig = floggerConfig;
    }
    return _instance;
  }

  factory Flogger({appName: String}) {
    if (_floggerConfig == null) {
      //_defaultSourceName = appName ?? _defaultSourceName;
      _floggerConfig = FloggerConfig(false);
    }
    return _instance;
  }

  /*void verbose(String message, {source: String}) {
    if (_floggerConfig.logEnabled)
      */ /*log(
        message,
        time: DateTime.now(),
        level: LoggingLevel.all.index,
        name: source ?? _defaultSourceName,
      );*/ /*
      print(formattedMessage(MessageType.info, message));
  }

  void debug(String message) {
    if (_floggerConfig.logEnabled) print(formattedMessage(MessageType.info,message));
  }*/

  void info(String message) {
    if (_floggerConfig.logEnabled)
      print(formattedMessage(MessageType.info, message));
  }

  void warn(String message) {
    if (_floggerConfig.logEnabled)
      print(formattedMessage(MessageType.warning, message));
  }

  /*void error(Exception error) {
    if (_floggerConfig.logEnabled)
      print('${error.toString()}'));
  }*/

  void error(String errorMessage, {Object error, stackTrace: StackTrace}) {
    if (_floggerConfig.logEnabled)
      print(formattedMessage(MessageType.error, errorMessage));
  }

  String formattedMessage(MessageType messageType, String message) =>
      '$_defaultSourceName(' +
      formattedMessageType(messageType) +
      ') -> $message';

  String formattedMessageType(MessageType messageType) {
    if (messageType == MessageType.warning)
      return "Warning";
    else if (messageType == MessageType.error)
      return "Error";
    else
      return "Info";
  }
}
