// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get g_article => 'Статья';

  @override
  String get g_check => 'Проверка';

  @override
  String get g_checking => 'Проверка…';

  @override
  String get g_delete => 'Удалить';

  @override
  String get g_saveLink => 'Сохранить ссылку';

  @override
  String get g_search => 'Поиск';

  @override
  String get g_server => 'Сервер';

  @override
  String get g_settings => 'Настройки';

  @override
  String get g_share => 'Поделиться';

  @override
  String get g_sourceCode => 'Исходный код';

  @override
  String get g_synchronize => 'Синхронизировать';

  @override
  String get g_system => 'Система';

  @override
  String get g_tag => 'Тег';

  @override
  String get g_version => 'Версия';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString день (дня/дней)',
      one: '1 день',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'продолжительность $duration';
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
      other: '$nString час(а/ов)',
      one: '1 час',
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
      other: '$nString минут(а/ы)',
      one: '1 минута',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration назад';
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
      other: '$nString секунд(а/ы)',
      one: '1 секунда',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Добавить теги';

  @override
  String get article_archive => 'Поместить статью в архив';

  @override
  String get article_browseOriginal => 'Просмотреть оригинал';

  @override
  String get article_delete => 'Удалить эту статью';

  @override
  String get article_details => 'Больше информации';

  @override
  String get article_noContentFetched => 'Содержимое не получено';

  @override
  String get article_notFound => 'Статья не найдена';

  @override
  String get article_openInBrowser => 'Открыть в браузере';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString минут(а/ы)';
  }

  @override
  String get article_refetchContent => 'Перезагрузить контент';

  @override
  String get article_readingSettings => 'Текстовые настройки';

  @override
  String get article_share => 'Поделиться этой статьёй';

  @override
  String get article_star => 'Пометить эту статью';

  @override
  String get article_unarchive => 'Вернуть статью из архива';

  @override
  String get article_unstar => 'Снять отметку с этой статьи';

  @override
  String get articlefields_readingTime => 'Время чтения';

  @override
  String get articlefields_tags => 'Теги';

  @override
  String get articlefields_title => 'Название';

  @override
  String get articlefields_website => 'Веб-сайт';

  @override
  String get filters_articleDomains => 'Домены';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString домен(а/ов)',
      one: '1 домен',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Отмеченные';

  @override
  String get filters_articleState => 'Статус';

  @override
  String get filters_articleStateUnread => 'Непрочитанные';

  @override
  String get filters_articleStateArchived => 'Архивные';

  @override
  String get filters_articleStateAll => 'Все состояния';

  @override
  String get filters_articleTags => 'Теги';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString тег(а/ов)',
      one: '1 тег',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Поиск в статьях';

  @override
  String get filters_searchMode => 'Режим поиска';

  @override
  String get filters_searchModeAll => 'Все поля';

  @override
  String get filters_searchModeContent => 'Контент';

  @override
  String get filters_searchModeTitle => 'Название';

  @override
  String get logconsole_title => 'Журнал';

  @override
  String get logconsole_clear_logs => 'Clear logs';

  @override
  String get logconsole_export_title => 'Экспорт в файл';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '1$countString lines',
      one: '1 line',
    );
    return 'Текущий сеанс ($_temp0';
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
      other: '1$countString lines',
      one: '1 line',
    );
    return 'Все журналы ($_temp0';
  }

  @override
  String get listing_noArticles => 'Нет статьей';

  @override
  String get listing_articlesAll => 'Все статьи';

  @override
  String get listing_articlesArchived => 'Архивные статьи';

  @override
  String get listing_articlesUnread => 'Непрочитанные статьи';

  @override
  String get login_acceptSelfSigned => 'Принимать самоподписанные сертификаты';

  @override
  String get login_actionLogin => 'Войти';

  @override
  String get login_demoMode => 'Try in demo mode';

  @override
  String get login_existingSessionDialogConfirm => 'Выйти';

  @override
  String get login_existingSessionDialogMessage =>
      'Хотите выйти из текущей сессии и открыть новую?';

  @override
  String get login_existingSessionDialogTitle =>
      'Сеанс в данный момент активен';

  @override
  String get login_fieldClientId => 'Идентификатор клиента';

  @override
  String get login_fieldClientSecret => 'Секретный ключ клиента';

  @override
  String get login_fieldPassword => 'Пароль';

  @override
  String get login_fieldUsername => 'Имя пользователя';

  @override
  String get login_openLogConsole => 'Открыть журнал';

  @override
  String get readingsettings_fontFamily => 'Семейство шрифтов';

  @override
  String get readingsettings_fontSize => 'Размер шрифта';

  @override
  String get readdingsettings_textFormatting => 'Форматирование текста';

  @override
  String get readingsettings_title => 'Настройки текста';

  @override
  String get save_confirmationTitle => 'Статья сохранена!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Этот адрес не похож на URL. Всё равно сохранить?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Сохранить';

  @override
  String get save_dubiousUrlTitle => 'Сомнительный URL';

  @override
  String get save_noUrl => 'URL-адрес не указан';

  @override
  String get save_title => 'Сохранить статью';

  @override
  String get save_viewArticle => 'Посмотреть статью';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Выбрать $numberOfItems';
  }

  @override
  String get server_address => 'Адрес сервера';

  @override
  String server_emptyField(String label) {
    return 'Введите своё $label';
  }

  @override
  String get server_invalidUrl => 'Неверный адрес';

  @override
  String get server_unknownServerType => 'Неизвестный тип сервера';

  @override
  String get server_unreachable => 'Сервер недоступен';

  @override
  String get server_versionNotSupported => 'Версия сервера не поддерживается';

  @override
  String get session_copiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get session_invalidToken => 'некорректно';

  @override
  String get session_logoutDialogConfirm => 'Выйти';

  @override
  String get session_logoutDialogMessage =>
      'Вам придётся заново войти в систему.';

  @override
  String get session_logoutDialogTitle => 'Завершение сеанса';

  @override
  String get session_logoutSession => 'Выйти из сеанса';

  @override
  String get session_fieldAccessToken => 'Токен доступа';

  @override
  String get session_fieldApiToken => 'Токен API';

  @override
  String get session_fieldLastServerSync => 'Последняя синхронизация сервера';

  @override
  String get session_fieldTokenExpiration => 'Истечение срока действия токена';

  @override
  String get session_forceTokenResfresh => 'Принудительное обновление токена';

  @override
  String get session_neverSynced => 'никогда';

  @override
  String get session_renewDialogMessage =>
      'Сервер отказывается использовать токен текущего сеанса. Чтобы возобновить синхронизацию, необходимо снова войти в систему.';

  @override
  String get session_renewDialogTitle => 'Обновление сеанса';

  @override
  String get session_title => 'Детали сеанса';

  @override
  String get settings_bugReportLink => 'Сообщить об ошибке';

  @override
  String get settings_clearCacheMessage =>
      'Локальный кэш будет удалён и снова получен с сервера.';

  @override
  String get settings_itemAppearance => 'Тема';

  @override
  String get settings_itemAbout => 'Информация';

  @override
  String get settings_itemAppBadge => 'Показать значок «непрочитанное»';

  @override
  String get settings_itemClearCache => 'Очистить кэш';

  @override
  String get settings_itemLogConsole => 'Журнал';

  @override
  String get settings_itemOpenDeeplink => 'Открыть глубинную ссылку';

  @override
  String get settings_itemLanguage => 'Язык';

  @override
  String get settings_helpToTranslate => 'Помочь перевести';

  @override
  String get settings_savedArticleTag => 'Добавить тег к сохранённым статьям';

  @override
  String get settings_savedArticleTagLabel => 'Ярлык для сохранённых статей';

  @override
  String get settings_itemSessionDetails => 'Детали сеанса';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_nativeArticleRenderer => 'Системный отрисовщик статьи';

  @override
  String get settings_valueThemeDark => 'Тёмная';

  @override
  String get settings_valueThemeLight => 'Светлая';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString действ(ие/ия/ий)',
      one: '1 действие',
    );
    return '$_temp0';
  }
}
