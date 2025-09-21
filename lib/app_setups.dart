import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'config/dependencies.dart';
import 'constants.dart';

void setupLogger(Logger errorLogger) {
  dependencies.get<LoggerRepository>().registerLogHandler(enableDebugLogs);

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
