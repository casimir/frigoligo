import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'constants.dart';
import 'db/database.dart';
import 'utils.dart';

void setupLogger(Logger errorLogger) {
  Logger.root.level = enableDebugLogs ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    DB().appendLog(record);
    debugPrint(loglineFromRecord(record));
  });
  FlutterError.onError = (errorDetails) {
    final repr = errorDetails.exceptionAsString();
    errorLogger.severe('uncaught error', repr, errorDetails.stack);
    FlutterError.presentError(errorDetails);
  };
}

void setupGoogleFonts() {
  // prevent fetching fonts from the internet, only loads the ones in the assets
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
