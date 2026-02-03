// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get g_article => 'கட்டுரை';

  @override
  String get g_check => 'சரிபார்';

  @override
  String get g_checking => 'சோதனை…';

  @override
  String get g_delete => 'நீக்கு';

  @override
  String get g_saveLink => 'இணைப்பைச் சேமிக்கவும்';

  @override
  String get g_search => 'தேடல்';

  @override
  String get g_server => 'சேவையகம்';

  @override
  String get g_settings => 'அமைப்புகள்';

  @override
  String get g_share => 'பங்கு';

  @override
  String get g_sourceCode => 'மூலக் குறியீடு';

  @override
  String get g_synchronize => 'ஒத்திசைக்கவும்';

  @override
  String get g_system => 'மண்டலம்';

  @override
  String get g_tag => 'குறிச்சொல்';

  @override
  String get g_version => 'பதிப்பு';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString நாட்கள்',
      one: '1 நாள்',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return '$duration இல்';
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
      other: '$nString மணிநேரம்',
      one: '1 மணி நேரம்',
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
      other: '$nString நிமிடங்கள்',
      one: '1 நிமிடம்',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration முன்பு';
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
      other: '$nString வினாடிகள்',
      one: '1 வினாடி',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'குறிச்சொற்களைச் சேர்க்கவும்';

  @override
  String get article_archive => 'இந்த கட்டுரையை காப்பகப்படுத்தவும்';

  @override
  String get article_browseOriginal => 'அசலை உலாவுக';

  @override
  String get article_delete => 'இந்த கட்டுரையை நீக்கு';

  @override
  String get article_details => 'மேலும் செய்தி';

  @override
  String get article_noContentFetched => 'எந்த உள்ளடக்கமும் பெறப்படவில்லை';

  @override
  String get article_notFound => 'கட்டுரை காணப்படவில்லை';

  @override
  String get article_openInBrowser => 'உலாவியில் திற';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString மணித்துளி';
  }

  @override
  String get article_refetchContent => 'உள்ளடக்கத்தை மீண்டும் பெறவும்';

  @override
  String get article_readingSettings => 'உரை அமைப்புகள்';

  @override
  String get article_share => 'இந்த கட்டுரையைப் பகிரவும்';

  @override
  String get article_star => 'இந்த கட்டுரையை விண்மீன் செய்யுங்கள்';

  @override
  String get article_unarchive => 'இந்த கட்டுரையை அறியாதது';

  @override
  String get article_unstar => 'இந்த கட்டுரையை உறுதிப்படுத்தவும்';

  @override
  String get articlefields_readingTime => 'வாசிப்பு நேரம்';

  @override
  String get articlefields_tags => 'குறிச்சொற்கள்';

  @override
  String get articlefields_title => 'தலைப்பு';

  @override
  String get articlefields_website => 'வலைத்தளம்';

  @override
  String get filters_articleDomains => 'களங்கள்';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString களங்கள்',
      one: '1 டொமைன்',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'நடித்தார்';

  @override
  String get filters_articleState => 'மாநிலம்';

  @override
  String get filters_articleStateUnread => 'படிக்காதது';

  @override
  String get filters_articleStateArchived => 'காப்பகப்படுத்தப்பட்டது';

  @override
  String get filters_articleStateAll => 'அனைத்து மாநிலங்களும்';

  @override
  String get filters_articleTags => 'குறிச்சொற்கள்';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString குறிச்சொற்கள்',
      one: '1 குறிச்சொல்',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'கட்டுரைகளில் தேடுங்கள்';

  @override
  String get filters_searchMode => 'தேடல் பயன்முறை';

  @override
  String get filters_searchModeAll => 'அனைத்து புலங்களும்';

  @override
  String get filters_searchModeContent => 'உள்ளடக்கம்';

  @override
  String get filters_searchModeTitle => 'தலைப்பு';

  @override
  String get logconsole_title => 'பதிவு கன்சோல்';

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
  String get listing_noArticles => 'கட்டுரைகள் இல்லை';

  @override
  String get listing_articlesAll => 'அனைத்து கட்டுரைகளும்';

  @override
  String get listing_articlesArchived => 'காப்பகப்படுத்தப்பட்ட கட்டுரைகள்';

  @override
  String get listing_articlesUnread => 'படிக்காத கட்டுரைகள்';

  @override
  String get login_acceptSelfSigned =>
      'தன்வய கையொப்பமிடப்பட்ட சான்றிதழ்களை ஏற்றுக்கொள்ளுங்கள்';

  @override
  String get login_actionLogin => 'புகுபதிகை';

  @override
  String get login_existingSessionDialogConfirm => 'விடுபதிகை';

  @override
  String get login_existingSessionDialogMessage =>
      'தற்போதைய அமர்வில் இருந்து வெளியேறி புதிய ஒன்றைத் திறக்க விரும்புகிறீர்களா?';

  @override
  String get login_existingSessionDialogTitle =>
      'ஒரு அமர்வு தற்போது செயலில் உள்ளது';

  @override
  String get login_fieldClientId => 'வாங்கி ஐடி';

  @override
  String get login_fieldClientSecret => 'வாங்கி மறைபொருள்';

  @override
  String get login_fieldPassword => 'கடவுச்சொல்';

  @override
  String get login_fieldUsername => 'பயனர்பெயர்';

  @override
  String get login_openLogConsole => 'பதிவு கன்சோலைத் திறக்கவும்';

  @override
  String get readingsettings_fontFamily => 'எழுத்துரு குடும்பம்';

  @override
  String get readingsettings_fontSize => 'எழுத்துரு அளவு';

  @override
  String get readdingsettings_textFormatting => 'உரை வடிவமைப்பு';

  @override
  String get readingsettings_title => 'உரை அமைப்புகள்';

  @override
  String get save_confirmationTitle => 'கட்டுரை சேமிக்கப்பட்டது!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'இந்த முகவரி ஒன்றைப் போல் இல்லை. எப்படியும் அதை சேமிக்கவா?\n $url';
  }

  @override
  String get save_dubiousUrlConfirm => 'அதை சேமிக்கவும்';

  @override
  String get save_dubiousUrlTitle => 'சந்தேகத்திற்குரிய முகவரி';

  @override
  String get save_noUrl => 'முகவரி எதுவும் வழங்கப்படவில்லை';

  @override
  String get save_title => 'கட்டுரையை சேமிக்கவும்';

  @override
  String get save_viewArticle => 'கட்டுரையைக் காண்க';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return '$numberOfItems என்பதைத் தேர்ந்தெடுக்கவும்';
  }

  @override
  String get server_address => 'சேவையக முகவரி';

  @override
  String server_emptyField(String label) {
    return 'உங்கள் $label ஐ உள்ளிடவும்';
  }

  @override
  String get server_invalidUrl => 'தவறான முகவரி';

  @override
  String get server_unknownServerType => 'தெரியாத சேவையக வகை';

  @override
  String get server_unreachable => 'சேவையகம் அணுக முடியாதது';

  @override
  String get server_versionNotSupported => 'சேவையக பதிப்பு ஆதரிக்கப்படவில்லை';

  @override
  String get session_copiedToClipboard => 'இடைநிலைப்பலகைக்கு நகலெடுக்கப்பட்டது';

  @override
  String get session_invalidToken => 'செல்லுபடியாகாத';

  @override
  String get session_logoutDialogConfirm => 'விடுபதிகை';

  @override
  String get session_logoutDialogMessage =>
      'நீங்கள் மீண்டும் உள்நுழைய வேண்டும்.';

  @override
  String get session_logoutDialogTitle => 'அமர்வு வெளியேறவும்';

  @override
  String get session_logoutSession => 'அமர்வு வெளியேறவும்';

  @override
  String get session_fieldAccessToken => 'அணுகல் கிள்ளாக்கு';

  @override
  String get session_fieldApiToken => 'பநிஇ கிள்ளாக்கு';

  @override
  String get session_fieldLastServerSync => 'கடைசி சேவையக ஒத்திசைவு';

  @override
  String get session_fieldTokenExpiration => 'கிள்ளாக்கு காலாவதி';

  @override
  String get session_forceTokenResfresh => 'ஃபோர்ச் கிள்ளாக்கு புதுப்பிப்பு';

  @override
  String get session_neverSynced => 'ஒருபோதும்';

  @override
  String get session_renewDialogMessage =>
      'சேவையகம் தற்போதைய அமர்வு கிள்ளாக்கை மறுக்கிறது. ஒத்திசைவை மீண்டும் தொடங்க நீங்கள் மீண்டும் உள்நுழைய வேண்டும்.';

  @override
  String get session_renewDialogTitle => 'புதுப்பித்தல் அமர்வு';

  @override
  String get session_title => 'அமர்வு விவரங்கள்';

  @override
  String get settings_bugReportLink => 'ஒரு பிழையைப் புகாரளிக்கவும்';

  @override
  String get settings_clearCacheMessage =>
      'உள்ளக கேச் நீக்கப்பட்டு மீண்டும் சேவையகத்திலிருந்து பெறப்படும்.';

  @override
  String get settings_itemAppearance => 'தோற்றம்';

  @override
  String get settings_itemAbout => 'பற்றி';

  @override
  String get settings_itemAppBadge => 'படிக்காத பேட்சைக் காட்டு';

  @override
  String get settings_itemClearCache => 'தெளிவான தற்காலிக சேமிப்பு';

  @override
  String get settings_itemLogConsole => 'பதிவு கன்சோல்';

  @override
  String get settings_itemOpenDeeplink => 'ஆழமான இணைப்பைத் திறக்கவும்';

  @override
  String get settings_itemLanguage => 'மொழி';

  @override
  String get settings_helpToTranslate => 'மொழிபெயர்க்க உதவுங்கள்';

  @override
  String get settings_savedArticleTag =>
      'சேமித்த கட்டுரைகளுக்கு ஒரு குறிச்சொல்லைச் சேர்க்கவும்';

  @override
  String get settings_savedArticleTagLabel => 'சேமித்த கட்டுரைகளுக்கான சிட்டை';

  @override
  String get settings_itemSessionDetails => 'அமர்வு விவரங்கள்';

  @override
  String get settings_title => 'அமைப்புகள்';

  @override
  String get settings_nativeArticleRenderer => 'சொந்த கட்டுரை ரெண்டரர்';

  @override
  String get settings_valueThemeDark => 'இருண்ட';

  @override
  String get settings_valueThemeLight => 'ஒளி';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString செயல்கள்',
      one: '1 செயல்',
    );
    return '$_temp0';
  }
}
