// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get g_article => 'Artigo';

  @override
  String get g_check => 'Comprobar';

  @override
  String get g_checking => 'Comprobando…';

  @override
  String get g_delete => 'Eliminar';

  @override
  String get g_saveLink => 'Gardar ligazón';

  @override
  String get g_search => 'Buscar';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Axustes';

  @override
  String get g_share => 'Compartir';

  @override
  String get g_sourceCode => 'Código fonte';

  @override
  String get g_synchronize => 'Sincronizar';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Etiqueta';

  @override
  String get g_version => 'Versión';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'en $duration';
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
      other: '$nString horas',
      one: '1 hora',
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
      other: '$nString minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'fai $duration';
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
      other: '$nString segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Engadir etiquetas';

  @override
  String get article_archive => 'Arquivar este artigo';

  @override
  String get article_browseOriginal => 'Ir ao orixinal';

  @override
  String get article_delete => 'Eliminar este artigo';

  @override
  String get article_details => 'Máis información';

  @override
  String get article_noContentFetched => 'Non se obtivo contido';

  @override
  String get article_notFound => 'Non se atopa o artigo';

  @override
  String get article_openInBrowser => 'Abrir no navegador';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Volver a obter contido';

  @override
  String get article_readingSettings => 'Axustes do texto';

  @override
  String get article_share => 'Compartir este artigo';

  @override
  String get article_star => 'Pór estrela ao artigo';

  @override
  String get article_unarchive => 'Retirar do arquivo';

  @override
  String get article_unstar => 'Retirar estrela';

  @override
  String get articlefields_readingTime => 'Tempo de lectura';

  @override
  String get articlefields_tags => 'Etiquetas';

  @override
  String get articlefields_title => 'Título';

  @override
  String get articlefields_website => 'Sitio web';

  @override
  String get filters_articleDomains => 'Dominios';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString dominios',
      one: '1 dominio',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Con estrela';

  @override
  String get filters_articleState => 'Estado';

  @override
  String get filters_articleStateUnread => 'Sen ler';

  @override
  String get filters_articleStateArchived => 'Arquivado';

  @override
  String get filters_articleStateAll => 'Todos os estados';

  @override
  String get filters_articleTags => 'Etiquetas';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString etiquetas',
      one: '1 etiqueta',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Buscar nos artigos';

  @override
  String get filters_searchMode => 'Modo de busca';

  @override
  String get filters_searchModeAll => 'Todos os campos';

  @override
  String get filters_searchModeContent => 'Contido';

  @override
  String get filters_searchModeTitle => 'Título';

  @override
  String get logconsole_title => 'Consola do rexistro';

  @override
  String get logconsole_clear_logs => 'Limpar rexistro';

  @override
  String get logconsole_export_title => 'Exportar como ficheiro';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString liñas',
      one: '1 liña',
    );
    return 'Sesión actual ($_temp0)';
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
      other: '$countString liñas',
      one: '1 liña',
    );
    return 'Todos os rexistros ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Sen artigos';

  @override
  String get listing_articlesAll => 'Todos os artigos';

  @override
  String get listing_articlesArchived => 'Artigos arquivados';

  @override
  String get listing_articlesUnread => 'Artigos sen ler';

  @override
  String get login_acceptSelfSigned => 'Aceptar certificados auto-asinados';

  @override
  String get login_actionLogin => 'Acceder';

  @override
  String get login_existingSessionDialogConfirm => 'Saír';

  @override
  String get login_existingSessionDialogMessage =>
      'Queres pechar a sesión actual e abrir unha nova?';

  @override
  String get login_existingSessionDialogTitle => 'Hai unha sesión activa';

  @override
  String get login_fieldClientId => 'ID do cliente';

  @override
  String get login_fieldClientSecret => 'Segreda do cliente';

  @override
  String get login_fieldPassword => 'Contrasinal';

  @override
  String get login_fieldUsername => 'Identificador';

  @override
  String get login_openLogConsole => 'Abrir a Consola do rexistro';

  @override
  String get readingsettings_fontFamily => 'Tipo de letra';

  @override
  String get readingsettings_fontSize => 'Tamaño da letra';

  @override
  String get readdingsettings_textFormatting => 'Formato do texto';

  @override
  String get readingsettings_title => 'Axustes do texto';

  @override
  String get save_confirmationTitle => 'Gardouse o artigo!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Este URL non semella válido. Gardar igualmente?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Gardalo';

  @override
  String get save_dubiousUrlTitle => 'URL dubidoso';

  @override
  String get save_noUrl => 'Sen URL proporcionado';

  @override
  String get save_title => 'Gardar artigo';

  @override
  String get save_viewArticle => 'Ver artigo';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Seleccionar $numberOfItems';
  }

  @override
  String get server_address => 'Enderezo do servidor';

  @override
  String server_emptyField(String label) {
    return 'Escribe o teu $label';
  }

  @override
  String get server_invalidUrl => 'Enderezo non válido';

  @override
  String get server_unknownServerType => 'Tipo de servidor descoñecido';

  @override
  String get server_unreachable => 'Servidor non accesible';

  @override
  String get server_versionNotSupported => 'Versión do servidor non compatible';

  @override
  String get session_copiedToClipboard => 'Copiado ao portapapeis';

  @override
  String get session_invalidToken => 'non válido';

  @override
  String get session_logoutDialogConfirm => 'Saír';

  @override
  String get session_logoutDialogMessage => 'Vas ter que acceder de novo.';

  @override
  String get session_logoutDialogTitle => 'Pechar sesión';

  @override
  String get session_logoutSession => 'Pechar sesión';

  @override
  String get session_fieldAccessToken => 'Token de acceso';

  @override
  String get session_fieldApiToken => 'Token da API';

  @override
  String get session_fieldLastServerSync => 'Última sincronización';

  @override
  String get session_fieldTokenExpiration => 'Caducidade do token';

  @override
  String get session_forceTokenResfresh => 'Forzar actualización do token';

  @override
  String get session_neverSynced => 'nunca';

  @override
  String get session_renewDialogMessage =>
      'O servidor rexeita o token de sesión actual. Terás que acceder outra vez para continuar coa sincronización.';

  @override
  String get session_renewDialogTitle => 'Anovar a sesión';

  @override
  String get session_title => 'Detalles da sesión';

  @override
  String get settings_bugReportLink => 'Informar de problemas';

  @override
  String get settings_clearCacheMessage =>
      'Vaise eliminar a caché local e solicitar outra vez os datos ao servidor.';

  @override
  String get settings_itemAppearance => 'Aparencia';

  @override
  String get settings_itemAbout => 'Sobre';

  @override
  String get settings_itemAppBadge => 'Mostrar marca de non lido';

  @override
  String get settings_itemClearCache => 'Limpar caché';

  @override
  String get settings_itemLogConsole => 'Consola de rexistro';

  @override
  String get settings_itemOpenDeeplink => 'Abrir unha ligazón oculta';

  @override
  String get settings_itemLanguage => 'Idioma';

  @override
  String get settings_helpToTranslate => 'Axuda a traducir';

  @override
  String get settings_savedArticleTag =>
      'Engadir etiqueta aos artigos gardados';

  @override
  String get settings_savedArticleTagLabel =>
      'Etiqueta para os artigos gardados';

  @override
  String get settings_itemSessionDetails => 'Detalles da sesión';

  @override
  String get settings_title => 'Axustes';

  @override
  String get settings_nativeArticleRenderer => 'Motor de visualización nativo';

  @override
  String get settings_valueThemeDark => 'Escuro';

  @override
  String get settings_valueThemeLight => 'Claro';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString accións',
      one: '1 acción',
    );
    return '$_temp0';
  }
}
