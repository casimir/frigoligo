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
  String get g_search => 'Zoek';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Instellingen';

  @override
  String get g_share => 'Deel';

  @override
  String get g_sourceCode => 'Broncode';

  @override
  String get g_synchronize => 'Synchroniseren';

  @override
  String get g_system => 'Systeem';

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
      other: '$nString uren',
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
  String get article_browseOriginal => 'Origineel openen';

  @override
  String get article_delete => 'Artikel verwijderen';

  @override
  String get article_details => 'Meer informatie';

  @override
  String get article_noContentFetched => 'Geen inhoud opgehaald';

  @override
  String get article_notFound => 'Artikel niet gevonden';

  @override
  String get article_openInBrowser => 'In browser openen';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Inhoud herladen';

  @override
  String get article_readingSettings => 'Text instellingen';

  @override
  String get article_share => 'Artikel delen';

  @override
  String get article_star => 'Geef dit artikel een ster';

  @override
  String get article_unarchive => 'Dit artikel uit het archief halen';

  @override
  String get article_unstar => 'Verwijder de ster van dit artikel';

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
  String get filters_articleFavoriteStarred => 'Favoriet';

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
  String get filters_searchbarHint => 'Zoek in artikels';

  @override
  String get filters_searchMode => 'Zoekwijze';

  @override
  String get filters_searchModeAll => 'Alle velden';

  @override
  String get filters_searchModeContent => 'Inhoud';

  @override
  String get filters_searchModeTitle => 'Titel';

  @override
  String get logconsole_title => 'Logconsole';

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
  String get listing_noArticles => 'Geen artikels';

  @override
  String get listing_articlesAll => 'Alle artikels';

  @override
  String get listing_articlesArchived => 'Gearchiveerde artikelen';

  @override
  String get listing_articlesUnread => 'Ongelezen artikels';

  @override
  String get login_acceptSelfSigned => 'Aanvaard zelfondertekende certificaten';

  @override
  String get login_actionLogin => 'Inloggen';

  @override
  String get login_existingSessionDialogConfirm => 'Afmelden';

  @override
  String get login_existingSessionDialogMessage =>
      'Wilt u uitloggen uit de huidige sessie en een nieuwe sessie openen?';

  @override
  String get login_existingSessionDialogTitle => 'Er is een sessie actief';

  @override
  String get login_fieldClientId => 'Client ID';

  @override
  String get login_fieldClientSecret => 'Geheim client';

  @override
  String get login_fieldPassword => 'Wachtwoord';

  @override
  String get login_fieldUsername => 'Gebruikersnaam';

  @override
  String get login_openLogConsole => 'Open de logconsole';

  @override
  String get readingsettings_fontFamily => 'Lettertype';

  @override
  String get readingsettings_fontSize => 'Lettergrootte';

  @override
  String get readdingsettings_textFormatting => 'Tekstopmaak';

  @override
  String get readingsettings_title => 'Tekst-instellingen';

  @override
  String get save_confirmationTitle => 'Artikel opgeslagen!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Deze URL lijkt niet juist. Toch opslaan?\n$url';
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
  String get save_viewArticle => 'Bekijk artikel';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecteer $numberOfItems';
  }

  @override
  String get server_address => 'Adres server';

  @override
  String server_emptyField(String label) {
    return 'Voer je $label in';
  }

  @override
  String get server_invalidUrl => 'Ongeldig adres';

  @override
  String get server_unknownServerType => 'Onbekend servertype';

  @override
  String get server_unreachable => 'Server onbereikbaar';

  @override
  String get server_versionNotSupported => 'Serverversie niet ondersteund';

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
  String get session_fieldLastServerSync => 'Laatste server synchronisatie';

  @override
  String get session_fieldTokenExpiration => 'Verval token';

  @override
  String get session_forceTokenResfresh => 'Vernieuwen token forceren';

  @override
  String get session_neverSynced => 'nooit';

  @override
  String get session_renewDialogMessage =>
      'De server weigert het huidige sessietoken. U moet zich opnieuw aanmelden om de synchronisatie te hervatten.';

  @override
  String get session_renewDialogTitle => 'Vernieuw sessie';

  @override
  String get session_title => 'Details sessie';

  @override
  String get settings_bugReportLink => 'Een bug melden';

  @override
  String get settings_clearCacheMessage =>
      'De lokale cache wordt verwijderd en opnieuw opgehaald van de server.';

  @override
  String get settings_itemAppearance => 'Uiterlijk';

  @override
  String get settings_itemAbout => 'Over';

  @override
  String get settings_itemAppBadge => 'Badge \"ongelezen\" weergeven';

  @override
  String get settings_itemClearCache => 'Cache wissen';

  @override
  String get settings_itemLogConsole => 'Logconsole';

  @override
  String get settings_itemOpenDeeplink => 'Een diepe link openen';

  @override
  String get settings_itemLanguage => 'Taal';

  @override
  String get settings_helpToTranslate => 'Help vertalen';

  @override
  String get settings_savedArticleTag => 'Een tag toevoegen bij het opslaan';

  @override
  String get settings_savedArticleTagLabel => 'Label voor opgeslagen artikelen';

  @override
  String get settings_itemSessionDetails => 'Details sessie';

  @override
  String get settings_title => 'Instellingen';

  @override
  String get settings_nativeArticleRenderer => 'Native artikelrenderer';

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
