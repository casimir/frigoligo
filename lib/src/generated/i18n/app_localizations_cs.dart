// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get g_article => 'Článek';

  @override
  String get g_articles => 'Články';

  @override
  String get g_check => 'Zkontrolovat';

  @override
  String get g_checking => 'Probíhá kontrola…';

  @override
  String get g_delete => 'Smazat';

  @override
  String get g_saveLink => 'Uložit odkaz';

  @override
  String get g_search => 'Hledat';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Nastavení';

  @override
  String get g_share => 'Sdílet';

  @override
  String get g_sourceCode => 'Zdrojový kód';

  @override
  String get g_synchronize => 'Synchronizovat';

  @override
  String get g_system => 'Systém';

  @override
  String get g_tag => 'Štítek';

  @override
  String get g_version => 'Verze';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dnů',
      few: '$nString dny',
      one: '1 den',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'za $duration';
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
      other: '$nString hodin',
      few: '$nString hodiny',
      one: '1 hodinu',
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
      other: '$nString minut',
      few: '$nString minuty',
      one: '1 minutu',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration zpět';
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
      other: '$nString vteřin',
      few: '$nString vteřiny',
      one: '1 vteřinu',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Přidat štítky';

  @override
  String get article_archive => 'Archivovat tento článek';

  @override
  String get article_browseOriginal => 'Prohlédnout originál';

  @override
  String get article_delete => 'Odstranit tento článek';

  @override
  String get article_details => 'Více informací';

  @override
  String get article_noContentFetched => 'Nebyl načten žádný obsah';

  @override
  String get article_notFound => 'Článek nenalezen';

  @override
  String get article_openInBrowser => 'Otevřít v prohlížeči';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Znovu načíst obsah';

  @override
  String get article_readingSettings => 'Textové nastavení';

  @override
  String get article_share => 'Sdílet tento článek';

  @override
  String get article_star => 'Označit tento článek hvězdičkou';

  @override
  String get article_unarchive => 'Zrušit archivaci tohoto článku';

  @override
  String get article_unstar => 'Odebrat tomuto článku hvězdičku';

  @override
  String get articlefields_readingTime => 'Doba čtení';

  @override
  String get articlefields_tags => 'Štítky';

  @override
  String get articlefields_title => 'Název';

  @override
  String get articlefields_website => 'Webová stránka';

  @override
  String get filters_articleDomains => 'Domény';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domén',
      few: '$countString domény',
      one: '1 doména',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'S hvězdičkou';

  @override
  String get filters_articleState => 'Stav';

  @override
  String get filters_articleStateUnread => 'Nepřečtené';

  @override
  String get filters_articleStateArchived => 'Archivované';

  @override
  String get filters_articleStateAll => 'Všechny stavy';

  @override
  String get filters_articleTags => 'Štítky';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString štítků',
      few: '$countString štítky',
      one: '1 štítek',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Hledat v článcích';

  @override
  String get filters_searchMode => 'Režim hledání';

  @override
  String get filters_searchModeAll => 'Všechna pole';

  @override
  String get filters_searchModeContent => 'Obsah';

  @override
  String get filters_searchModeTitle => 'Název';

  @override
  String get logconsole_title => 'Protokol aplikace';

  @override
  String get logconsole_clear_logs => 'Vymazat protokol';

  @override
  String get logconsole_export_title => 'Exportovat do souboru';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString řádků',
      few: '$countString řádky',
      one: '1 řádek',
    );
    return 'Aktuální spuštění ($_temp0)';
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
      other: '$countString řádků',
      few: '$countString řádky',
      one: '1 řádek',
    );
    return 'Celý protokol ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Žádné články';

  @override
  String get listing_articlesAll => 'Všechny články';

  @override
  String get listing_articlesArchived => 'Archivované články';

  @override
  String get listing_articlesUnread => 'Nepřečtené články';

  @override
  String get login_acceptSelfSigned =>
      'Přijímat certifikáty podepsané svým držitelem';

  @override
  String get login_actionLogin => 'Přihlásit se';

  @override
  String get login_demoMode => 'Vyzkoušet ukázkový režim';

  @override
  String get login_existingSessionDialogConfirm => 'Odhlásit se';

  @override
  String get login_existingSessionDialogMessage =>
      'Chcete se odhlásit z aktuální relace a zahájit novou?';

  @override
  String get login_existingSessionDialogTitle => 'Stávající relace je aktivní';

  @override
  String get login_fieldClientId => 'ID klienta';

  @override
  String get login_fieldClientSecret => 'Tajný klíč klienta';

  @override
  String get login_fieldPassword => 'Heslo';

  @override
  String get login_fieldUsername => 'Uživatelské jméno';

  @override
  String get login_openLogConsole => 'Otevřít protokol aplikace';

  @override
  String get readingsettings_fontFamily => 'Rodina písma';

  @override
  String get readingsettings_fontSize => 'Velikost písma';

  @override
  String get readdingsettings_textFormatting => 'Formátování textu';

  @override
  String get readingsettings_title => 'Textové nastavení';

  @override
  String get save_confirmationTitle => 'Článek uložen!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Toto nevypadá jako adresa URL. Přesto uložit?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Uložit';

  @override
  String get save_dubiousUrlTitle => 'Podezřelá adresa URL';

  @override
  String get save_noUrl => 'Nebyla zadána adresa URL';

  @override
  String get save_title => 'Uložit článek';

  @override
  String get save_viewArticle => 'Zobrazit článek';

  @override
  String get save_localModeError =>
      'K ukládání nových článků je nutné připojení k serveru.';

  @override
  String save_malformedUrlError(String url) {
    return 'Nesprávný formát adresy URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Vybrat $numberOfItems';
  }

  @override
  String get server_address => 'Adresa serveru';

  @override
  String server_emptyField(String label) {
    return 'Vyplňte pole „$label“';
  }

  @override
  String get server_invalidUrl => 'Neplatná adresa';

  @override
  String get server_unknownServerType => 'Neznámý typ serveru';

  @override
  String get server_unreachable => 'Server je nedostupný';

  @override
  String get server_versionNotSupported => 'Nepodporovaná verze serveru';

  @override
  String get session_copiedToClipboard => 'Zkopírováno do schránky';

  @override
  String get session_invalidToken => 'neplatný';

  @override
  String get session_logoutDialogConfirm => 'Odhlásit se';

  @override
  String get session_logoutDialogMessage => 'Budete se muset znovu přihlásit.';

  @override
  String get session_logoutDialogTitle => 'Odhlášení z relace';

  @override
  String get session_logoutSession => 'Odhlásit se z relace';

  @override
  String get session_fieldAccessToken => 'Přístupový token';

  @override
  String get session_fieldApiToken => 'Token API';

  @override
  String get session_fieldLastServerSync =>
      'Poslední synchronizace se serverem';

  @override
  String get session_fieldTokenExpiration => 'Vypršení platnosti tokenu';

  @override
  String get session_forceTokenResfresh => 'Vynutit obnovení tokenu';

  @override
  String get session_neverSynced => 'nikdy';

  @override
  String get session_renewDialogMessage =>
      'Server odmítá aktuální token relace. Chcete-li obnovit synchronizaci, budete se muset znovu přihlásit.';

  @override
  String get session_renewDialogTitle => 'Obnovit relaci';

  @override
  String get session_title => 'Podrobnosti o relaci';

  @override
  String get settings_bugReportLink => 'Nahlásit chybu';

  @override
  String get settings_clearCacheMessage =>
      'Místní mezipaměť bude vymazána a znovu načtena ze serveru.';

  @override
  String get settings_itemAdvanced => 'Pokročilé';

  @override
  String get settings_itemAppearance => 'Vzhled';

  @override
  String get settings_itemInternetCheckUrl =>
      'Adresa URL pro kontrolu připojení k internetu';

  @override
  String get settings_itemAbout => 'O aplikaci';

  @override
  String get settings_itemAppBadge => 'Zobrazovat odznak nepřečtených článků';

  @override
  String get settings_itemClearCache => 'Vymazat mezipaměť';

  @override
  String get settings_itemLicenses => 'Zobrazit licence';

  @override
  String get settings_itemLogConsole => 'Protokol aplikace';

  @override
  String get settings_itemOpenDeeplink => 'Otevřít přímý odkaz';

  @override
  String get settings_itemLanguage => 'Jazyk';

  @override
  String get settings_helpToTranslate => 'Pomoci s překladem';

  @override
  String get settings_savedArticleTag => 'Přidávat uloženým článkům štítek';

  @override
  String get settings_savedArticleTagLabel => 'Štítek pro uložené články';

  @override
  String get settings_itemSessionDetails => 'Podrobnosti o relaci';

  @override
  String get settings_title => 'Nastavení';

  @override
  String get settings_nativeArticleRenderer => 'Nativní vykreslování článků';

  @override
  String get settings_valueThemeDark => 'Tmavý';

  @override
  String get settings_valueThemeLight => 'Světlý';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString čekajících akcí',
      few: '$countString čekající akce',
      one: '1 čekající akce',
    );
    return '$_temp0';
  }

  @override
  String get sync_statusAllGood => 'Vše je synchronizováno';

  @override
  String get sync_statusSyncing => 'Probíhá synchronizace…';

  @override
  String get sync_statusNoInternet => 'Bez připojení k internetu';

  @override
  String get sync_statusServerUnreachable => 'Server je nedostupný';

  @override
  String get sync_statusError => 'Chyba synchronizace';

  @override
  String get sync_statusAuthFailure => 'Je nutné přihlášení';

  @override
  String get sync_neverSynced => 'Synchronizace zatím neproběhla';

  @override
  String sync_lastSynced(String relativeTime) {
    return 'Naposledy synchronizováno $relativeTime';
  }

  @override
  String sync_pendingCount(int count) {
    return 'Čekající položky: $count';
  }

  @override
  String get sync_retry => 'Zkusit znovu';
}
