// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get g_article => 'Articolo';

  @override
  String get g_check => 'Verifica';

  @override
  String get g_checking => 'Verificando…';

  @override
  String get g_delete => 'Elimina';

  @override
  String get g_saveLink => 'Salva link';

  @override
  String get g_search => 'Cerca';

  @override
  String get g_server => 'Server';

  @override
  String get g_settings => 'Impostazioni';

  @override
  String get g_share => 'Condividi';

  @override
  String get g_sourceCode => 'Codice sorgente';

  @override
  String get g_synchronize => 'Sincronizza';

  @override
  String get g_system => 'Sistema';

  @override
  String get g_tag => 'Etichetta';

  @override
  String get g_version => 'Versione';

  @override
  String humanize_days(int n) {
    final intl.NumberFormat nNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String nString = nNumberFormat.format(n);

    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nString giorni',
      one: '1 giorno',
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
      other: '$nString ore',
      one: '1 ora',
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
      other: '$nString minuti',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return '$duration fa';
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
      other: '$nString secondi',
      one: '1 secondo',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Aggiungi etichette';

  @override
  String get article_archive => 'Archivia questo articolo';

  @override
  String get article_browseOriginal => 'Visualizza l\'originale';

  @override
  String get article_delete => 'Elimina questo articolo';

  @override
  String get article_details => 'Ulteriori informazioni';

  @override
  String get article_noContentFetched => 'Nessun contenuto recuperato';

  @override
  String get article_notFound => 'Articolo non trovato';

  @override
  String get article_openInBrowser => 'Apri nel browser';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Recupera nuovamente il contenuto';

  @override
  String get article_readingSettings => 'Impostazioni testo';

  @override
  String get article_share => 'Condividi questo articolo';

  @override
  String get article_star => 'Aggiungi ai preferiti questo articolo';

  @override
  String get article_unarchive => 'Rimuovi dall\'archivio questo articolo';

  @override
  String get article_unstar => 'Rimuovi dai preferiti questo articolo';

  @override
  String get articlefields_readingTime => 'Tempo di lettura';

  @override
  String get articlefields_tags => 'Etichette';

  @override
  String get articlefields_title => 'Titolo';

  @override
  String get articlefields_website => 'Sito web';

  @override
  String get filters_articleDomains => 'Domini';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domini',
      one: '1 dominio',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Preferiti';

  @override
  String get filters_articleState => 'Stato';

  @override
  String get filters_articleStateUnread => 'Non letto';

  @override
  String get filters_articleStateArchived => 'Archiviato';

  @override
  String get filters_articleStateAll => 'Tutti gli stati';

  @override
  String get filters_articleTags => 'Etichette';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString etichette',
      one: '1 etichetta',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Cerca nell\'articolo';

  @override
  String get filters_searchMode => 'Modalità di ricerca';

  @override
  String get filters_searchModeAll => 'Tutti i campi';

  @override
  String get filters_searchModeContent => 'Contenuto';

  @override
  String get filters_searchModeTitle => 'Titolo';

  @override
  String get logconsole_title => 'Registro della console';

  @override
  String get listing_noArticles => 'Nessun articolo';

  @override
  String get listing_articlesAll => 'Tutti gli articoli';

  @override
  String get listing_articlesArchived => 'Articoli archiviati';

  @override
  String get listing_articlesUnread => 'Articoli non letti';

  @override
  String get login_acceptSelfSigned => 'Accetta certificato auto-firmati';

  @override
  String get login_actionLogin => 'Accedi';

  @override
  String get login_existingSessionDialogConfirm => 'Esci';

  @override
  String get login_existingSessionDialogMessage =>
      'Vuoi uscire dalla sessione attuale e aprirne una nuova?';

  @override
  String get login_existingSessionDialogTitle =>
      'Una sessione è attualmente attiva';

  @override
  String get login_fieldClientId => 'ID cliente';

  @override
  String get login_fieldClientSecret => 'Chiave segreta';

  @override
  String get login_fieldPassword => 'Password';

  @override
  String get login_fieldUsername => 'Nome utente';

  @override
  String get login_openLogConsole => 'Apri il registro della console';

  @override
  String get readingsettings_fontFamily => 'Famiglia di caratteri';

  @override
  String get readingsettings_fontSize => 'Dimensione dei caratteri';

  @override
  String get readdingsettings_textFormatting => 'Formattazione del testo';

  @override
  String get readingsettings_title => 'Impostazioni testo';

  @override
  String get save_confirmationTitle => 'Articolo salvato!';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Questo URL non sembra valido. Vuoi salvarlo comunque?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Salvalo';

  @override
  String get save_dubiousUrlTitle => 'URL sospetto';

  @override
  String get save_noUrl => 'Nessun URL fornito';

  @override
  String get save_title => 'Salva articolo';

  @override
  String get save_viewArticle => 'Visualizza articolo';

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Seleziona $numberOfItems';
  }

  @override
  String get server_address => 'Indirizzo server';

  @override
  String get server_apiError => 'Risposta API non valida';

  @override
  String server_emptyField(String label) {
    return 'Inserisci $label';
  }

  @override
  String get server_invalidUrl => 'Indirizzo non valido';

  @override
  String get server_unreachable => 'Server non raggiungibile';

  @override
  String get session_copiedToClipboard => 'Copiato negli appunti';

  @override
  String get session_invalidToken => 'non valido';

  @override
  String get session_logoutDialogConfirm => 'Esci';

  @override
  String get session_logoutDialogMessage => 'Dovrai accedere nuovamente.';

  @override
  String get session_logoutDialogTitle => 'Esci dalla sessione';

  @override
  String get session_logoutSession => 'Esci dalla sessione';

  @override
  String get session_fieldAccessToken => 'Token di accesso';

  @override
  String get session_fieldApiToken => 'Token API';

  @override
  String get session_fieldLastServerSync =>
      'Ultima sincronizzazione del server';

  @override
  String get session_fieldTokenExpiration => 'Scadenza del token';

  @override
  String get session_forceTokenResfresh => 'Forza aggiornamento token';

  @override
  String get session_neverSynced => 'mai';

  @override
  String get session_renewDialogMessage =>
      'Il server non accetta il token della sessione attuale. Devi accedere nuovamente per riprendere la sincronizzazione.';

  @override
  String get session_renewDialogTitle => 'Rinnova sessione';

  @override
  String get session_title => 'Dettagli sessione';

  @override
  String get settings_bugReportLink => 'Segnala un bug';

  @override
  String get settings_clearCacheMessage =>
      'La cache locale verrà eliminata e recuperata nuovamente dal server.';

  @override
  String get settings_itemAppearance => 'Aspetto';

  @override
  String get settings_itemAbout => 'Informazioni su';

  @override
  String get settings_itemAppBadge => 'Mostra badge non letto';

  @override
  String get settings_itemClearCache => 'Pulisci cache';

  @override
  String get settings_itemLogConsole => 'Registro della console';

  @override
  String get settings_itemOpenDeeplink => 'Apri un link profondo';

  @override
  String get settings_itemLanguage => 'Lingua';

  @override
  String get settings_helpToTranslate => 'Aiuta a tradurre';

  @override
  String get settings_savedArticleTag =>
      'Aggiungi un\'etichetta agli articoli salvati';

  @override
  String get settings_savedArticleTagLabel =>
      'Etichetta per gli articoli salvati';

  @override
  String get settings_itemSessionDetails => 'Dettagli sessione';

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get settings_nativeArticleRenderer => 'Native article renderer';

  @override
  String get settings_valueThemeDark => 'Scuro';

  @override
  String get settings_valueThemeLight => 'Chiaro';

  @override
  String syncer_pendingActions(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString azioni',
      one: '1 azione',
    );
    return '$_temp0';
  }
}
