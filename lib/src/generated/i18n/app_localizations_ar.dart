// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get g_article => 'مقال';

  @override
  String get g_check => 'تحقق';

  @override
  String get g_checking => 'جارٍ التحقق…';

  @override
  String get g_delete => 'حذف';

  @override
  String get g_saveLink => 'حفظ الرابط';

  @override
  String get g_search => 'بحث';

  @override
  String get g_server => 'خادم';

  @override
  String get g_settings => 'الإعدادات';

  @override
  String get g_share => 'مشاركة';

  @override
  String get g_sourceCode => 'الكود المصدري';

  @override
  String get g_synchronize => 'مزامنة';

  @override
  String get g_system => 'النظام';

  @override
  String get g_tag => 'وسم';

  @override
  String get g_version => 'الإصدار';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString أيام',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'خلال $duration';
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
      other: '$nString ساعات',
      one: 'ساعة واحدة',
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
      other: '$nString دقائق',
      one: 'دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'منذ $duration';
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
      other: '$nString ثوانٍ',
      one: 'ثانية واحدة',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'إضافة وسوم';

  @override
  String get article_archive => 'أرشفة هذا المقال';

  @override
  String get article_browseOriginal => 'تصفح الأصلي';

  @override
  String get article_delete => 'حذف هذا المقال';

  @override
  String get article_details => 'مزيد من المعلومات';

  @override
  String get article_noContentFetched => 'لم يتم جلب المحتوى';

  @override
  String get article_notFound => 'المقال غير موجود';

  @override
  String get article_openInBrowser => 'فتح في المتصفح';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString دقيقة';
  }

  @override
  String get article_refetchContent => 'إعادة جلب المحتوى';

  @override
  String get article_readingSettings => 'إعدادات النص';

  @override
  String get article_share => 'مشاركة هذا المقال';

  @override
  String get article_star => 'إضافة نجمة لهذا المقال';

  @override
  String get article_unarchive => 'إلغاء أرشفة هذا المقال';

  @override
  String get article_unstar => 'إزالة النجمة من هذا المقال';

  @override
  String get articlefields_readingTime => 'وقت القراءة';

  @override
  String get articlefields_tags => 'الوسوم';

  @override
  String get articlefields_title => 'العنوان';

  @override
  String get articlefields_website => 'الموقع الإلكتروني';

  @override
  String get filters_articleDomains => 'النطاقات';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString نطاقات',
      one: 'نطاق واحد',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'مميز بنجمة';

  @override
  String get filters_articleState => 'الحالة';

  @override
  String get filters_articleStateUnread => 'غير مقروء';

  @override
  String get filters_articleStateArchived => 'مؤرشف';

  @override
  String get filters_articleStateAll => 'جميع الحالات';

  @override
  String get filters_articleTags => 'الوسوم';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString وسوم',
      one: 'وسم واحد',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'البحث في المقالات';

  @override
  String get filters_searchMode => 'وضع البحث';

  @override
  String get filters_searchModeAll => 'جميع الحقول';

  @override
  String get filters_searchModeContent => 'المحتوى';

  @override
  String get filters_searchModeTitle => 'العنوان';

  @override
  String get logconsole_title => 'وحدة تسجيل الأخطاء';

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
  String get listing_noArticles => 'لا توجد مقالات';

  @override
  String get listing_articlesAll => 'جميع المقالات';

  @override
  String get listing_articlesArchived => 'المقالات المؤرشفة';

  @override
  String get listing_articlesUnread => 'المقالات غير المقروءة';

  @override
  String get login_acceptSelfSigned => 'قبول الشهادات الموقّعة ذاتيًا';

  @override
  String get login_actionLogin => 'تسجيل الدخول';

  @override
  String get login_existingSessionDialogConfirm => 'تسجيل الخروج';

  @override
  String get login_existingSessionDialogMessage =>
      'هل تريد تسجيل الخروج من الجلسة الحالية وفتح جلسة جديدة؟';

  @override
  String get login_existingSessionDialogTitle => 'هناك جلسة نشطة حاليًا';

  @override
  String get login_fieldClientId => 'معرّف العميل';

  @override
  String get login_fieldClientSecret => 'سر العميل';

  @override
  String get login_fieldPassword => 'كلمة المرور';

  @override
  String get login_fieldUsername => 'اسم المستخدم';

  @override
  String get login_openLogConsole => 'فتح وحدة تسجيل الأخطاء';

  @override
  String get readingsettings_fontFamily => 'عائلة الخط';

  @override
  String get readingsettings_fontSize => 'حجم الخط';

  @override
  String get readdingsettings_textFormatting => 'تنسيق النص';

  @override
  String get readingsettings_title => 'إعدادات النص';

  @override
  String get save_confirmationTitle => 'تم حفظ المقال!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'هذا الرابط لا يبدو صحيحًا. هل تريد حفظه على أي حال؟\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'حفظه';

  @override
  String get save_dubiousUrlTitle => 'رابط مشكوك فيه';

  @override
  String get save_noUrl => 'لم يتم تقديم رابط';

  @override
  String get save_title => 'حفظ المقال';

  @override
  String get save_viewArticle => 'عرض المقال';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'تحديد $numberOfItems';
  }

  @override
  String get server_address => 'عنوان الخادم';

  @override
  String server_emptyField(String label) {
    return 'أدخل $label';
  }

  @override
  String get server_invalidUrl => 'عنوان غير صالح';

  @override
  String get server_unknownServerType => 'نوع الخادم غير معروف';

  @override
  String get server_unreachable => 'الخادم غير متاح';

  @override
  String get server_versionNotSupported => 'نسخة الخادم غير مدعوم';

  @override
  String get session_copiedToClipboard => 'تم النسخ إلى الحافظة';

  @override
  String get session_invalidToken => 'غير صالح';

  @override
  String get session_logoutDialogConfirm => 'تسجيل الخروج';

  @override
  String get session_logoutDialogMessage => 'ستحتاج إلى تسجيل الدخول مرة أخرى.';

  @override
  String get session_logoutDialogTitle => 'تسجيل الخروج من الجلسة';

  @override
  String get session_logoutSession => 'تسجيل الخروج من الجلسة';

  @override
  String get session_fieldAccessToken => 'رمز الوصول';

  @override
  String get session_fieldApiToken => 'رمز API';

  @override
  String get session_fieldLastServerSync => 'آخر مزامنة مع الخادم';

  @override
  String get session_fieldTokenExpiration => 'انتهاء صلاحية الرمز';

  @override
  String get session_forceTokenResfresh => 'فرض تحديث الرمز';

  @override
  String get session_neverSynced => 'لم تتم المزامنة';

  @override
  String get session_renewDialogMessage =>
      'الخادم يرفض رمز الجلسة الحالي. ستحتاج إلى تسجيل الدخول مرة أخرى لاستئناف المزامنة.';

  @override
  String get session_renewDialogTitle => 'تجديد الجلسة';

  @override
  String get session_title => 'تفاصيل الجلسة';

  @override
  String get settings_bugReportLink => 'الإبلاغ عن خطأ';

  @override
  String get settings_clearCacheMessage =>
      'سيتم حذف الذاكرة المؤقتة المحلية وجلبها مرة أخرى من الخادم.';

  @override
  String get settings_itemAppearance => 'المظهر';

  @override
  String get settings_itemAbout => 'حول';

  @override
  String get settings_itemAppBadge => 'إظهار شارة غير المقروء';

  @override
  String get settings_itemClearCache => 'مسح الذاكرة المؤقتة';

  @override
  String get settings_itemLogConsole => 'وحدة تسجيل الأخطاء';

  @override
  String get settings_itemOpenDeeplink => 'فتح رابط عميق';

  @override
  String get settings_itemLanguage => 'اللغة';

  @override
  String get settings_helpToTranslate => 'ساعد في الترجمة';

  @override
  String get settings_savedArticleTag => 'إضافة وسم للمقالات المحفوظة';

  @override
  String get settings_savedArticleTagLabel => 'تسمية المقالات المحفوظة';

  @override
  String get settings_itemSessionDetails => 'تفاصيل الجلسة';

  @override
  String get settings_title => 'الإعدادات';

  @override
  String get settings_nativeArticleRenderer => 'عارض المقالات الأصلي';

  @override
  String get settings_valueThemeDark => 'داكن';

  @override
  String get settings_valueThemeLight => 'فاتح';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString إجراءات',
      one: 'إجراء واحد',
    );
    return '$_temp0';
  }
}
