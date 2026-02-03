// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get g_article => 'Artikel';

  @override
  String get g_check => 'Prüfen';

  @override
  String get g_checking => 'Prüfen…';

  @override
  String get g_delete => 'Löschen';

  @override
  String get g_saveLink => 'Link speichern';

  @override
  String get g_search => 'Suche';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Einstellungen';

  @override
  String get g_share => 'Teilen';

  @override
  String get g_sourceCode => 'Quellcode';

  @override
  String get g_synchronize => 'Synchronisieren';

  @override
  String get g_system => 'System';

  @override
  String get g_tag => 'Schlagwort';

  @override
  String get g_version => 'Version';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'in $duration';
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
      other: '$nString Stunden',
      one: '1 Stunde',
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
      other: '$nString Minuten',
      one: '1 Minute',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'Vor $duration';
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
      other: '$nString Sekunden',
      one: '1 Sekunde',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Schlagwörter hinzufügen';

  @override
  String get article_archive => 'Titel archivieren';

  @override
  String get article_browseOriginal => 'Zum Original gehen';

  @override
  String get article_delete => 'Artikel löschen';

  @override
  String get article_details => 'Weitere Informationen';

  @override
  String get article_noContentFetched => 'Kein Inhalt abgerufen';

  @override
  String get article_notFound => 'Artikel nicht gefunden';

  @override
  String get article_openInBrowser => 'Im Browser öffnen';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString Minuten';
  }

  @override
  String get article_refetchContent => 'Inhalt neu laden';

  @override
  String get article_readingSettings => 'Texteinstellungen';

  @override
  String get article_share => 'Artikel teilen';

  @override
  String get article_star => 'Artikel favorisieren';

  @override
  String get article_unarchive => 'Artikel dearchivieren';

  @override
  String get article_unstar =>
      'Entfernung der Favorisierung von diesem Artikel';

  @override
  String get articlefields_readingTime => 'Lesedauer';

  @override
  String get articlefields_tags => 'Tags';

  @override
  String get articlefields_title => 'Titel';

  @override
  String get articlefields_website => 'Webseite';

  @override
  String get filters_articleDomains => 'Domains';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Domains',
      one: '1 Domain',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Mit Stern';

  @override
  String get filters_articleState => 'Status';

  @override
  String get filters_articleStateUnread => 'Ungelesen';

  @override
  String get filters_articleStateArchived => 'Archivierte';

  @override
  String get filters_articleStateAll => 'Alle Status';

  @override
  String get filters_articleTags => 'Schlagwörter';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Tags',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'In Artikeln suchen';

  @override
  String get filters_searchMode => 'Suchmodus';

  @override
  String get filters_searchModeAll => 'Alle Felder';

  @override
  String get filters_searchModeContent => 'Inhalt';

  @override
  String get filters_searchModeTitle => 'Titel';

  @override
  String get logconsole_title => 'Konsolen-Log';

  @override
  String get logconsole_clear_logs => 'Protokolle löschen';

  @override
  String get logconsole_export_title => 'Als Datei exportieren';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Zeilen',
      one: '1 Zeile',
    );
    return 'Aktuelle Sitzung ($_temp0)';
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
      other: '$countString Zeilen',
      one: '1 line',
    );
    return 'Alle Protokolle ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Keine Artikel';

  @override
  String get listing_articlesAll => 'Alle Artikel';

  @override
  String get listing_articlesArchived => 'Archivierte';

  @override
  String get listing_articlesUnread => 'Ungelesene';

  @override
  String get login_acceptSelfSigned => 'Erlaube selbst signierte Zertifikate';

  @override
  String get login_actionLogin => 'Einloggen';

  @override
  String get login_existingSessionDialogConfirm => 'Ausloggen';

  @override
  String get login_existingSessionDialogMessage =>
      'Möchtest du dich von der aktuellen Session abmelden und eine neue eröffnen?';

  @override
  String get login_existingSessionDialogTitle =>
      'Eine Session ist gerade aktiv';

  @override
  String get login_fieldClientId => 'Client ID';

  @override
  String get login_fieldClientSecret => 'Client Secret';

  @override
  String get login_fieldPassword => 'Passwort';

  @override
  String get login_fieldUsername => 'Username';

  @override
  String get login_openLogConsole => 'Log Konsole öffnen';

  @override
  String get readingsettings_fontFamily => 'Schriftfamilie';

  @override
  String get readingsettings_fontSize => 'Schriftgröße';

  @override
  String get readdingsettings_textFormatting => 'Textformatierung';

  @override
  String get readingsettings_title => 'Text-Einstellungen';

  @override
  String get save_confirmationTitle => 'Artikel gespeichert!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Diese URL sieht nicht wie eine aus. Trotzdem speichern?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Speichern';

  @override
  String get save_dubiousUrlTitle => 'Ungewöhnliche URL';

  @override
  String get save_noUrl => 'Keine URL bereitgestellt';

  @override
  String get save_title => 'Artikel speichern';

  @override
  String get save_viewArticle => 'Artikel betrachten';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return '$numberOfItems wählen';
  }

  @override
  String get server_address => 'Server Adresse';

  @override
  String server_emptyField(String label) {
    return 'Gebe dein $label ein';
  }

  @override
  String get server_invalidUrl => 'Ungültige Adresse';

  @override
  String get server_unknownServerType => 'Unbekannter Servertyp';

  @override
  String get server_unreachable => 'Server nicht erreichbar';

  @override
  String get server_versionNotSupported =>
      'Serverversion wird nicht unterstützt';

  @override
  String get session_copiedToClipboard => 'In die Zwischenablage kopiert';

  @override
  String get session_invalidToken => 'Ungültig';

  @override
  String get session_logoutDialogConfirm => 'Ausloggen';

  @override
  String get session_logoutDialogMessage =>
      'Du wirst dich erneut einloggen müssen.';

  @override
  String get session_logoutDialogTitle => 'Session ausloggen';

  @override
  String get session_logoutSession => 'Session ausloggen';

  @override
  String get session_fieldAccessToken => 'Access token';

  @override
  String get session_fieldApiToken => 'API Token';

  @override
  String get session_fieldLastServerSync =>
      'Letzte Synchronisierung mit dem Server';

  @override
  String get session_fieldTokenExpiration => 'Ablauf des Tokens';

  @override
  String get session_forceTokenResfresh => 'Erzwinge einen neuen Token';

  @override
  String get session_neverSynced => 'Noch nie';

  @override
  String get session_renewDialogMessage =>
      'Der Server lehnt den aktuellen Session Token ab. Du wirst dich erneut einloggen müssen um dir Synchronisierung fortsetzen zu können.';

  @override
  String get session_renewDialogTitle => 'Session erneuern';

  @override
  String get session_title => 'Details der Session';

  @override
  String get settings_bugReportLink => 'Einen Fehler melden';

  @override
  String get settings_clearCacheMessage =>
      'Der lokale Cache wird gelöscht und erneut vom Server abgerufen.';

  @override
  String get settings_itemAppearance => 'Design';

  @override
  String get settings_itemAbout => 'Über';

  @override
  String get settings_itemAppBadge => 'Zeige ungelesene Anzahl';

  @override
  String get settings_itemClearCache => 'Cache leeren';

  @override
  String get settings_itemLogConsole => 'Log Konsole';

  @override
  String get settings_itemOpenDeeplink => 'Einen tiefen Link öffnen';

  @override
  String get settings_itemLanguage => 'Sprache';

  @override
  String get settings_helpToTranslate => 'Beim Übersetzen helfen';

  @override
  String get settings_savedArticleTag =>
      'Füge ein Schlagwort zu gespeicherten Artikeln hinzu';

  @override
  String get settings_savedArticleTagLabel =>
      'Schlagwort für gespeicherte Artikel';

  @override
  String get settings_itemSessionDetails => 'Details der Session';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_nativeArticleRenderer => 'Nativer Artikel Renderer';

  @override
  String get settings_valueThemeDark => 'Dunkel';

  @override
  String get settings_valueThemeLight => 'Hell';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Aktionen',
      one: '1 Aktion',
    );
    return '$_temp0';
  }
}
