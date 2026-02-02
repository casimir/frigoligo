// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_eo.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('ca'),
    Locale('de'),
    Locale('eo'),
    Locale('es'),
    Locale('et'),
    Locale('fr'),
    Locale('gl'),
    Locale('it'),
    Locale('nl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ru'),
    Locale('ta'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// A piece of content fetched from the web. This is one of the main concepts of the app.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get g_article;

  /// A verb as in to check something.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get g_check;

  /// Present participle of the verb to check.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get g_checking;

  /// A verb, as in to delete something.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get g_delete;

  /// A verb, as in to save a link.
  ///
  /// In en, this message translates to:
  /// **'Save link'**
  String get g_saveLink;

  /// A verb, as in to search something.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get g_search;

  /// A server, as in a computer providing a service.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get g_server;

  /// The settings of the application.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get g_settings;

  /// A verb, as in to share something.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get g_share;

  /// The source code of a software.
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get g_sourceCode;

  /// A verb, as in to synchronize with the server.
  ///
  /// In en, this message translates to:
  /// **'Synchronize'**
  String get g_synchronize;

  /// A name, as in the default configuration (System configuration).
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get g_system;

  /// A tag can be attached to an article.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get g_tag;

  /// A version, as in the application version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get g_version;

  /// No description provided for @humanize_days.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 day} other{{n} days}}'**
  String humanize_days(int n);

  /// Describe a duration until a moment in the future.
  ///
  /// In en, this message translates to:
  /// **'in {duration}'**
  String humanize_future(String duration);

  /// No description provided for @humanize_hours.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 hour} other{{n} hours}}'**
  String humanize_hours(int n);

  /// No description provided for @humanize_minutes.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 minute} other{{n} minutes}}'**
  String humanize_minutes(int n);

  /// Describe a duration since a moment in the past.
  ///
  /// In en, this message translates to:
  /// **'{duration} ago'**
  String humanize_past(String duration);

  /// No description provided for @humanize_seconds.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 second} other{{n} seconds}}'**
  String humanize_seconds(int n);

  /// The action to add tags to an article.
  ///
  /// In en, this message translates to:
  /// **'Add tags'**
  String get article_addTags;

  /// The action to archive the article.
  ///
  /// In en, this message translates to:
  /// **'Archive this article'**
  String get article_archive;

  /// The action to open the URL of the article in the web browser.
  ///
  /// In en, this message translates to:
  /// **'Browse the original'**
  String get article_browseOriginal;

  /// The action to delete the article.
  ///
  /// In en, this message translates to:
  /// **'Delete this article'**
  String get article_delete;

  /// The action to show the article details.
  ///
  /// In en, this message translates to:
  /// **'More information'**
  String get article_details;

  /// Placeholder for when the article content is not available.
  ///
  /// In en, this message translates to:
  /// **'No content fetched'**
  String get article_noContentFetched;

  /// Placeholder for when the article is not found.
  ///
  /// In en, this message translates to:
  /// **'Article not found'**
  String get article_notFound;

  /// The action to open the article in the web browser.
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get article_openInBrowser;

  /// The estimated reading time of the article.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String article_readingTime(int minutes);

  /// The action to ask the server to fetch the article content again.
  ///
  /// In en, this message translates to:
  /// **'Re-fetch content'**
  String get article_refetchContent;

  /// The action to open the reading settings sheet.
  ///
  /// In en, this message translates to:
  /// **'Text settings'**
  String get article_readingSettings;

  /// The action to share the article.
  ///
  /// In en, this message translates to:
  /// **'Share this article'**
  String get article_share;

  /// The action to star the article.
  ///
  /// In en, this message translates to:
  /// **'Star this article'**
  String get article_star;

  /// The action to unarchive the article.
  ///
  /// In en, this message translates to:
  /// **'Unarchive this article'**
  String get article_unarchive;

  /// The action to unstar the article.
  ///
  /// In en, this message translates to:
  /// **'Unstar this article'**
  String get article_unstar;

  /// The estimated reading time of the article.
  ///
  /// In en, this message translates to:
  /// **'Reading time'**
  String get articlefields_readingTime;

  /// The tags of the article.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get articlefields_tags;

  /// The title of the article.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get articlefields_title;

  /// The website (domain) from where the article has been fetched.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get articlefields_website;

  /// Filter the domains from where the articles have been fetched.
  ///
  /// In en, this message translates to:
  /// **'Domains'**
  String get filters_articleDomains;

  /// The number of articles domains used in filters.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 domain} other{{count} domains}}'**
  String filters_articleDomainsCount(int count);

  /// Filter starred articles.
  ///
  /// In en, this message translates to:
  /// **'Starred'**
  String get filters_articleFavoriteStarred;

  /// The state of the article.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get filters_articleState;

  /// Filter articles with the state 'unread'.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get filters_articleStateUnread;

  /// Filter articles with the state 'archived'.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get filters_articleStateArchived;

  /// Don't filter articles by state.
  ///
  /// In en, this message translates to:
  /// **'All states'**
  String get filters_articleStateAll;

  /// Filter articles with the given tag values.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get filters_articleTags;

  /// The number of tags used in filters.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tag} other{{count} tags}}'**
  String filters_articleTagsCount(int count);

  /// Search bar hint in the home screen.
  ///
  /// In en, this message translates to:
  /// **'Search in articles'**
  String get filters_searchbarHint;

  /// The title of the search mode screen (which fields to search text into).
  ///
  /// In en, this message translates to:
  /// **'Search mode'**
  String get filters_searchMode;

  /// Search text in all fields.
  ///
  /// In en, this message translates to:
  /// **'All fields'**
  String get filters_searchModeAll;

  /// Search text only in the content field.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get filters_searchModeContent;

  /// Search text only in the title field.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get filters_searchModeTitle;

  /// The title of the log console screen.
  ///
  /// In en, this message translates to:
  /// **'Log Console'**
  String get logconsole_title;

  /// The action to clear the logs.
  ///
  /// In en, this message translates to:
  /// **'Clear logs'**
  String get logconsole_clear_logs;

  /// The title of the export as file dialog.
  ///
  /// In en, this message translates to:
  /// **'Export as file'**
  String get logconsole_export_title;

  /// Label for exporting only the current session logs.
  ///
  /// In en, this message translates to:
  /// **'Current session ({count, plural, =1{1 line} other{{count} lines}})'**
  String logconsole_export_current_session(int count);

  /// Label for exporting all available logs.
  ///
  /// In en, this message translates to:
  /// **'All logs ({count, plural, =1{1 line} other{{count} lines}})'**
  String logconsole_export_all_logs(int count);

  /// Placeholder for when there are no articles to display.
  ///
  /// In en, this message translates to:
  /// **'No articles'**
  String get listing_noArticles;

  /// The title for the list of all the articles.
  ///
  /// In en, this message translates to:
  /// **'All articles'**
  String get listing_articlesAll;

  /// The title for the list of the articles with the state Archived.
  ///
  /// In en, this message translates to:
  /// **'Archived articles'**
  String get listing_articlesArchived;

  /// The title for the list of the articles with the state Unread.
  ///
  /// In en, this message translates to:
  /// **'Unread articles'**
  String get listing_articlesUnread;

  /// Wether or not to accept self-signed certificates when connecting to the wallabag instance.
  ///
  /// In en, this message translates to:
  /// **'Accept self-signed certificates'**
  String get login_acceptSelfSigned;

  /// The action to log in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_actionLogin;

  /// The action to log out from the existing session.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get login_existingSessionDialogConfirm;

  /// The message of the dialog warning about an existing session.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out of the current session and open a new one?'**
  String get login_existingSessionDialogMessage;

  /// The title of the dialog warning about an existing session.
  ///
  /// In en, this message translates to:
  /// **'A session is currently active'**
  String get login_existingSessionDialogTitle;

  /// The client ID field of the login form.
  ///
  /// In en, this message translates to:
  /// **'Client ID'**
  String get login_fieldClientId;

  /// The client secret field of the login form.
  ///
  /// In en, this message translates to:
  /// **'Client Secret'**
  String get login_fieldClientSecret;

  /// The password field of the login form.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_fieldPassword;

  /// The username field of the login form.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get login_fieldUsername;

  /// The action to open the log console.
  ///
  /// In en, this message translates to:
  /// **'Open the Log Console'**
  String get login_openLogConsole;

  /// The font family to display the content of the article.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get readingsettings_fontFamily;

  /// The font size to display the content of the article.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get readingsettings_fontSize;

  /// The text formatting to display the content of the article.
  ///
  /// In en, this message translates to:
  /// **'Text formatting'**
  String get readdingsettings_textFormatting;

  /// The title of the reading settings screen.
  ///
  /// In en, this message translates to:
  /// **'Text settings'**
  String get readingsettings_title;

  /// The title of the confirmation screen after the article is saved.
  ///
  /// In en, this message translates to:
  /// **'Article saved!'**
  String get save_confirmationTitle;

  /// The message of the dubious URL warning dialog.
  ///
  /// In en, this message translates to:
  /// **'This URL does not look like one. Save it anyway?\n{url}'**
  String save_dubiousUrlMessage(String url);

  /// The confirmation button of the dubious URL warning dialog.
  ///
  /// In en, this message translates to:
  /// **'Save it'**
  String get save_dubiousUrlConfirm;

  /// The title of the dubious URL warning dialog.
  ///
  /// In en, this message translates to:
  /// **'Dubious URL'**
  String get save_dubiousUrlTitle;

  /// The URL was missing from the save request.
  ///
  /// In en, this message translates to:
  /// **'No URL provided'**
  String get save_noUrl;

  /// The title of the save screen.
  ///
  /// In en, this message translates to:
  /// **'Save article'**
  String get save_title;

  /// The action to view the article after it is saved.
  ///
  /// In en, this message translates to:
  /// **'View article'**
  String get save_viewArticle;

  /// Error message shown when trying to save an article in local mode.
  ///
  /// In en, this message translates to:
  /// **'A server connection is required to save new articles.'**
  String get save_localModeError;

  /// Error message shown when the URL to save is malformed.
  ///
  /// In en, this message translates to:
  /// **'Malformed URL: {url}'**
  String save_malformedUrlError(String url);

  /// The label of the select button in a selector screen.
  ///
  /// In en, this message translates to:
  /// **'Select {numberOfItems}'**
  String selector_selectbuttonlabel(String numberOfItems);

  /// The address of the wallabag instance.
  ///
  /// In en, this message translates to:
  /// **'Server address'**
  String get server_address;

  /// A message for non-empty check fail on a form field.
  ///
  /// In en, this message translates to:
  /// **'Enter your {label}'**
  String server_emptyField(String label);

  /// The address of the wallabag instance is invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid address'**
  String get server_invalidUrl;

  /// The application could not detect the server type.
  ///
  /// In en, this message translates to:
  /// **'Unknown server type'**
  String get server_unknownServerType;

  /// The server instance is unreachable.
  ///
  /// In en, this message translates to:
  /// **'Server unreachable'**
  String get server_unreachable;

  /// The server instance is not supported.
  ///
  /// In en, this message translates to:
  /// **'Server version not supported'**
  String get server_versionNotSupported;

  /// A message displayed when the value is copied to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get session_copiedToClipboard;

  /// Placeholder for expiration date when the token is invalid.
  ///
  /// In en, this message translates to:
  /// **'invalid'**
  String get session_invalidToken;

  /// Confirm the log out from the confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get session_logoutDialogConfirm;

  /// The message of the confirmation dialog to log out.
  ///
  /// In en, this message translates to:
  /// **'You will need to log in again.'**
  String get session_logoutDialogMessage;

  /// The title of the confirmation dialog to log out.
  ///
  /// In en, this message translates to:
  /// **'Log out session'**
  String get session_logoutDialogTitle;

  /// The action to log out the session.
  ///
  /// In en, this message translates to:
  /// **'Log out session'**
  String get session_logoutSession;

  /// The label of the access token field in the session screen.
  ///
  /// In en, this message translates to:
  /// **'Access token'**
  String get session_fieldAccessToken;

  /// The API token field name of in forms.
  ///
  /// In en, this message translates to:
  /// **'API token'**
  String get session_fieldApiToken;

  /// The label of the last server sync field in the session screen.
  ///
  /// In en, this message translates to:
  /// **'Last server sync'**
  String get session_fieldLastServerSync;

  /// The label of the token expiration field in the session screen.
  ///
  /// In en, this message translates to:
  /// **'Token expiration'**
  String get session_fieldTokenExpiration;

  /// The action to force a token refresh.
  ///
  /// In en, this message translates to:
  /// **'Force token refresh'**
  String get session_forceTokenResfresh;

  /// Default value for the last sync time.
  ///
  /// In en, this message translates to:
  /// **'never'**
  String get session_neverSynced;

  /// The message of the confirmation dialog to renew the session.
  ///
  /// In en, this message translates to:
  /// **'The server refuses the current session token. You will need to log in again to resume the synchronization.'**
  String get session_renewDialogMessage;

  /// The title of the confirmation dialog to renew the session.
  ///
  /// In en, this message translates to:
  /// **'Renew session'**
  String get session_renewDialogTitle;

  /// The title of the session details screen.
  ///
  /// In en, this message translates to:
  /// **'Session details'**
  String get session_title;

  /// The action to open the bug report form.
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get settings_bugReportLink;

  /// The message of the confirmation dialog to clear the cache.
  ///
  /// In en, this message translates to:
  /// **'The local cache will be deleted and fetched again from the server.'**
  String get settings_clearCacheMessage;

  /// Settings for the appearance of the application.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_itemAppearance;

  /// The action to display the about screen.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_itemAbout;

  /// The action to toggle the unread badge on the application icon.
  ///
  /// In en, this message translates to:
  /// **'Show unread badge'**
  String get settings_itemAppBadge;

  /// The action to clear the offline cache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settings_itemClearCache;

  /// The action to display the log console screen.
  ///
  /// In en, this message translates to:
  /// **'Log Console'**
  String get settings_itemLogConsole;

  /// The action to open a deep link.
  ///
  /// In en, this message translates to:
  /// **'Open a deep link'**
  String get settings_itemOpenDeeplink;

  /// The action to change the language of the application.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_itemLanguage;

  /// The action to open the Weblate project in a webview.
  ///
  /// In en, this message translates to:
  /// **'Help to translate'**
  String get settings_helpToTranslate;

  /// The action to toggle the addition of a tag to saved articles.
  ///
  /// In en, this message translates to:
  /// **'Add a tag to saved articles'**
  String get settings_savedArticleTag;

  /// The label of the tag to add to saved articles.
  ///
  /// In en, this message translates to:
  /// **'Label for saved articles'**
  String get settings_savedArticleTagLabel;

  /// The action to display the session details screen.
  ///
  /// In en, this message translates to:
  /// **'Session details'**
  String get settings_itemSessionDetails;

  /// The title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// The action to toggle the use of the experimental article renderer.
  ///
  /// In en, this message translates to:
  /// **'Native article renderer'**
  String get settings_nativeArticleRenderer;

  /// The label for the dark theme mode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_valueThemeDark;

  /// The label for the light theme mode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_valueThemeLight;

  /// Number of pending actions in the RemoteSyncer queue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 action} other{{count} actions}}'**
  String syncer_pendingActions(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'ca',
    'de',
    'en',
    'eo',
    'es',
    'et',
    'fr',
    'gl',
    'it',
    'nl',
    'pt',
    'ru',
    'ta',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'ca':
      return AppLocalizationsCa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'eo':
      return AppLocalizationsEo();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fr':
      return AppLocalizationsFr();
    case 'gl':
      return AppLocalizationsGl();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'ta':
      return AppLocalizationsTa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
