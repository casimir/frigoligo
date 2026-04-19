// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get g_article => 'Artikel';

  @override
  String get g_check => 'Kontroleer';

  @override
  String get g_checking => 'Kontroleer tans…';

  @override
  String get g_delete => 'Skrap';

  @override
  String get g_saveLink => 'Stoor skakel';

  @override
  String get g_search => 'Soek';

  @override
  String get g_server => 'Bediener';

  @override
  String get g_settings => 'Instellings';

  @override
  String get g_share => 'Deel';

  @override
  String get g_sourceCode => 'Bronkode';

  @override
  String get g_synchronize => 'Sinkroniseer';

  @override
  String get g_system => 'Stelselstandaard';

  @override
  String get g_tag => 'Etiket';

  @override
  String get g_version => 'Weergawe';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dae',
      one: '1 dag',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'binne $duration';
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
      other: '$nString minute',
      one: '1 minuut',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration gelede';
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
      other: '$nString secondes',
      one: '1 seconde',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Voeg etikette by';

  @override
  String get article_archive => 'Argiveer dié artikel';

  @override
  String get article_browseOriginal => 'Soek oorspronklike artikel aanlyn';

  @override
  String get article_delete => 'Skrap dié artikel';

  @override
  String get article_details => 'Meer inligtings';

  @override
  String get article_noContentFetched => 'Kon nie artikel laai nie';

  @override
  String get article_notFound => 'Kon nie artikel vind nie';

  @override
  String get article_openInBrowser => 'Maak oop in webblaaier';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Herlaai die artikelinhoud';

  @override
  String get article_readingSettings => 'Teksinstellings';

  @override
  String get article_share => 'Deel die artikel';

  @override
  String get article_star => 'Voeg artikel by gunstelinge';

  @override
  String get article_unarchive => 'Verwyder artikel uit argief';

  @override
  String get article_unstar => 'Verwyder artikel uit gunstelinge';

  @override
  String get articlefields_readingTime => 'Leestyd';

  @override
  String get articlefields_tags => 'Etikette';

  @override
  String get articlefields_title => 'Titel';

  @override
  String get articlefields_website => 'Webwerf';

  @override
  String get filters_articleDomains => 'Domeine';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domeine',
      one: '1 domein',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Gunstelinge';

  @override
  String get filters_articleState => 'Status';

  @override
  String get filters_articleStateUnread => 'Ongelees';

  @override
  String get filters_articleStateArchived => 'Geargiveer';

  @override
  String get filters_articleStateAll => 'Alle statusse';

  @override
  String get filters_articleTags => 'Etikette';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString etikette',
      one: '1 etiket',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Soek in artikels';

  @override
  String get filters_searchMode => 'Soekmodus';

  @override
  String get filters_searchModeAll => 'In alle velde';

  @override
  String get filters_searchModeContent => 'Slegs in inhoudveld';

  @override
  String get filters_searchModeTitle => 'Slegs in titelveld';

  @override
  String get logconsole_title => 'Logboekkonsole';

  @override
  String get logconsole_clear_logs => 'Maak logboek skoon';

  @override
  String get logconsole_export_title => 'Uitvoer as lêer';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString reëls',
      one: '1 reël',
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
      other: '$countString reëls',
      one: '1 reël',
    );
    return 'Alle logreëls ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Geen artikels om te vertoon nie';

  @override
  String get listing_articlesAll => 'Alle artikels';

  @override
  String get listing_articlesArchived => 'Geargiveerde artikels';

  @override
  String get listing_articlesUnread => 'Ongeleesde artikels';

  @override
  String get login_acceptSelfSigned => 'Aanvaar selfgetekende sertifikate';

  @override
  String get login_actionLogin => 'Meld aan';

  @override
  String get login_demoMode => 'Try in demo mode';

  @override
  String get login_existingSessionDialogConfirm => 'Meld af';

  @override
  String get login_existingSessionDialogMessage =>
      'Wil u uit die huidige sessie afmeld en \'n nuwe sessie oopmaak?';

  @override
  String get login_existingSessionDialogTitle =>
      'Daar is nog \'n sessie aktief';

  @override
  String get login_fieldClientId => 'Kliënt-ID';

  @override
  String get login_fieldClientSecret => 'Kliëntgeheim';

  @override
  String get login_fieldPassword => 'Wagwoord';

  @override
  String get login_fieldUsername => 'Gebruikersnaam';

  @override
  String get login_openLogConsole => 'Open the Log Console';

  @override
  String get readingsettings_fontFamily => 'Font family';

  @override
  String get readingsettings_fontSize => 'Lettergrootte';

  @override
  String get readdingsettings_textFormatting => 'Teksformatering';

  @override
  String get readingsettings_title => 'Teksinstellings';

  @override
  String get save_confirmationTitle => 'Artikel is gestoor!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'This URL does not look like one. Save it anyway?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Stoor';

  @override
  String get save_dubiousUrlTitle => 'Twyfelagtige URL';

  @override
  String get save_noUrl => 'Geen URL opgegee';

  @override
  String get save_title => 'Stoor die artikel';

  @override
  String get save_viewArticle => 'Bekyk die artikel';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Kies $numberOfItems';
  }

  @override
  String get server_address => 'Bedienersadres';

  @override
  String server_emptyField(String label) {
    return 'Voer uw $label in';
  }

  @override
  String get server_invalidUrl => 'Ongeldige adres';

  @override
  String get server_unknownServerType => 'Onbekende bedienerstipe';

  @override
  String get server_unreachable => 'Bediener onbereikbaar';

  @override
  String get server_versionNotSupported =>
      'Bedienersweergawe word nie ondersteun nie';

  @override
  String get session_copiedToClipboard => 'Na die knipbord gekopieer';

  @override
  String get session_invalidToken => 'ongeldig';

  @override
  String get session_logoutDialogConfirm => 'Meld af';

  @override
  String get session_logoutDialogMessage => 'U sal dan weer moet aanmeld.';

  @override
  String get session_logoutDialogTitle => 'Meld af van die sessie';

  @override
  String get session_logoutSession => 'Meld af van die sessie';

  @override
  String get session_fieldAccessToken => 'Toegangsbewys';

  @override
  String get session_fieldApiToken => 'API token';

  @override
  String get session_fieldLastServerSync => 'Last server sync';

  @override
  String get session_fieldTokenExpiration => 'Token expiration';

  @override
  String get session_forceTokenResfresh => 'Force token refresh';

  @override
  String get session_neverSynced => 'nooit';

  @override
  String get session_renewDialogMessage =>
      'The server refuses the current session token. You will need to log in again to resume the synchronization.';

  @override
  String get session_renewDialogTitle => 'Renew session';

  @override
  String get session_title => 'Session details';

  @override
  String get settings_bugReportLink => 'Report a bug';

  @override
  String get settings_clearCacheMessage =>
      'The local cache will be deleted and fetched again from the server.';

  @override
  String get settings_itemAppearance => 'Appearance';

  @override
  String get settings_itemAbout => 'Meer oor';

  @override
  String get settings_itemAppBadge => 'Show unread badge';

  @override
  String get settings_itemClearCache => 'Clear cache';

  @override
  String get settings_itemLicenses => 'View licenses';

  @override
  String get settings_itemLogConsole => 'Log Console';

  @override
  String get settings_itemOpenDeeplink => 'Open a deep link';

  @override
  String get settings_itemLanguage => 'Taal';

  @override
  String get settings_helpToTranslate => 'Help vertaal';

  @override
  String get settings_savedArticleTag =>
      'Voeg \'n etiket by gestoorde artikels';

  @override
  String get settings_savedArticleTagLabel => 'Label for saved articles';

  @override
  String get settings_itemSessionDetails => 'Session details';

  @override
  String get settings_title => 'Instellings';

  @override
  String get settings_nativeArticleRenderer => 'Native article renderer';

  @override
  String get settings_valueThemeDark => 'Donker';

  @override
  String get settings_valueThemeLight => 'Ligte';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString aksies',
      one: '1 aksie',
    );
    return '$_temp0';
  }
}
