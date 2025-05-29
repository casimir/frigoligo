// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class AppLocalizationsEo extends AppLocalizations {
  AppLocalizationsEo([String locale = 'eo']) : super(locale);

  @override
  String get g_article => 'Artikolo';

  @override
  String get g_check => 'Kontroli';

  @override
  String get g_checking => 'Kontrolante …';

  @override
  String get g_delete => 'Forigi';

  @override
  String get g_saveLink => 'Konservi ligon';

  @override
  String get g_search => 'Serĉi';

  @override
  String get g_server => 'Servilo';

  @override
  String get g_settings => 'Agordoj';

  @override
  String get g_share => 'Kunhavigi';

  @override
  String get g_sourceCode => 'Fontkodo';

  @override
  String get g_synchronize => 'Sinkronigi';

  @override
  String get g_system => 'Sistemo';

  @override
  String get g_tag => 'Etikedo';

  @override
  String get g_version => 'Versio';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString tagoj',
      one: '1 tago',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'post $duration';
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
      other: '$nString horoj',
      one: '1 horo',
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
      other: '$nString minutoj',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'antaŭ $duration';
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
      other: '$nString sekundoj',
      one: '1 sekundo',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Aldoni etikedojn';

  @override
  String get article_archive => 'Archive this article';

  @override
  String get article_browseOriginal => 'Esplori la originalon';

  @override
  String get article_delete => 'Forigi ĉi tiun artikolon';

  @override
  String get article_details => 'More information';

  @override
  String get article_noContentFetched => 'Neniu enhavo ŝargita';

  @override
  String get article_notFound => 'Article not found';

  @override
  String get article_openInBrowser => 'Malfermi en retumilo';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString minutoj';
  }

  @override
  String get article_refetchContent => 'Re-fetch content';

  @override
  String get article_readingSettings => 'Text settings';

  @override
  String get article_share => 'Share this article';

  @override
  String get article_star => 'Star this article';

  @override
  String get article_unarchive => 'Unarchive this article';

  @override
  String get article_unstar => 'Unstar this article';

  @override
  String get articlefields_readingTime => 'Legdaŭro';

  @override
  String get articlefields_tags => 'Etikedoj';

  @override
  String get articlefields_title => 'Titolo';

  @override
  String get articlefields_website => 'Retejo';

  @override
  String get filters_articleDomains => 'Domajnoj';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domajnoj',
      one: '1 domajno',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Markitaj';

  @override
  String get filters_articleState => 'Stato';

  @override
  String get filters_articleStateUnread => 'Nelegitaj';

  @override
  String get filters_articleStateArchived => 'Arkivigitaj';

  @override
  String get filters_articleStateAll => 'Ĉiuj statoj';

  @override
  String get filters_articleTags => 'Etikedoj';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString etikedoj',
      one: '1 etikedo',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Search in articles';

  @override
  String get filters_searchMode => 'Search mode';

  @override
  String get filters_searchModeAll => 'All fields';

  @override
  String get filters_searchModeContent => 'Content';

  @override
  String get filters_searchModeTitle => 'Title';

  @override
  String get logconsole_title => 'Protokolkonzolo';

  @override
  String get listing_noArticles => 'Neniu artikolo';

  @override
  String get listing_articlesAll => 'Ĉiuj artikoloj';

  @override
  String get listing_articlesArchived => 'Arkivigitaj artikoloj';

  @override
  String get listing_articlesUnread => 'Nelegitaj artikoloj';

  @override
  String get login_acceptSelfSigned => 'Akcepti memsubskribitajn atestilojn';

  @override
  String get login_actionLogin => 'Ensaluti';

  @override
  String get login_existingSessionDialogConfirm => 'Elsaluti';

  @override
  String get login_existingSessionDialogMessage =>
      'Ĉu vi volas elsaluti el la nuna sesio kaj malfermi novan?';

  @override
  String get login_existingSessionDialogTitle => 'Jam existas aktiva sesio';

  @override
  String get login_fieldClientId => 'Klientidentigo';

  @override
  String get login_fieldClientSecret => 'Klientsekreto';

  @override
  String get login_fieldPassword => 'Pasvorto';

  @override
  String get login_fieldUsername => 'Uzantnomo';

  @override
  String get login_openLogConsole => 'Malfermi la protokolkonzolon';

  @override
  String get readingsettings_fontFamily => 'Tipara familio';

  @override
  String get readingsettings_fontSize => 'Tipara grando';

  @override
  String get readdingsettings_textFormatting => 'Text formatting';

  @override
  String get readingsettings_title => 'Legaj agordoj';

  @override
  String get save_confirmationTitle => 'Artikolo konservita!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Tiu URL ne aspektas valida. Konservi ĝin ĉiukaze?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Konservi';

  @override
  String get save_dubiousUrlTitle => 'Malklara URL';

  @override
  String get save_noUrl => 'Neniu URL donita';

  @override
  String get save_title => 'Konservi artikolon';

  @override
  String get save_viewArticle => 'Rigardi artikolon';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Select $numberOfItems';
  }

  @override
  String get server_address => 'Adreso de la servilo';

  @override
  String get server_apiError => 'Nevalida API respondo';

  @override
  String server_emptyField(String label) {
    return 'Enigi vian $label';
  }

  @override
  String get server_invalidUrl => 'Nevalida adreso';

  @override
  String get server_unreachable => 'Servilo neatingebla';

  @override
  String get session_copiedToClipboard => 'Kopiita al la tondobufro';

  @override
  String get session_invalidToken => 'nevalida';

  @override
  String get session_logoutDialogConfirm => 'Elsaluti';

  @override
  String get session_logoutDialogMessage => 'Vi devos denove ensaluti.';

  @override
  String get session_logoutDialogTitle => 'Elsaluti el la sesio';

  @override
  String get session_logoutSession => 'Elsaluti el la sesio';

  @override
  String get session_fieldAccessToken => 'Atingoĵetono';

  @override
  String get session_fieldApiToken => 'API ĵetono';

  @override
  String get session_fieldLastServerSync => 'Lasta sinkronigo kun la servilo';

  @override
  String get session_fieldTokenExpiration => 'Eksvalidiĝo de la ĵetono';

  @override
  String get session_forceTokenResfresh => 'Devigi aktualigon de la ĵetono';

  @override
  String get session_neverSynced => 'neniam';

  @override
  String get session_renewDialogMessage =>
      'La servilo rifuzas la nunan sesioĵetonon. Vi devos ensaluti denove por rekomenci la sinkronigon.';

  @override
  String get session_renewDialogTitle => 'Renovigi la sesion';

  @override
  String get session_title => 'Sesiodetaloj';

  @override
  String get settings_bugReportLink => 'Raporti cimon';

  @override
  String get settings_clearCacheMessage =>
      'La loka kaŝmemoro estos forigita kaj denove elŝutita de la servilo.';

  @override
  String get settings_itemAppearance => 'Aspekto';

  @override
  String get settings_itemAbout => 'Pri-paĝo';

  @override
  String get settings_itemAppBadge => 'Montri nelegitaŝildon';

  @override
  String get settings_itemClearCache => 'Vakigi la kaŝmemoron';

  @override
  String get settings_itemLogConsole => 'Protokolkonzolo';

  @override
  String get settings_itemOpenDeeplink => 'Malfermi profundan ligon';

  @override
  String get settings_itemLanguage => 'Lingvo';

  @override
  String get settings_helpToTranslate => 'Helpi traduki';

  @override
  String get settings_savedArticleTag =>
      'Aldoni etikedon al konservitaj artikoloj';

  @override
  String get settings_savedArticleTagLabel =>
      'Etikedo por konservitaj atikoloj';

  @override
  String get settings_itemSessionDetails => 'Sesiodetaloj';

  @override
  String get settings_title => 'Agordoj';

  @override
  String get settings_nativeArticleRenderer => 'Native article renderer';

  @override
  String get settings_valueThemeDark => 'Malhela';

  @override
  String get settings_valueThemeLight => 'Hela';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString agoj',
      one: '1 ago',
    );
    return '$_temp0';
  }
}
