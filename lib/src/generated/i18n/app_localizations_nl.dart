// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get g_article => 'Artikel';

  @override
  String get g_check => 'Controleren';

  @override
  String get g_checking => 'Controleren…';

  @override
  String get g_delete => 'Verwijderen';

  @override
  String get g_saveLink => 'Link opslaan';

  @override
  String get g_search => 'Zoeken';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Instellingen';

  @override
  String get g_share => 'Delen';

  @override
  String get g_sourceCode => 'Broncode';

  @override
  String get g_synchronize => 'Synchroniseren';

  @override
  String get g_system => 'Systeemstandaard';

  @override
  String get g_tag => 'Label';

  @override
  String get g_version => 'Versie';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dagen',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'binnen $duration';
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
      other: '$nString uur',
      one: '1 uur',
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
      other: '$nString minuten',
      one: '1 minuut',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration geleden';
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
      other: '$nString seconden',
      one: '1 seconde',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Labels toevoegen';

  @override
  String get article_archive => 'Artikel archiveren';

  @override
  String get article_browseOriginal => 'Het originele artikel opzoeken';

  @override
  String get article_delete => 'Artikel verwijderen';

  @override
  String get article_details => 'Meer informatie';

  @override
  String get article_noContentFetched =>
      'Kon de inhoud van het artikel niet laden';

  @override
  String get article_notFound => 'Artikel niet gevonden';

  @override
  String get article_openInBrowser => 'In webbrowser openen';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Artikel opnieuw laden';

  @override
  String get article_readingSettings => 'Tekstinstellingen';

  @override
  String get article_share => 'Artikel delen';

  @override
  String get article_star => 'Artikel aan favorieten toevoegen';

  @override
  String get article_unarchive => 'Artikel uit het archief halen';

  @override
  String get article_unstar => 'Artikel uit favorieten verwijderen';

  @override
  String get articlefields_readingTime => 'Leestijd';

  @override
  String get articlefields_tags => 'Labels';

  @override
  String get articlefields_title => 'Titel';

  @override
  String get articlefields_website => 'Website';

  @override
  String get filters_articleDomains => 'Domeinen';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domeinen',
      one: '1 domein',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Favorieten';

  @override
  String get filters_articleState => 'Status';

  @override
  String get filters_articleStateUnread => 'Ongelezen';

  @override
  String get filters_articleStateArchived => 'Gearchiveerd';

  @override
  String get filters_articleStateAll => 'Alle statussen';

  @override
  String get filters_articleTags => 'Labels';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString labels',
      one: '1 label',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'In artikelen zoeken';

  @override
  String get filters_searchMode => 'Zoekmodus';

  @override
  String get filters_searchModeAll => 'Alle velden';

  @override
  String get filters_searchModeContent => 'Inhoud';

  @override
  String get filters_searchModeTitle => 'Titel';

  @override
  String get logconsole_title => 'Logboekconsole';

  @override
  String get logconsole_clear_logs => 'Logboek wissen';

  @override
  String get logconsole_export_title => 'Als bestand exporteren';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString regels',
      one: '1 regel',
    );
    return 'Huidige sessie ($_temp0)';
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
      other: '$countString regels',
      one: '1 regel',
    );
    return 'Alle logregels ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Geen artikelen om weer te geven';

  @override
  String get listing_articlesAll => 'Alle artikelen';

  @override
  String get listing_articlesArchived => 'Gearchiveerde artikelen';

  @override
  String get listing_articlesUnread => 'Ongelezen artikelen';

  @override
  String get login_acceptSelfSigned =>
      'Zelfondertekende certificaten accepteren';

  @override
  String get login_actionLogin => 'Inloggen';

  @override
  String get login_demoMode => 'Probeer in demomodus';

  @override
  String get login_existingSessionDialogConfirm => 'Afmelden';

  @override
  String get login_existingSessionDialogMessage =>
      'Wilt u zich afmelden bij de huidige sessie en een nieuwe sessie openen?';

  @override
  String get login_existingSessionDialogTitle => 'Er is nog een sessie actief';

  @override
  String get login_fieldClientId => 'Client-ID';

  @override
  String get login_fieldClientSecret => 'Clientgeheim';

  @override
  String get login_fieldPassword => 'Wachtwoord';

  @override
  String get login_fieldUsername => 'Gebruikersnaam';

  @override
  String get login_openLogConsole => 'Logboekconsole openen';

  @override
  String get readingsettings_fontFamily => 'Lettertypefamilie';

  @override
  String get readingsettings_fontSize => 'Lettergrootte';

  @override
  String get readdingsettings_textFormatting => 'Tekstopmaak';

  @override
  String get readingsettings_title => 'Tekstinstellingen';

  @override
  String get save_confirmationTitle => 'Artikel opgeslagen!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Dit lijkt niet op een URL. Toch opslaan?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Opslaan';

  @override
  String get save_dubiousUrlTitle => 'Dubieuze URL';

  @override
  String get save_noUrl => 'Geen URL opgegeven';

  @override
  String get save_title => 'Artikel opslaan';

  @override
  String get save_viewArticle => 'Artikel bekijken';

  @override
  String get save_localModeError =>
      'Een serververbinding is vereist om nieuwe artikelen op te slaan.';

  @override
  String save_malformedUrlError(String url) {
    return 'Onjuiste URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return '$numberOfItems selecteren';
  }

  @override
  String get server_address => 'Serveradres';

  @override
  String server_emptyField(String label) {
    return 'Voeg uw $label in';
  }

  @override
  String get server_invalidUrl => 'Ongeldig adres';

  @override
  String get server_unknownServerType => 'Onbekend servertype';

  @override
  String get server_unreachable => 'Server onbereikbaar';

  @override
  String get server_versionNotSupported =>
      'Serverversie wordt niet ondersteund';

  @override
  String get session_copiedToClipboard => 'Gekopieerd naar klembord';

  @override
  String get session_invalidToken => 'ongeldig';

  @override
  String get session_logoutDialogConfirm => 'Afmelden';

  @override
  String get session_logoutDialogMessage => 'U moet zich opnieuw aanmelden.';

  @override
  String get session_logoutDialogTitle => 'Sessie afmelden';

  @override
  String get session_logoutSession => 'Sessie afmelden';

  @override
  String get session_fieldAccessToken => 'Toegangstoken';

  @override
  String get session_fieldApiToken => 'API token';

  @override
  String get session_fieldLastServerSync =>
      'Laaste synchronisatie met de server';

  @override
  String get session_fieldTokenExpiration => 'Tokenvervaldatum';

  @override
  String get session_forceTokenResfresh => 'Tokenvernieuwing forceren';

  @override
  String get session_neverSynced => 'nooit';

  @override
  String get session_renewDialogMessage =>
      'De server weigert het huidige sessietoken. U moet zich opnieuw aanmelden om de synchronisatie te hervatten.';

  @override
  String get session_renewDialogTitle => 'Sessie vernieuwen';

  @override
  String get session_title => 'Sessiedetails';

  @override
  String get settings_bugReportLink => 'Een bug melden';

  @override
  String get settings_clearCacheMessage =>
      'De lokale cache wordt verwijderd en wordt opnieuw bij de server opgehaald.';

  @override
  String get settings_itemAppearance => 'Uiterlijk';

  @override
  String get settings_itemAbout => 'Over';

  @override
  String get settings_itemAppBadge => 'Ongelezen als zodanig mankeren';

  @override
  String get settings_itemClearCache => 'Cache wissen';

  @override
  String get settings_itemLicenses => 'Licenties bekijken';

  @override
  String get settings_itemLogConsole => 'Logboekconsole';

  @override
  String get settings_itemOpenDeeplink => 'Een deeplink openen';

  @override
  String get settings_itemLanguage => 'Taal';

  @override
  String get settings_helpToTranslate => 'Help mee met vertalen';

  @override
  String get settings_savedArticleTag =>
      'Opgeslagen artikelen als zodanig mankeren';

  @override
  String get settings_savedArticleTagLabel => 'Label voor opgeslagen artikelen';

  @override
  String get settings_itemSessionDetails => 'Sessiedetails';

  @override
  String get settings_title => 'Instellingen';

  @override
  String get settings_nativeArticleRenderer => 'Native artikelweergave';

  @override
  String get settings_valueThemeDark => 'Donker';

  @override
  String get settings_valueThemeLight => 'Licht';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString acties',
      one: '1 actie',
    );
    return '$_temp0';
  }
}
