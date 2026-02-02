// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get g_article => 'Artikkel';

  @override
  String get g_check => 'Kontrolli';

  @override
  String get g_checking => 'Kontrollime…';

  @override
  String get g_delete => 'Kustuta';

  @override
  String get g_saveLink => 'Salvesta link';

  @override
  String get g_search => 'Otsi';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Seadistused';

  @override
  String get g_share => 'Jaga';

  @override
  String get g_sourceCode => 'Lähtekood';

  @override
  String get g_synchronize => 'Sünkroniseeri';

  @override
  String get g_system => 'Süsteemikohane';

  @override
  String get g_tag => 'Silt';

  @override
  String get g_version => 'Versioon';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString päeva',
      one: '1 päev',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'kestusega $duration';
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
      other: '$nString tundi',
      one: '1 tund',
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
      other: '$nString minutit',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration tagasi';
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
      other: '$nString sekundit',
      one: '1 sekund',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Lisa silte';

  @override
  String get article_archive => 'Arhiveeri see artikkel';

  @override
  String get article_browseOriginal => 'Vaata algset artiklit';

  @override
  String get article_delete => 'Kustuta see artikkel';

  @override
  String get article_details => 'Lisateave';

  @override
  String get article_noContentFetched => 'Sisu on laadimata';

  @override
  String get article_notFound => 'Artiklit ei leidu';

  @override
  String get article_openInBrowser => 'Ava veebibrauseris';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Laadi sisu uuesti';

  @override
  String get article_readingSettings => 'Tekstiseadistused';

  @override
  String get article_share => 'Jaga seda artiklit';

  @override
  String get article_star => 'Märgi see artikkel tähekesega';

  @override
  String get article_unarchive => 'Eemalda see artikkel arhiivist';

  @override
  String get article_unstar => 'Eemalda selt artiklilt täheke';

  @override
  String get articlefields_readingTime => 'Lugemisaeg';

  @override
  String get articlefields_tags => 'Sildid';

  @override
  String get articlefields_title => 'Pealkiri';

  @override
  String get articlefields_website => 'Veebisait';

  @override
  String get filters_articleDomains => 'Domeenid';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domeeni',
      one: '1 domeen',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Tähekesega märgitud';

  @override
  String get filters_articleState => 'Olek';

  @override
  String get filters_articleStateUnread => 'Lugemata';

  @override
  String get filters_articleStateArchived => 'Arhiveeritud';

  @override
  String get filters_articleStateAll => 'Kõik olekud';

  @override
  String get filters_articleTags => 'Sildid';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString silti',
      one: '1 silt',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Otsi artiklitest';

  @override
  String get filters_searchMode => 'Otsinguviis';

  @override
  String get filters_searchModeAll => 'Otsi kõikidest väljadest';

  @override
  String get filters_searchModeContent => 'Otsi sisuväljadest';

  @override
  String get filters_searchModeTitle => 'Otsi pealkirjast';

  @override
  String get logconsole_title => 'Logimiskonsool';

  @override
  String get logconsole_clear_logs => 'Kustuta logid';

  @override
  String get logconsole_export_title => 'Ekspordi failina';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString rida',
      one: '1 rida',
    );
    return 'Praegune sessioon: ($_temp0)';
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
      other: '$countString rida',
      one: '1 rida',
    );
    return 'Kõik logid ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Artikleid pole';

  @override
  String get listing_articlesAll => 'Kõik artiklid';

  @override
  String get listing_articlesArchived => 'Arhiveeritud artiklid';

  @override
  String get listing_articlesUnread => 'Lugemata artiklid';

  @override
  String get login_acceptSelfSigned =>
      'Nõustu iseallkirjastatud sertifikaatidega';

  @override
  String get login_actionLogin => 'Logi sisse';

  @override
  String get login_existingSessionDialogConfirm => 'Logi välja';

  @override
  String get login_existingSessionDialogMessage =>
      'Kas soovid praegusest sessioonist välja logida ja uue avada?';

  @override
  String get login_existingSessionDialogTitle => 'Sessioon on praegu aktiivne';

  @override
  String get login_fieldClientId => 'Kliendi tunnus';

  @override
  String get login_fieldClientSecret => 'Kliendi saladus';

  @override
  String get login_fieldPassword => 'Salasõna';

  @override
  String get login_fieldUsername => 'Kasutajanimi';

  @override
  String get login_openLogConsole => 'Ava logimiskonsool';

  @override
  String get readingsettings_fontFamily => 'Kirjatüübi perekond';

  @override
  String get readingsettings_fontSize => 'Kirjatüübi suurus';

  @override
  String get readdingsettings_textFormatting => 'Teksti vormindus';

  @override
  String get readingsettings_title => 'Tekstiseadistused';

  @override
  String get save_confirmationTitle => 'Artikkel on salvestatud!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'See võrguaadress ei tundu olema õige võrguaadressi moodi. Kas salvestame ta ikkagi?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Salvesta ikkagi';

  @override
  String get save_dubiousUrlTitle => 'Kahtlane veebiaadress';

  @override
  String get save_noUrl => 'Veebiaadress on puudu';

  @override
  String get save_title => 'Salvesta artikkel';

  @override
  String get save_viewArticle => 'Vaata artiklit';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Vali $numberOfItems';
  }

  @override
  String get server_address => 'Serveri aadress';

  @override
  String server_emptyField(String label) {
    return 'Sisesta $label';
  }

  @override
  String get server_invalidUrl => 'Vigane aadress';

  @override
  String get server_unknownServerType => 'Tundmatu serveri tüüp';

  @override
  String get server_unreachable => 'Server pole leitav';

  @override
  String get server_versionNotSupported => 'Serveri versiooni pole toetatud';

  @override
  String get session_copiedToClipboard => 'Kopeerisin lõikelauale';

  @override
  String get session_invalidToken => 'vigane';

  @override
  String get session_logoutDialogConfirm => 'Logi välja';

  @override
  String get session_logoutDialogMessage => 'Pead uuesti sisse logima.';

  @override
  String get session_logoutDialogTitle => 'Logi sessioonist välja';

  @override
  String get session_logoutSession => 'Logi sessioonist välja';

  @override
  String get session_fieldAccessToken => 'Ligipääsu tunnusluba';

  @override
  String get session_fieldApiToken => 'API tunnusluba';

  @override
  String get session_fieldLastServerSync =>
      'Viimane sünkrooniseerimine serveriga';

  @override
  String get session_fieldTokenExpiration => 'Tunnusloa aegumine';

  @override
  String get session_forceTokenResfresh => 'Sunni tunnusloa uuendamist';

  @override
  String get session_neverSynced => 'mitte kunagi';

  @override
  String get session_renewDialogMessage =>
      'Server keeldub praeguse tunnusloa kaotamisest. Sünkroniseerimise jätkamiseks pead uuesti sisse logima.';

  @override
  String get session_renewDialogTitle => 'Uuenda sessiooni';

  @override
  String get session_title => 'Sessiooni üksikasjad';

  @override
  String get settings_bugReportLink => 'Teata vigadest';

  @override
  String get settings_clearCacheMessage =>
      'Järgnevaga kustutame kohaliku vahemälu ja laadime andmed serverist uuesti.';

  @override
  String get settings_itemAppearance => 'Välimus';

  @override
  String get settings_itemAbout => 'Rakenduse teave';

  @override
  String get settings_itemAppBadge => 'Näita „Lugemata“ silti';

  @override
  String get settings_itemClearCache => 'Kustuta puhverdatud andmed';

  @override
  String get settings_itemLogConsole => 'Logimiskonsool';

  @override
  String get settings_itemOpenDeeplink => 'Ava täppislink';

  @override
  String get settings_itemLanguage => 'Keel';

  @override
  String get settings_helpToTranslate => 'Aita tõlkida';

  @override
  String get settings_savedArticleTag => 'Lisa salvestatud artiklitele silt';

  @override
  String get settings_savedArticleTagLabel =>
      'Silt salvestatud artiklite jaoks';

  @override
  String get settings_itemSessionDetails => 'Sessiooni üksikasjad';

  @override
  String get settings_title => 'Seadistused';

  @override
  String get settings_nativeArticleRenderer =>
      'Rakendusesisene artiklite esitusvalmendus';

  @override
  String get settings_valueThemeDark => 'Tume kujundus';

  @override
  String get settings_valueThemeLight => 'Hele kujundus';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString tegevust',
      one: '1 tegevus',
    );
    return '$_temp0';
  }
}
