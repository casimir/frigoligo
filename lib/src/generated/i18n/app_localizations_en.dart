// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get g_article => 'Article';

  @override
  String get g_check => 'Check';

  @override
  String get g_checking => 'Checking…';

  @override
  String get g_delete => 'Delete';

  @override
  String get g_saveLink => 'Save link';

  @override
  String get g_search => 'Search';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Settings';

  @override
  String get g_share => 'Share';

  @override
  String get g_sourceCode => 'Source code';

  @override
  String get g_synchronize => 'Synchronize';

  @override
  String get g_system => 'System';

  @override
  String get g_tag => 'Tag';

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
      other: '$nString days',
      one: '1 day',
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
      other: '$nString hours',
      one: '1 hour',
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
      other: '$nString minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration ago';
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
      other: '$nString seconds',
      one: '1 second',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Add tags';

  @override
  String get article_archive => 'Archive this article';

  @override
  String get article_browseOriginal => 'Browse the original';

  @override
  String get article_delete => 'Delete this article';

  @override
  String get article_details => 'More information';

  @override
  String get article_noContentFetched => 'No content fetched';

  @override
  String get article_notFound => 'Article not found';

  @override
  String get article_openInBrowser => 'Open in browser';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
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
  String get articlefields_readingTime => 'Reading time';

  @override
  String get articlefields_tags => 'Tags';

  @override
  String get articlefields_title => 'Title';

  @override
  String get articlefields_website => 'Website';

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
      other: '$countString domains',
      one: '1 domain',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Starred';

  @override
  String get filters_articleState => 'State';

  @override
  String get filters_articleStateUnread => 'Unread';

  @override
  String get filters_articleStateArchived => 'Archived';

  @override
  String get filters_articleStateAll => 'All states';

  @override
  String get filters_articleTags => 'Tags';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString tags',
      one: '1 tag',
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
  String get logconsole_title => 'Log Console';

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
  String get listing_noArticles => 'No articles';

  @override
  String get listing_articlesAll => 'All articles';

  @override
  String get listing_articlesArchived => 'Archived articles';

  @override
  String get listing_articlesUnread => 'Unread articles';

  @override
  String get login_acceptSelfSigned => 'Accept self-signed certificates';

  @override
  String get login_actionLogin => 'Log in';

  @override
  String get login_existingSessionDialogConfirm => 'Log out';

  @override
  String get login_existingSessionDialogMessage =>
      'Do you want to log out of the current session and open a new one?';

  @override
  String get login_existingSessionDialogTitle =>
      'A session is currently active';

  @override
  String get login_fieldClientId => 'Client ID';

  @override
  String get login_fieldClientSecret => 'Client Secret';

  @override
  String get login_fieldPassword => 'Password';

  @override
  String get login_fieldUsername => 'Username';

  @override
  String get login_openLogConsole => 'Open the Log Console';

  @override
  String get readingsettings_fontFamily => 'Font family';

  @override
  String get readingsettings_fontSize => 'Font size';

  @override
  String get readdingsettings_textFormatting => 'Text formatting';

  @override
  String get readingsettings_title => 'Text settings';

  @override
  String get save_confirmationTitle => 'Article saved!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'This URL does not look like one. Save it anyway?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Save it';

  @override
  String get save_dubiousUrlTitle => 'Dubious URL';

  @override
  String get save_noUrl => 'No URL provided';

  @override
  String get save_title => 'Save article';

  @override
  String get save_viewArticle => 'View article';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Select $numberOfItems';
  }

  @override
  String get server_address => 'Server address';

  @override
  String server_emptyField(String label) {
    return 'Enter your $label';
  }

  @override
  String get server_invalidUrl => 'Invalid address';

  @override
  String get server_unknownServerType => 'Unknown server type';

  @override
  String get server_unreachable => 'Server unreachable';

  @override
  String get server_versionNotSupported => 'Server version not supported';

  @override
  String get session_copiedToClipboard => 'Copied to clipboard';

  @override
  String get session_invalidToken => 'invalid';

  @override
  String get session_logoutDialogConfirm => 'Log out';

  @override
  String get session_logoutDialogMessage => 'You will need to log in again.';

  @override
  String get session_logoutDialogTitle => 'Log out session';

  @override
  String get session_logoutSession => 'Log out session';

  @override
  String get session_fieldAccessToken => 'Access token';

  @override
  String get session_fieldApiToken => 'API token';

  @override
  String get session_fieldLastServerSync => 'Last server sync';

  @override
  String get session_fieldTokenExpiration => 'Token expiration';

  @override
  String get session_forceTokenResfresh => 'Force token refresh';

  @override
  String get session_neverSynced => 'never';

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
  String get settings_itemAbout => 'About';

  @override
  String get settings_itemAppBadge => 'Show unread badge';

  @override
  String get settings_itemClearCache => 'Clear cache';

  @override
  String get settings_itemLogConsole => 'Log Console';

  @override
  String get settings_itemOpenDeeplink => 'Open a deep link';

  @override
  String get settings_itemLanguage => 'Language';

  @override
  String get settings_helpToTranslate => 'Help to translate';

  @override
  String get settings_savedArticleTag => 'Add a tag to saved articles';

  @override
  String get settings_savedArticleTagLabel => 'Label for saved articles';

  @override
  String get settings_itemSessionDetails => 'Session details';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_nativeArticleRenderer => 'Native article renderer';

  @override
  String get settings_valueThemeDark => 'Dark';

  @override
  String get settings_valueThemeLight => 'Light';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString actions',
      one: '1 action',
    );
    return '$_temp0';
  }
}
