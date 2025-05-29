// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get g_article => 'Artículo';

  @override
  String get g_check => 'Comprobar';

  @override
  String get g_checking => 'Comprobando…';

  @override
  String get g_delete => 'Borrar';

  @override
  String get g_saveLink => 'Guardar enlace';

  @override
  String get g_search => 'Buscar';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Ajustes';

  @override
  String get g_share => 'Compartir';

  @override
  String get g_sourceCode => 'Código fuente';

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
    return 'Hace $duration';
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
  String get article_addTags => 'Añadir etiquetas';

  @override
  String get article_archive => 'Archivar este artículo';

  @override
  String get article_browseOriginal => 'Explorar el original';

  @override
  String get article_delete => 'Borrar este artículo';

  @override
  String get article_details => 'Más información';

  @override
  String get article_noContentFetched => 'No se ha obtenido ningún contenido';

  @override
  String get article_notFound => 'Artículo no encontrado';

  @override
  String get article_openInBrowser => 'Abrir en el navegador';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Redescargar el contenido';

  @override
  String get article_readingSettings => 'Ajustes de texto';

  @override
  String get article_share => 'Compartir este artículo';

  @override
  String get article_star => 'Añadir artículo a favoritos';

  @override
  String get article_unarchive => 'Desarchivar artículo';

  @override
  String get article_unstar => 'Eliminar de artículos favoritos';

  @override
  String get articlefields_readingTime => 'Tiempo de lectura';

  @override
  String get articlefields_tags => 'Etiquetas';

  @override
  String get articlefields_title => 'Título';

  @override
  String get articlefields_website => 'Página web';

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
  String get filters_articleFavoriteStarred => 'Iniciado';

  @override
  String get filters_articleState => 'Estado';

  @override
  String get filters_articleStateUnread => 'Sin leer';

  @override
  String get filters_articleStateArchived => 'Archivado';

  @override
  String get filters_articleStateAll => 'Todos los estados';

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
  String get filters_searchbarHint => 'Buscar en los artículos';

  @override
  String get filters_searchMode => 'Modo de búsqueda';

  @override
  String get filters_searchModeAll => 'Todos los campos';

  @override
  String get filters_searchModeContent => 'Contenido';

  @override
  String get filters_searchModeTitle => 'Título';

  @override
  String get logconsole_title => 'Consola de registro';

  @override
  String get listing_noArticles => 'Sin artículos';

  @override
  String get listing_articlesAll => 'Todo los artículos';

  @override
  String get listing_articlesArchived => 'Artículos archivados';

  @override
  String get listing_articlesUnread => 'Artículos sin leer';

  @override
  String get login_acceptSelfSigned => 'Aceptar certificados autofirmados';

  @override
  String get login_actionLogin => 'Iniciar sesión';

  @override
  String get login_existingSessionDialogConfirm => 'Cerrar sesión';

  @override
  String get login_existingSessionDialogMessage =>
      '¿Quieres cerrar la sesión actual y abrir una nueva?';

  @override
  String get login_existingSessionDialogTitle => 'Ya hay una sesión activa';

  @override
  String get login_fieldClientId => 'ID del cliente';

  @override
  String get login_fieldClientSecret => 'clave secreta del cliente';

  @override
  String get login_fieldPassword => 'Contraseña';

  @override
  String get login_fieldUsername => 'Nombre de usuario';

  @override
  String get login_openLogConsole => 'Abrir la consola de registro';

  @override
  String get readingsettings_fontFamily => 'Familia de fuentes';

  @override
  String get readingsettings_fontSize => 'Tamaño de fuente';

  @override
  String get readdingsettings_textFormatting => 'Formato del texto';

  @override
  String get readingsettings_title => 'Ajustes de texto';

  @override
  String get save_confirmationTitle => '¡Artículo guardado!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Esa URL no parece válida. ¿Guardar de todos modos?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Guárdala';

  @override
  String get save_dubiousUrlTitle => 'URL dudosa';

  @override
  String get save_noUrl => 'No se proporcionó URL';

  @override
  String get save_title => 'Guardar artículo';

  @override
  String get save_viewArticle => 'Ver artículo';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecciona $numberOfItems';
  }

  @override
  String get server_address => 'Dirección del servidor';

  @override
  String get server_apiError => 'Respuesta de API no válida';

  @override
  String server_emptyField(String label) {
    return 'Ingresa tu $label';
  }

  @override
  String get server_invalidUrl => 'Dirección incorrecta';

  @override
  String get server_unreachable => 'Servidor inaccesible';

  @override
  String get session_copiedToClipboard => 'Copiado al portapapeles';

  @override
  String get session_invalidToken => 'incorrecto';

  @override
  String get session_logoutDialogConfirm => 'Finalizar la sesión';

  @override
  String get session_logoutDialogMessage =>
      'Necesitarás iniciar sesión nuevamente.';

  @override
  String get session_logoutDialogTitle => 'Cerrar sesión';

  @override
  String get session_logoutSession => 'Cerrar sesión';

  @override
  String get session_fieldAccessToken => 'Token de acceso';

  @override
  String get session_fieldApiToken => 'Token de la api';

  @override
  String get session_fieldLastServerSync =>
      'Última sincronización del servidor';

  @override
  String get session_fieldTokenExpiration => 'Expiración del token';

  @override
  String get session_forceTokenResfresh => 'Forzar la actualización del token';

  @override
  String get session_neverSynced => 'nunca';

  @override
  String get session_renewDialogMessage =>
      'El servidor rechaza el token de la sesión actual. Deberá iniciar sesión nuevamente para reanudar la sincronización.';

  @override
  String get session_renewDialogTitle => 'Renovar sesión';

  @override
  String get session_title => 'Detalles de la sesión';

  @override
  String get settings_bugReportLink => 'Informar de un error';

  @override
  String get settings_clearCacheMessage =>
      'La caché local se eliminará y se recuperará nuevamente del servidor.';

  @override
  String get settings_itemAppearance => 'Aspecto';

  @override
  String get settings_itemAbout => 'Acerca de';

  @override
  String get settings_itemAppBadge => 'Mostrar marca de no leído';

  @override
  String get settings_itemClearCache => 'Borrar la caché';

  @override
  String get settings_itemLogConsole => 'Consola de registro';

  @override
  String get settings_itemOpenDeeplink => 'Abrir un enlace profundo';

  @override
  String get settings_itemLanguage => 'Idioma';

  @override
  String get settings_helpToTranslate => 'Ayuda con la traducción';

  @override
  String get settings_savedArticleTag =>
      'Añadir una etiqueta a los artículos guardados';

  @override
  String get settings_savedArticleTagLabel =>
      'Etiqueta para artículos guardados';

  @override
  String get settings_itemSessionDetails => 'Detalles de la sesión';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_nativeArticleRenderer => 'Native article renderer';

  @override
  String get settings_valueThemeDark => 'Oscuro';

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
      other: '$countString acciones',
      one: '1 acción',
    );
    return '$_temp0';
  }
}
