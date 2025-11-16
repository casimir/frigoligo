// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get g_article => 'Artigo';

  @override
  String get g_check => 'Verificar';

  @override
  String get g_checking => 'Verificando…';

  @override
  String get g_delete => 'Suprimir';

  @override
  String get g_saveLink => 'Guardar link';

  @override
  String get g_search => 'Pesquisar';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Configurações';

  @override
  String get g_share => 'Compartilhar';

  @override
  String get g_sourceCode => 'Código-fonte';

  @override
  String get g_synchronize => 'Sincronizar';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Tag';

  @override
  String get g_version => 'Versão';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'em $duration';
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
      other: ' $nString horas',
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
      other: ' $nString minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration atrás';
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
      other: ' $nString segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Adicionar tags';

  @override
  String get article_archive => 'Arquivar este artigo';

  @override
  String get article_browseOriginal => 'Navegue pelo original';

  @override
  String get article_delete => 'Suprimir este artigo';

  @override
  String get article_details => 'Mais informações';

  @override
  String get article_noContentFetched => 'Nenhum conteúdo buscado';

  @override
  String get article_notFound => 'Artigo não encontrado';

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
  String get article_refetchContent => 'Recapturar o conteúdo';

  @override
  String get article_readingSettings => 'Configurações de texto';

  @override
  String get article_share => 'Partilhar este artigo';

  @override
  String get article_star => 'Marcar este artigo como favorito';

  @override
  String get article_unarchive => 'Desarquivar este artigo';

  @override
  String get article_unstar => 'Desmarcar este artigo como favorito';

  @override
  String get articlefields_readingTime => 'Tempo de leitura';

  @override
  String get articlefields_tags => 'Etiquetas';

  @override
  String get articlefields_title => 'Título';

  @override
  String get articlefields_website => 'Sitio Web';

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
      other: '$countString domains',
      one: '1 domain',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Favorito';

  @override
  String get filters_articleState => 'Estado';

  @override
  String get filters_articleStateUnread => 'Por ler';

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
      other: '$countString tags',
      one: '1 tag',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Pesquisar nos artigos';

  @override
  String get filters_searchMode => 'Modo de pesquisa';

  @override
  String get filters_searchModeAll => 'Todos os campos';

  @override
  String get filters_searchModeContent => 'Conteúdo';

  @override
  String get filters_searchModeTitle => 'Título';

  @override
  String get logconsole_title => 'Console de Logs';

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
  String get listing_noArticles => 'Nenhum artigo';

  @override
  String get listing_articlesAll => 'Todos os artigos';

  @override
  String get listing_articlesArchived => 'Artigos arquivados';

  @override
  String get listing_articlesUnread => 'Artigos não lidos';

  @override
  String get login_acceptSelfSigned => 'Aceitar certificados auto-assinados';

  @override
  String get login_actionLogin => 'Conecte-se';

  @override
  String get login_existingSessionDialogConfirm => 'Sair';

  @override
  String get login_existingSessionDialogMessage =>
      'Deseja sair da sessão atual e abrir uma nova?';

  @override
  String get login_existingSessionDialogTitle =>
      'Uma sessão está ativa no momento';

  @override
  String get login_fieldClientId => 'ID do cliente';

  @override
  String get login_fieldClientSecret => 'Segredo do cliente';

  @override
  String get login_fieldPassword => 'Palavra-passe';

  @override
  String get login_fieldUsername => 'Nome de utilizador';

  @override
  String get login_openLogConsole => 'Abra o console de log';

  @override
  String get readingsettings_fontFamily => 'Família de fontes';

  @override
  String get readingsettings_fontSize => 'Tamanho da fonte';

  @override
  String get readdingsettings_textFormatting => 'Formatação de texto';

  @override
  String get readingsettings_title => 'Configurações de texto';

  @override
  String get save_confirmationTitle => 'Artigo gravado!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Esta URL não parece uma. Gravar mesmo assim?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Grave-o';

  @override
  String get save_dubiousUrlTitle => 'URL duvidosa';

  @override
  String get save_noUrl => 'Nenhuma URL fornecida';

  @override
  String get save_title => 'Gravar artigo';

  @override
  String get save_viewArticle => 'Ver artigo';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecione $numberOfItems';
  }

  @override
  String get server_address => 'Endereço do servidor';

  @override
  String server_emptyField(String label) {
    return 'Insira seu $label';
  }

  @override
  String get server_invalidUrl => 'Endereço inválido';

  @override
  String get server_unknownServerType => 'Tipo de servidor desconhecido';

  @override
  String get server_unreachable => 'Servidor inacessível';

  @override
  String get server_versionNotSupported => 'Versão do servidor não suportada';

  @override
  String get session_copiedToClipboard =>
      'Copiado para a área de transferência';

  @override
  String get session_invalidToken => 'inválido';

  @override
  String get session_logoutDialogConfirm => 'Sair';

  @override
  String get session_logoutDialogMessage =>
      'Precisará efetuar login novamente.';

  @override
  String get session_logoutDialogTitle => 'Sair da sessão';

  @override
  String get session_logoutSession => 'Sair da sessão';

  @override
  String get session_fieldAccessToken => 'Token de acesso';

  @override
  String get session_fieldApiToken => 'Token de API';

  @override
  String get session_fieldLastServerSync => 'Última sincronização do servidor';

  @override
  String get session_fieldTokenExpiration => 'Expiração do token';

  @override
  String get session_forceTokenResfresh => 'Forçar atualização do token';

  @override
  String get session_neverSynced => 'Nunca';

  @override
  String get session_renewDialogMessage =>
      'O servidor recusa o token de sessão atual. Precisará efetuar login novamente para retomar a sincronização.';

  @override
  String get session_renewDialogTitle => 'Renovar sessão';

  @override
  String get session_title => 'Pormenores da sessão';

  @override
  String get settings_bugReportLink => 'Reportar um bug';

  @override
  String get settings_clearCacheMessage =>
      'O cache local será apagado e recuperado novamente do servidor.';

  @override
  String get settings_itemAppearance => 'Aparência';

  @override
  String get settings_itemAbout => 'Sobre';

  @override
  String get settings_itemAppBadge => 'Mostrar emblema não lido';

  @override
  String get settings_itemClearCache => 'Limpar cache';

  @override
  String get settings_itemLogConsole => 'Console de Logs';

  @override
  String get settings_itemOpenDeeplink => 'Abra uma ligação profunda';

  @override
  String get settings_itemLanguage => 'Linguagem';

  @override
  String get settings_helpToTranslate => 'Ajuda para traduzir';

  @override
  String get settings_savedArticleTag =>
      'Adicionar uma tag aos artigos gravados';

  @override
  String get settings_savedArticleTagLabel => 'Etiqueta para artigos gravados';

  @override
  String get settings_itemSessionDetails => 'Pormenores da sessão';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_nativeArticleRenderer => 'Renderizador de artigo nativo';

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
      other: '$countString actions',
      one: '1 action',
    );
    return '$_temp0';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get g_article => 'Artigo';

  @override
  String get g_check => 'Checar';

  @override
  String get g_checking => 'Checando…';

  @override
  String get g_delete => 'Deletar';

  @override
  String get g_saveLink => 'Salvar link';

  @override
  String get g_search => 'Pesquisar';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Configurações';

  @override
  String get g_share => 'Compartilhar';

  @override
  String get g_sourceCode => 'Código-fonte';

  @override
  String get g_synchronize => 'Sincronizar';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Tag';

  @override
  String get g_version => 'Versão';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'em $duration';
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
    return '$duration atrás';
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
  String get article_addTags => 'Adicionar tags';

  @override
  String get article_archive => 'Arquivar este artigo';

  @override
  String get article_browseOriginal => 'Navegue pela versão original';

  @override
  String get article_delete => 'Deletar este artigo';

  @override
  String get article_details => 'Mais informações';

  @override
  String get article_noContentFetched => 'Nenhum conteúdo obtido';

  @override
  String get article_notFound => 'Artigo não encontrado';

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
  String get article_refetchContent => 'Buscar conteúdo novamente';

  @override
  String get article_readingSettings => 'Configurações de texto';

  @override
  String get article_share => 'Compartilhar este artigo';

  @override
  String get article_star => 'Favoritar este artigo';

  @override
  String get article_unarchive => 'Desarquivar este artigo';

  @override
  String get article_unstar => 'Desfavoritar este artigo';

  @override
  String get articlefields_readingTime => 'Tempo de leitura';

  @override
  String get articlefields_tags => 'Tags';

  @override
  String get articlefields_title => 'Título';

  @override
  String get articlefields_website => 'Site';

  @override
  String get filters_articleDomains => 'Domínios';

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
  String get filters_articleFavoriteStarred => 'Estrelou';

  @override
  String get filters_articleState => 'Estado';

  @override
  String get filters_articleStateUnread => 'Não lido';

  @override
  String get filters_articleStateArchived => 'Arquivado';

  @override
  String get filters_articleStateAll => 'Todos os estados';

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
  String get filters_searchbarHint => 'Pesquisar em artigos';

  @override
  String get filters_searchMode => 'Modo de pesquisa';

  @override
  String get filters_searchModeAll => 'Todos os campos';

  @override
  String get filters_searchModeContent => 'Conteúdo';

  @override
  String get filters_searchModeTitle => 'Título';

  @override
  String get logconsole_title => 'Console de Logs';

  @override
  String get logconsole_clear_logs => 'Limpar logs';

  @override
  String get logconsole_export_title => 'Exportar como um arquivo';

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
    return 'Sessão atual ($_temp0)';
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
    return 'Todos os logs ($_temp0)';
  }

  @override
  String get listing_noArticles => 'Nenhum artigo';

  @override
  String get listing_articlesAll => 'Todos os artigos';

  @override
  String get listing_articlesArchived => 'Artigos arquivados';

  @override
  String get listing_articlesUnread => 'Artigos não lidos';

  @override
  String get login_acceptSelfSigned => 'Aceitar certificados auto-assinados';

  @override
  String get login_actionLogin => 'Conecte-se';

  @override
  String get login_existingSessionDialogConfirm => 'Sair';

  @override
  String get login_existingSessionDialogMessage =>
      'Deseja sair da sessão atual e abrir uma nova?';

  @override
  String get login_existingSessionDialogTitle =>
      'Uma sessão está ativa no momento';

  @override
  String get login_fieldClientId => 'ID do cliente';

  @override
  String get login_fieldClientSecret => 'Segredo do cliente';

  @override
  String get login_fieldPassword => 'Senha';

  @override
  String get login_fieldUsername => 'Nome de usuário';

  @override
  String get login_openLogConsole => 'Abra o console de log';

  @override
  String get readingsettings_fontFamily => 'Família de fontes';

  @override
  String get readingsettings_fontSize => 'Tamanho da fonte';

  @override
  String get readdingsettings_textFormatting => 'Formatação de texto';

  @override
  String get readingsettings_title => 'Configurações de texto';

  @override
  String get save_confirmationTitle => 'Artigo salvo!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Esta URL não parece uma. Salvar mesmo assim?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Salve isso';

  @override
  String get save_dubiousUrlTitle => 'URL duvidosa';

  @override
  String get save_noUrl => 'Nenhuma URL fornecida';

  @override
  String get save_title => 'Salvar artigo';

  @override
  String get save_viewArticle => 'Ver artigo';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecione $numberOfItems';
  }

  @override
  String get server_address => 'Endereço do servidor';

  @override
  String server_emptyField(String label) {
    return 'Insira seu $label';
  }

  @override
  String get server_invalidUrl => 'Endereço inválido';

  @override
  String get server_unknownServerType => 'Tipo de servidor desconhecido';

  @override
  String get server_unreachable => 'Servidor inacessível';

  @override
  String get server_versionNotSupported => 'Versão do servidor não suportado';

  @override
  String get session_copiedToClipboard =>
      'Copiado para a área de transferência';

  @override
  String get session_invalidToken => 'inválido';

  @override
  String get session_logoutDialogConfirm => 'Sair';

  @override
  String get session_logoutDialogMessage =>
      'Você precisará efetuar login novamente.';

  @override
  String get session_logoutDialogTitle => 'Sair da sessão';

  @override
  String get session_logoutSession => 'Sair da sessão';

  @override
  String get session_fieldAccessToken => 'Token de acesso';

  @override
  String get session_fieldApiToken => 'Token de API';

  @override
  String get session_fieldLastServerSync => 'Última sincronização do servidor';

  @override
  String get session_fieldTokenExpiration => 'Expiração do token';

  @override
  String get session_forceTokenResfresh => 'Forçar atualização do token';

  @override
  String get session_neverSynced => 'Nunca';

  @override
  String get session_renewDialogMessage =>
      'O servidor recusa o token de sessão atual. Você precisará efetuar login novamente para retomar a sincronização.';

  @override
  String get session_renewDialogTitle => 'Renovar sessão';

  @override
  String get session_title => 'Detalhes da sessão';

  @override
  String get settings_bugReportLink => 'Reportar um bug';

  @override
  String get settings_clearCacheMessage =>
      'O cache local será excluído e recuperado novamente do servidor.';

  @override
  String get settings_itemAppearance => 'Aparência';

  @override
  String get settings_itemAbout => 'Sobre';

  @override
  String get settings_itemAppBadge => 'Mostrar emblema não lido';

  @override
  String get settings_itemClearCache => 'Limpar cache';

  @override
  String get settings_itemLogConsole => 'Console de Logs';

  @override
  String get settings_itemOpenDeeplink => 'Abra um link profundo';

  @override
  String get settings_itemLanguage => 'Linguagem';

  @override
  String get settings_helpToTranslate => 'Ajuda para traduzir';

  @override
  String get settings_savedArticleTag => 'Adicionar uma tag aos artigos salvos';

  @override
  String get settings_savedArticleTagLabel => 'Etiqueta para artigos salvos';

  @override
  String get settings_itemSessionDetails => 'Detalhes da sessão';

  @override
  String get settings_title => 'Configurações';

  @override
  String get settings_nativeArticleRenderer => 'Renderizador de artigo nativo';

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
      other: '$countString actions',
      one: '1 action',
    );
    return '$_temp0';
  }
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get g_article => 'Artigo';

  @override
  String get g_check => 'Verificar';

  @override
  String get g_checking => 'Verificando…';

  @override
  String get g_delete => 'Suprimir';

  @override
  String get g_saveLink => 'Guardar link';

  @override
  String get g_search => 'Pesquisar';

  @override
  String get g_server => 'Servidor';

  @override
  String get g_settings => 'Configurações';

  @override
  String get g_share => 'Compartilhar';

  @override
  String get g_sourceCode => 'Código-fonte';

  @override
  String get g_synchronize => 'Sincronizar';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Tag';

  @override
  String get g_version => 'Versão';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString dias',
      one: '1 dia',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'em $duration';
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
      other: ' $nString horas',
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
      other: ' $nString minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration atrás';
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
      other: ' $nString segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Adicionar tags';

  @override
  String get article_archive => 'Arquivar este artigo';

  @override
  String get article_browseOriginal => 'Navegue pelo original';

  @override
  String get article_delete => 'Suprimir este artigo';

  @override
  String get article_details => 'Mais informações';

  @override
  String get article_noContentFetched => 'Nenhum conteúdo buscado';

  @override
  String get article_notFound => 'Artigo não encontrado';

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
  String get article_refetchContent => 'Recapturar o conteúdo';

  @override
  String get article_readingSettings =>
      'A ação para abrir a folha de definições de leitura';

  @override
  String get article_share => 'Partilhar este artigo';

  @override
  String get article_unarchive => 'Desarquivar este artigo';

  @override
  String get articlefields_readingTime => 'Tempo de leitura';

  @override
  String get articlefields_tags => 'Etiquetas';

  @override
  String get articlefields_title => 'Título';

  @override
  String get articlefields_website => 'Sitio Web';

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
      other: '$countString domains',
      one: '1 domain',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Favorito';

  @override
  String get filters_articleState => 'Estado';

  @override
  String get filters_articleStateUnread => 'Por ler';

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
      other: '$countString tags',
      one: '1 tag',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Pesquisar nos artigos';

  @override
  String get filters_searchMode => 'Modo de pesquisa';

  @override
  String get filters_searchModeAll => 'Todos os campos';

  @override
  String get filters_searchModeContent => 'Conteúdo';

  @override
  String get filters_searchModeTitle => 'Título';

  @override
  String get logconsole_title => 'Console de Logs';

  @override
  String get listing_noArticles => 'Nenhum artigo';

  @override
  String get listing_articlesAll => 'Todos os artigos';

  @override
  String get listing_articlesArchived => 'Artigos arquivados';

  @override
  String get listing_articlesUnread => 'Artigos não lidos';

  @override
  String get login_acceptSelfSigned => 'Aceitar certificados auto-assinados';

  @override
  String get login_actionLogin => 'Conecte-se';

  @override
  String get login_existingSessionDialogConfirm => 'Sair';

  @override
  String get login_existingSessionDialogMessage =>
      'Deseja sair da sessão atual e abrir uma nova?';

  @override
  String get login_existingSessionDialogTitle =>
      'Uma sessão está ativa no momento';

  @override
  String get login_fieldClientId => 'ID do cliente';

  @override
  String get login_fieldClientSecret => 'Segredo do cliente';

  @override
  String get login_fieldPassword => 'Palavra-passe';

  @override
  String get login_fieldUsername => 'Nome de utilizador';

  @override
  String get login_openLogConsole => 'Abra o console de log';

  @override
  String get readingsettings_fontFamily => 'Família de fontes';

  @override
  String get readingsettings_fontSize => 'Tamanho da fonte';

  @override
  String get readdingsettings_textFormatting => 'Formatação de texto';

  @override
  String get save_confirmationTitle => 'Artigo gravado!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Esta URL não parece uma. Gravar mesmo assim?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Grave-o';

  @override
  String get save_dubiousUrlTitle => 'URL duvidosa';

  @override
  String get save_noUrl => 'Nenhuma URL fornecida';

  @override
  String get save_title => 'Gravar artigo';

  @override
  String get save_viewArticle => 'Ver artigo';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Selecione $numberOfItems';
  }

  @override
  String get server_address => 'Endereço do servidor';

  @override
  String server_emptyField(String label) {
    return 'Insira seu $label';
  }

  @override
  String get server_invalidUrl => 'Endereço inválido';

  @override
  String get server_unreachable => 'Servidor inacessível';

  @override
  String get session_copiedToClipboard =>
      'Copiado para a área de transferência';

  @override
  String get session_invalidToken => 'inválido';

  @override
  String get session_logoutDialogConfirm => 'Sair';

  @override
  String get session_logoutDialogMessage =>
      'Precisará efetuar login novamente.';

  @override
  String get session_logoutDialogTitle => 'Sair da sessão';

  @override
  String get session_logoutSession => 'Sair da sessão';

  @override
  String get session_fieldAccessToken => 'Token de acesso';

  @override
  String get session_fieldApiToken => 'Token de API';

  @override
  String get session_fieldLastServerSync => 'Última sincronização do servidor';

  @override
  String get session_fieldTokenExpiration => 'Expiração do token';

  @override
  String get session_forceTokenResfresh => 'Forçar atualização do token';

  @override
  String get session_neverSynced => 'Nunca';

  @override
  String get session_renewDialogMessage =>
      'O servidor recusa o token de sessão atual. Precisará efetuar login novamente para retomar a sincronização.';

  @override
  String get session_renewDialogTitle => 'Renovar sessão';

  @override
  String get session_title => 'Pormenores da sessão';

  @override
  String get settings_bugReportLink => 'Reportar um bug';

  @override
  String get settings_clearCacheMessage =>
      'O cache local será apagado e recuperado novamente do servidor.';

  @override
  String get settings_itemAppearance => 'Aparência';

  @override
  String get settings_itemAbout => 'Sobre';

  @override
  String get settings_itemAppBadge => 'Mostrar emblema não lido';

  @override
  String get settings_itemClearCache => 'Limpar cache';

  @override
  String get settings_itemLogConsole => 'Console de Logs';

  @override
  String get settings_itemOpenDeeplink => 'Abra uma ligação profunda';

  @override
  String get settings_itemLanguage => 'Linguagem';

  @override
  String get settings_helpToTranslate => 'Ajuda para traduzir';

  @override
  String get settings_savedArticleTag =>
      'Adicionar uma tag aos artigos gravados';

  @override
  String get settings_savedArticleTagLabel => 'Etiqueta para artigos gravados';

  @override
  String get settings_itemSessionDetails => 'Pormenores da sessão';

  @override
  String get settings_title => 'Configurações';

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
      other: '$countString actions',
      one: '1 action',
    );
    return '$_temp0';
  }
}
