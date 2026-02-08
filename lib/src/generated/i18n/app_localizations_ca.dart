// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get g_article => 'Article';

  @override
  String get g_check => 'Comprova';

  @override
  String get g_checking => 'S’està comprovant…';

  @override
  String get g_delete => 'Suprimeix';

  @override
  String get g_saveLink => 'Desa l’enllaç';

  @override
  String get g_search => 'Cerca';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Paràmetres';

  @override
  String get g_share => 'Comparteix';

  @override
  String get g_sourceCode => 'Codi font';

  @override
  String get g_synchronize => 'Sincronitza';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Etiqueta';

  @override
  String get g_version => 'Versió';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dies',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'd’aquí a $duration';
  }

  @override
  String humanize_hours(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString hores',
      one: '1 hora',
    );
    return '$_temp0';
  }

  @override
  String humanize_minutes(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString minuts',
      one: '1 minut',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'Fa $duration';
  }

  @override
  String humanize_seconds(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString segons',
      one: '1 segon',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Afegeix etiquetes';

  @override
  String get article_archive => 'Arxiva aquest article';

  @override
  String get article_browseOriginal => 'Explora l’original';

  @override
  String get article_delete => 'Suprimeix aquest article';

  @override
  String get article_details => 'Més informació';

  @override
  String get article_noContentFetched => 'No s’ha recuperat cap contingut';

  @override
  String get article_notFound => 'No s’ha trobat l’article';

  @override
  String get article_openInBrowser => 'Obre al navegador';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Torna a recuperar el contingut';

  @override
  String get article_readingSettings => 'Paràmetres del text';

  @override
  String get article_share => 'Comparteix aquest article';

  @override
  String get article_star => 'Destaca aquest article';

  @override
  String get article_unarchive => 'Desarxiva aquest article';

  @override
  String get article_unstar => 'Deixa de destacar aquest article';

  @override
  String get articlefields_readingTime => 'Temps de lectura';

  @override
  String get articlefields_tags => 'Etiquetes';

  @override
  String get articlefields_title => 'Títol';

  @override
  String get articlefields_website => 'Lloc web';

  @override
  String get filters_articleDomains => 'Dominis';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString dominis',
      one: '1 domini',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Destacats';

  @override
  String get filters_articleState => 'Estat';

  @override
  String get filters_articleStateUnread => 'Sense llegir';

  @override
  String get filters_articleStateArchived => 'Arxivats';

  @override
  String get filters_articleStateAll => 'Tots els estats';

  @override
  String get filters_articleTags => 'Etiquetes';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString etiquetes',
      one: '1 etiqueta',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Cerca als articles';

  @override
  String get filters_searchMode => 'Mode de cerca';

  @override
  String get filters_searchModeAll => 'Tots els camps';

  @override
  String get filters_searchModeContent => 'Contingut';

  @override
  String get filters_searchModeTitle => 'Títol';

  @override
  String get logconsole_title => 'Consola de registres';

  @override
  String get logconsole_clear_logs => 'Clear logs';

  @override
  String get logconsole_export_title => 'Export as file';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString lines',
      one: '1 line',
    );
    return 'Current session ($_temp0)';
  }

  @override
  String logconsole_export_all_logs(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString lines',
      one: '1 line',
    );
    return 'All logs ($_temp0)';
  }

  @override
  String get listing_noArticles => 'No hi ha cap article';

  @override
  String get listing_articlesAll => 'Tots els articles';

  @override
  String get listing_articlesArchived => 'Articles arxivats';

  @override
  String get listing_articlesUnread => 'Articles sense llegir';

  @override
  String get login_acceptSelfSigned => 'Accepta certificats autosignats';

  @override
  String get login_actionLogin => 'Inicia una sessió';

  @override
  String get login_demoMode => 'Try in demo mode';

  @override
  String get login_existingSessionDialogConfirm => 'Finalitza la sessió';

  @override
  String get login_existingSessionDialogMessage =>
      'Voleu finalitzar la sessió actual i obrir-ne una de nova?';

  @override
  String get login_existingSessionDialogTitle => 'Ja hi ha una sessió activa';

  @override
  String get login_fieldClientId => 'Id. del client';

  @override
  String get login_fieldClientSecret => 'Secret del client';

  @override
  String get login_fieldPassword => 'Contrasenya';

  @override
  String get login_fieldUsername => 'Nom d’usuari';

  @override
  String get login_openLogConsole => 'Obre la consola de registres';

  @override
  String get readingsettings_fontFamily => 'Família tipogràfica';

  @override
  String get readingsettings_fontSize => 'Mida de la lletra';

  @override
  String get readdingsettings_textFormatting => 'Formatació del text';

  @override
  String get readingsettings_title => 'Paràmetres del text';

  @override
  String get save_confirmationTitle => 'S’ha desat l’article.';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Aquest URL no s’assembla a un. Voleu desar-lo igualment?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Desa’l';

  @override
  String get save_dubiousUrlTitle => 'L’URL és dubtós';

  @override
  String get save_noUrl => 'No s’ha fornit cap URL';

  @override
  String get save_title => 'Desa l’article';

  @override
  String get save_viewArticle => 'Visualitza l’article';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecciona $numberOfItems';
  }

  @override
  String get server_address => 'Adreça del servidor';

  @override
  String server_emptyField(String label) {
    return 'Heu d’introduir $label';
  }

  @override
  String get server_invalidUrl => 'L’adreça no és vàlida';

  @override
  String get server_unknownServerType => 'Es desconeix el tipus de servidor';

  @override
  String get server_unreachable => 'El servidor no és accessible';

  @override
  String get server_versionNotSupported => 'No s’admet la versió del servidor';

  @override
  String get session_copiedToClipboard => 'S’ha copiat al porta-retalls';

  @override
  String get session_invalidToken => 'no vàlid';

  @override
  String get session_logoutDialogConfirm => 'Finalitza la sessió';

  @override
  String get session_logoutDialogMessage => 'Haureu d’iniciar sessió de nou.';

  @override
  String get session_logoutDialogTitle => 'Finalitza la sessió';

  @override
  String get session_logoutSession => 'Finalitza la sessió';

  @override
  String get session_fieldAccessToken => 'Testimoni d’accés';

  @override
  String get session_fieldApiToken => 'Testimoni de l’API';

  @override
  String get session_fieldLastServerSync =>
      'Darrera sincronització amb el servidor';

  @override
  String get session_fieldTokenExpiration => 'Caducitat del testimoni';

  @override
  String get session_forceTokenResfresh =>
      'Força una actualització del testimoni';

  @override
  String get session_neverSynced => 'mai';

  @override
  String get session_renewDialogMessage =>
      'El servidor rebutja el testimoni de sessió actual. Haureu d’iniciar sessió de nou per a reprendre la sincronització.';

  @override
  String get session_renewDialogTitle => 'Renova la sessió';

  @override
  String get session_title => 'Detalls de la sessió';

  @override
  String get settings_bugReportLink => 'Informa d’un error';

  @override
  String get settings_clearCacheMessage =>
      'La memòria cau local se suprimirà i es recuperarà del servidor un cop més.';

  @override
  String get settings_itemAppearance => 'Aspecte';

  @override
  String get settings_itemAbout => 'Quant a';

  @override
  String get settings_itemAppBadge => 'Mostra la insígnia de no llegits';

  @override
  String get settings_itemClearCache => 'Neteja la memòria cau';

  @override
  String get settings_itemLogConsole => 'Consola de registres';

  @override
  String get settings_itemOpenDeeplink => 'Obre un enllaç profund';

  @override
  String get settings_itemLanguage => 'Llengua';

  @override
  String get settings_helpToTranslate => 'Ajudeu amb la traducció';

  @override
  String get settings_savedArticleTag =>
      'Afegeix una etiqueta als articles desats';

  @override
  String get settings_savedArticleTagLabel =>
      'Etiqueta per als articles desats';

  @override
  String get settings_itemSessionDetails => 'Detalls de la sessió';

  @override
  String get settings_title => 'Paràmetres';

  @override
  String get settings_nativeArticleRenderer => 'Representador d’articles natiu';

  @override
  String get settings_valueThemeDark => 'Fosc';

  @override
  String get settings_valueThemeLight => 'Clar';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString accions',
      one: '1 acció',
    );
    return '$_temp0';
  }
}
