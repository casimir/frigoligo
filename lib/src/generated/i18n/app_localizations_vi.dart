// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get g_article => 'Bài viết';

  @override
  String get g_check => 'Kiểm tra';

  @override
  String get g_checking => 'Đang kiểm tra…';

  @override
  String get g_delete => 'Xóa';

  @override
  String get g_saveLink => 'Lưu liên kết';

  @override
  String get g_search => 'Tìm kiếm';

  @override
  String get g_server => 'Máy chủ';

  @override
  String get g_settings => 'Cài đặt';

  @override
  String get g_share => 'Chia sẻ';

  @override
  String get g_sourceCode => 'Mã nguồn';

  @override
  String get g_synchronize => 'Đồng bộ hóa';

  @override
  String get g_system => 'Hệ thống';

  @override
  String get g_tag => 'Thẻ';

  @override
  String get g_version => 'Phiên bản';

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
    return 'trong $duration';
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
    return '$duration trước';
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
  String get article_addTags => 'Thêm thẻ';

  @override
  String get article_archive => 'Lưu trữ bài viết này';

  @override
  String get article_browseOriginal => 'Duyệt bản gốc';

  @override
  String get article_delete => 'Xóa bài viết này';

  @override
  String get article_details => 'Thông tin thêm';

  @override
  String get article_noContentFetched => 'Không tìm nạp được nội dung';

  @override
  String get article_notFound => 'Không tìm thấy bài viết';

  @override
  String get article_openInBrowser => 'Mở trong trình duyệt';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString phút';
  }

  @override
  String get article_refetchContent => 'Tìm nạp lại nội dung';

  @override
  String get article_readingSettings => 'Cài đặt văn bản';

  @override
  String get article_share => 'Chia sẻ bài viết này';

  @override
  String get article_star => 'Đánh dấu bài viết này';

  @override
  String get article_unarchive => 'Hủy lưu trữ bài viết này';

  @override
  String get article_unstar => 'Bỏ dấu sao bài viết này';

  @override
  String get articlefields_readingTime => 'Thời gian đọc';

  @override
  String get articlefields_tags => 'Thẻ';

  @override
  String get articlefields_title => 'Tiêu đề';

  @override
  String get articlefields_website => 'Website';

  @override
  String get filters_articleDomains => 'Tên miền';

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
  String get filters_articleFavoriteStarred => 'Đã gắn dấu sao';

  @override
  String get filters_articleState => 'Trạng thái';

  @override
  String get filters_articleStateUnread => 'Chưa đọc';

  @override
  String get filters_articleStateArchived => 'Đã lưu trữ';

  @override
  String get filters_articleStateAll => 'Tất cả các trạng thái';

  @override
  String get filters_articleTags => 'Thẻ';

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
  String get filters_searchbarHint => 'Tìm kiếm trong bài viết';

  @override
  String get filters_searchMode => 'Chế độ tìm kiếm';

  @override
  String get filters_searchModeAll => 'Tất cả các trường';

  @override
  String get filters_searchModeContent => 'Nội dung';

  @override
  String get filters_searchModeTitle => 'Tiêu đề';

  @override
  String get logconsole_title => 'Bảng điều khiển nhật ký';

  @override
  String get logconsole_clear_logs => 'Xóa nhật ký';

  @override
  String get logconsole_export_title => 'Xuất dưới dạng tệp';

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
  String get listing_noArticles => 'Không có bài viết';

  @override
  String get listing_articlesAll => 'Tất cả bài viết';

  @override
  String get listing_articlesArchived => 'Các bài viết được lưu trữ';

  @override
  String get listing_articlesUnread => 'Bài viết chưa đọc';

  @override
  String get login_acceptSelfSigned => 'Chấp nhận chứng chỉ tự ký';

  @override
  String get login_actionLogin => 'Đăng nhập';

  @override
  String get login_demoMode => 'Thử chế độ demo';

  @override
  String get login_existingSessionDialogConfirm => 'Đăng xuất';

  @override
  String get login_existingSessionDialogMessage =>
      'Bạn có muốn đăng xuất khỏi phiên hiện tại và mở một phiên mới không?';

  @override
  String get login_existingSessionDialogTitle =>
      'Một phiên đang hiện tại đang kích hoạt';

  @override
  String get login_fieldClientId => 'ID máy khách';

  @override
  String get login_fieldClientSecret => 'Bí mật client';

  @override
  String get login_fieldPassword => 'Mật khẩu';

  @override
  String get login_fieldUsername => 'Tên người dùng';

  @override
  String get login_openLogConsole => 'Mở Nhật ký Console';

  @override
  String get readingsettings_fontFamily => 'Phông gia đình';

  @override
  String get readingsettings_fontSize => 'Kích thước phông';

  @override
  String get readdingsettings_textFormatting => 'Định dạng phông';

  @override
  String get readingsettings_title => 'Cài đặt văn bản';

  @override
  String get save_confirmationTitle => 'Bài viết đã lưu!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'URL này trông không giống URL này. Vẫn lưu nó?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Lưu nó';

  @override
  String get save_dubiousUrlTitle => 'URL đáng ngờ';

  @override
  String get save_noUrl => 'Không cung cấp URL';

  @override
  String get save_title => 'Lưu bài viết';

  @override
  String get save_viewArticle => 'Xem bài viết';

  @override
  String get save_localModeError =>
      'Một kết nối máy chủ là cần thiết để lưu bài viết mới.';

  @override
  String save_malformedUrlError(String url) {
    return 'URL không đúng định dạng: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Chọn $numberOfItems';
  }

  @override
  String get server_address => 'Địa chỉ máy chủ';

  @override
  String server_emptyField(String label) {
    return 'Nhập $label của bạn';
  }

  @override
  String get server_invalidUrl => 'Địa chỉ sai';

  @override
  String get server_unknownServerType => 'Không rõ loại máy chủ';

  @override
  String get server_unreachable => 'Không thể truy cập được máy chủ';

  @override
  String get server_versionNotSupported =>
      'Phiên bản máy chủ không được hỗ trợ';

  @override
  String get session_copiedToClipboard => 'Đã sao chép vào bộ nhớ tạm';

  @override
  String get session_invalidToken => 'không hợp lệ';

  @override
  String get session_logoutDialogConfirm => 'Đăng xuất';

  @override
  String get session_logoutDialogMessage => 'Bạn sẽ cần phải đăng nhập lại.';

  @override
  String get session_logoutDialogTitle => 'Phiên đăng xuất';

  @override
  String get session_logoutSession => 'Phiên đăng xuất';

  @override
  String get session_fieldAccessToken => 'Token truy cập';

  @override
  String get session_fieldApiToken => 'Token API';

  @override
  String get session_fieldLastServerSync => 'Đồng bộ hóa máy chủ lần cuối';

  @override
  String get session_fieldTokenExpiration => 'Hết hạn token';

  @override
  String get session_forceTokenResfresh => 'Buộc làm mới token';

  @override
  String get session_neverSynced => 'không bao giờ';

  @override
  String get session_renewDialogMessage =>
      'Máy chủ từ chối token phiên hiện tại. Bạn sẽ cần phải đăng nhập lại để tiếp tục đồng bộ hóa.';

  @override
  String get session_renewDialogTitle => 'Phiên gia hạn';

  @override
  String get session_title => 'Chi tiết phiên';

  @override
  String get settings_bugReportLink => 'Báo cáo lỗi';

  @override
  String get settings_clearCacheMessage =>
      'Bộ nhớ đệm cục bộ sẽ bị xóa và tải lại từ máy chủ.';

  @override
  String get settings_itemAppearance => 'Giao diện';

  @override
  String get settings_itemAbout => 'Giới thiệu';

  @override
  String get settings_itemAppBadge => 'Hiển thị huy hiệu chưa đọc';

  @override
  String get settings_itemClearCache => 'Xóa bộ nhớ đệm';

  @override
  String get settings_itemLicenses => 'View licenses';

  @override
  String get settings_itemLogConsole => 'Bảng điều khiển nhật ký';

  @override
  String get settings_itemOpenDeeplink => 'Mở liên kết sâu';

  @override
  String get settings_itemLanguage => 'Ngôn ngữ';

  @override
  String get settings_helpToTranslate => 'Trợ giúp dịch thuật';

  @override
  String get settings_savedArticleTag => 'Thêm thẻ vào bài viết đã lưu';

  @override
  String get settings_savedArticleTagLabel => 'Thẻ cho các bài viết đã lưu';

  @override
  String get settings_itemSessionDetails => 'Chi tiết phiên';

  @override
  String get settings_title => 'Cài đặt';

  @override
  String get settings_nativeArticleRenderer => 'Trình kết xuất bài viết gốc';

  @override
  String get settings_valueThemeDark => 'Tối';

  @override
  String get settings_valueThemeLight => 'Sáng';

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
