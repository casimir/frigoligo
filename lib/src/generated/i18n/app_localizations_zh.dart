// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get g_article => '文章';

  @override
  String get g_check => '检查';

  @override
  String get g_checking => '正在检查…';

  @override
  String get g_delete => '删除';

  @override
  String get g_saveLink => '保存链接';

  @override
  String get g_search => '搜索';

  @override
  String get g_server => '服务器';

  @override
  String get g_settings => '设置';

  @override
  String get g_share => '分享';

  @override
  String get g_sourceCode => '源代码';

  @override
  String get g_synchronize => '同步';

  @override
  String get g_system => '系统';

  @override
  String get g_tag => '标签';

  @override
  String get g_version => '版本';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    return '$nString 天';
  }

  @override
  String humanize_future(String duration) {
    return '$duration 后';
  }

  @override
  String humanize_hours(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    return '$nString 小时';
  }

  @override
  String humanize_minutes(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    return '$nString 分钟';
  }

  @override
  String humanize_past(String duration) {
    return '$duration 前';
  }

  @override
  String humanize_seconds(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    return '$nString 秒';
  }

  @override
  String get article_addTags => '添加标签';

  @override
  String get article_archive => '存档此文章';

  @override
  String get article_browseOriginal => '浏览原文';

  @override
  String get article_delete => '删除此文章';

  @override
  String get article_details => '更多信息';

  @override
  String get article_noContentFetched => '未获取内容';

  @override
  String get article_notFound => '未找到文章';

  @override
  String get article_openInBrowser => '在浏览器中打开';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString 分钟';
  }

  @override
  String get article_refetchContent => '重新抓取';

  @override
  String get article_readingSettings => '文本设置';

  @override
  String get article_share => '分享此文章';

  @override
  String get article_star => '收藏此文章';

  @override
  String get article_unarchive => '取消存档此文章';

  @override
  String get article_unstar => '取消收藏此文章';

  @override
  String get articlefields_readingTime => '阅读时间';

  @override
  String get articlefields_tags => '标签';

  @override
  String get articlefields_title => '标题';

  @override
  String get articlefields_website => '网站';

  @override
  String get filters_articleDomains => '域名';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '$countString 个域名';
  }

  @override
  String get filters_articleFavoriteStarred => '已收藏';

  @override
  String get filters_articleState => '状态';

  @override
  String get filters_articleStateUnread => '未读';

  @override
  String get filters_articleStateArchived => '已存档';

  @override
  String get filters_articleStateAll => '全部状态';

  @override
  String get filters_articleTags => '标签';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '$countString 个标签';
  }

  @override
  String get filters_searchbarHint => '在文章中搜索';

  @override
  String get filters_searchMode => '搜索方式';

  @override
  String get filters_searchModeAll => '所有字段';

  @override
  String get filters_searchModeContent => '内容';

  @override
  String get filters_searchModeTitle => '标题';

  @override
  String get logconsole_title => '日志控制台';

  @override
  String get logconsole_clear_logs => 'Clear logs';

  @override
  String get logconsole_export_title => '导出为文件';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString行',
      one: '1行',
    );
    return '当前会话（$_temp0）';
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
      other: '$countString行',
      one: '1行',
    );
    return '所有日志（$_temp0）';
  }

  @override
  String get listing_noArticles => '暂无文章';

  @override
  String get listing_articlesAll => '全部文章';

  @override
  String get listing_articlesArchived => '存档文章';

  @override
  String get listing_articlesUnread => '未读文章';

  @override
  String get login_acceptSelfSigned => '接受自签名证书';

  @override
  String get login_actionLogin => '登录';

  @override
  String get login_existingSessionDialogConfirm => '登出';

  @override
  String get login_existingSessionDialogMessage => '您想登出当前会话并打开一个新会话吗？';

  @override
  String get login_existingSessionDialogTitle => '当前会话处于活动状态';

  @override
  String get login_fieldClientId => '客户端 ID';

  @override
  String get login_fieldClientSecret => '客户端密钥';

  @override
  String get login_fieldPassword => '密码';

  @override
  String get login_fieldUsername => '用户名';

  @override
  String get login_openLogConsole => '打开日志控制台';

  @override
  String get readingsettings_fontFamily => '字体系列';

  @override
  String get readingsettings_fontSize => '字体大小';

  @override
  String get readdingsettings_textFormatting => '文本格式化';

  @override
  String get readingsettings_title => '文本设置';

  @override
  String get save_confirmationTitle => '文章已保存！';

  @override
  String save_dubiousUrlMessage(String url) {
    return '此 URL 看起来不像网址。无论如何都要保存？\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => '保存它';

  @override
  String get save_dubiousUrlTitle => '可疑 URL';

  @override
  String get save_noUrl => '未提供 URL';

  @override
  String get save_title => '保存文章';

  @override
  String get save_viewArticle => '浏览文章';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return '选择 $numberOfItems';
  }

  @override
  String get server_address => '服务器地址';

  @override
  String server_emptyField(String label) {
    return '输入您的 $label';
  }

  @override
  String get server_invalidUrl => '无效的地址';

  @override
  String get server_unknownServerType => '未知服务类型';

  @override
  String get server_unreachable => '服务器不可达';

  @override
  String get server_versionNotSupported => '服务版本不支持';

  @override
  String get session_copiedToClipboard => '已复制到剪贴板';

  @override
  String get session_invalidToken => '无效';

  @override
  String get session_logoutDialogConfirm => '登出';

  @override
  String get session_logoutDialogMessage => '您需要重新登录。';

  @override
  String get session_logoutDialogTitle => '登出会话';

  @override
  String get session_logoutSession => '登出会话';

  @override
  String get session_fieldAccessToken => '访问令牌';

  @override
  String get session_fieldApiToken => 'API 令牌';

  @override
  String get session_fieldLastServerSync => '上一次服务器同步';

  @override
  String get session_fieldTokenExpiration => '令牌到期';

  @override
  String get session_forceTokenResfresh => '强制刷新令牌';

  @override
  String get session_neverSynced => '从未';

  @override
  String get session_renewDialogMessage => '服务器拒绝当前会话令牌。您需要重新登录才能恢复同步。';

  @override
  String get session_renewDialogTitle => '刷新会话';

  @override
  String get session_title => '会话详情';

  @override
  String get settings_bugReportLink => '报告错误';

  @override
  String get settings_clearCacheMessage => '本地缓存将被删除，并重新从服务器获取。';

  @override
  String get settings_itemAppearance => '外观';

  @override
  String get settings_itemAbout => '关于';

  @override
  String get settings_itemAppBadge => '显示未读角标';

  @override
  String get settings_itemClearCache => '清除缓存';

  @override
  String get settings_itemLogConsole => '日志控制台';

  @override
  String get settings_itemOpenDeeplink => '打开深度链接';

  @override
  String get settings_itemLanguage => '语言';

  @override
  String get settings_helpToTranslate => '帮助翻译';

  @override
  String get settings_savedArticleTag => '为保存的文章添加标签';

  @override
  String get settings_savedArticleTagLabel => '保存文章的标签';

  @override
  String get settings_itemSessionDetails => '会话详情';

  @override
  String get settings_title => '设置';

  @override
  String get settings_nativeArticleRenderer => '本地文章渲染器';

  @override
  String get settings_valueThemeDark => '深色';

  @override
  String get settings_valueThemeLight => '浅色';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '$countString 个操作';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get g_article => '文章';

  @override
  String get g_check => '檢查';

  @override
  String get g_checking => '正在檢查…';

  @override
  String get g_delete => '删除';

  @override
  String get g_saveLink => '儲存連結';

  @override
  String get g_search => '搜尋';

  @override
  String get g_server => '伺服器';

  @override
  String get g_settings => '設定';

  @override
  String get g_share => '分享';

  @override
  String get g_sourceCode => '原始碼';

  @override
  String get g_synchronize => '同步';

  @override
  String get g_system => '系統';

  @override
  String get g_tag => '標籤';

  @override
  String get g_version => '版本';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString 天',
      one: '1 天',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return '$duration 後';
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
      other: '$nString 小時',
      one: '1 小時',
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
      other: '$nString 分鐘',
      one: '1 分鐘',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration 前';
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
      other: '$nString 秒',
      one: '1 秒',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => '增加標籤';

  @override
  String get article_browseOriginal => '瀏覽原文';

  @override
  String get article_delete => '刪除此文章';

  @override
  String get article_noContentFetched => '沒有獲取內容';

  @override
  String get article_openInBrowser => '在瀏覽器中開啟';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString 分鐘';
  }

  @override
  String get article_refetchContent => '再次擷取內容';

  @override
  String get articlefields_readingTime => '閱讀時間';

  @override
  String get articlefields_tags => '標籤';

  @override
  String get articlefields_title => '標題';

  @override
  String get articlefields_website => '網站';

  @override
  String get filters_articleDomains => '網域';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    return '';
  }

  @override
  String get filters_articleFavoriteStarred => '已收藏';

  @override
  String get filters_articleStateUnread => '未讀';

  @override
  String get filters_articleStateArchived => '已封存';

  @override
  String get filters_articleStateAll => '全部的網站';

  @override
  String get filters_articleTags => '標籤';

  @override
  String get filters_searchbarHint => '在文章中搜尋';

  @override
  String get filters_searchMode => '搜尋模式';

  @override
  String get filters_searchModeTitle => '標題';

  @override
  String get logconsole_title => '日誌控制台';

  @override
  String get listing_noArticles => '沒有文章';

  @override
  String get listing_articlesAll => '全部文章';

  @override
  String get listing_articlesArchived => '已封存的文章';

  @override
  String get listing_articlesUnread => '未讀文章';

  @override
  String get login_actionLogin => '登入';

  @override
  String get login_existingSessionDialogConfirm => '登出';

  @override
  String get login_existingSessionDialogMessage => '你想登出目前工作階段並開啟新工作階段嗎？';

  @override
  String get login_existingSessionDialogTitle => '工作階段目前處於活躍狀態';

  @override
  String get login_fieldClientId => '用戶端 ID';

  @override
  String get login_fieldClientSecret => '用戶端秘密金鑰';

  @override
  String get login_fieldPassword => '密碼';

  @override
  String get login_fieldUsername => '使用者名稱';

  @override
  String get login_openLogConsole => '開啟日誌控制台';

  @override
  String get readingsettings_fontFamily => '字型系列';

  @override
  String get readingsettings_fontSize => '字型大小';

  @override
  String get readingsettings_title => '閱讀設定';

  @override
  String get save_confirmationTitle => '文章已儲存！';

  @override
  String save_dubiousUrlMessage(String url) {
    return '此網址看起來不像。仍要儲存？\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => '儲存它';

  @override
  String get save_dubiousUrlTitle => '可疑的網址';

  @override
  String get save_noUrl => '沒有提供網址';

  @override
  String get save_title => '儲存文章';

  @override
  String get save_viewArticle => '檢視文章';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return '選擇 $numberOfItems';
  }

  @override
  String get server_address => '伺服器位址';

  @override
  String server_emptyField(String label) {
    return '輸入你的 $label';
  }

  @override
  String get server_invalidUrl => '無效的位址';

  @override
  String get server_unreachable => '伺服器無法存取';

  @override
  String get session_copiedToClipboard => '已複製至剪貼簿';

  @override
  String get session_invalidToken => '無效';

  @override
  String get session_logoutDialogConfirm => '登出';

  @override
  String get session_logoutDialogMessage => '你將需要重新登入。';

  @override
  String get session_logoutDialogTitle => '登出工作階段';

  @override
  String get session_logoutSession => '登出工作階段';

  @override
  String get session_fieldAccessToken => '存取令牌';

  @override
  String get session_fieldLastServerSync => '最近伺服器同步';

  @override
  String get session_fieldTokenExpiration => '令牌過期';

  @override
  String get session_forceTokenResfresh => '強制重新整理令牌';

  @override
  String get session_neverSynced => '從未';

  @override
  String get session_renewDialogMessage => '伺服器拒絕目前工作階段令牌。你需要重新登入以恢復同步。';

  @override
  String get session_renewDialogTitle => '更新工作階段';

  @override
  String get session_title => '工作階段詳細資訊';

  @override
  String get settings_bugReportLink => '報告錯誤';

  @override
  String get settings_clearCacheMessage => '本機快取將會被刪除並再次從伺服器獲取。';

  @override
  String get settings_itemAppearance => '外觀';

  @override
  String get settings_itemAbout => '關於';

  @override
  String get settings_itemAppBadge => '顯示未讀徽章';

  @override
  String get settings_itemClearCache => '清除快取';

  @override
  String get settings_itemLogConsole => '日誌控制台';

  @override
  String get settings_itemOpenDeeplink => '開啟深層連結';

  @override
  String get settings_itemLanguage => '語言';

  @override
  String get settings_helpToTranslate => '幫助翻譯';

  @override
  String get settings_savedArticleTag => '為已儲存的文章增加標籤';

  @override
  String get settings_savedArticleTagLabel => '已儲存文章的標籤';

  @override
  String get settings_itemSessionDetails => '工作階段詳細資訊';

  @override
  String get settings_title => '設定';

  @override
  String get settings_valueThemeDark => '深色';

  @override
  String get settings_valueThemeLight => '淺色';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString 個操作',
      one: '1 個操作',
    );
    return '$_temp0';
  }
}
