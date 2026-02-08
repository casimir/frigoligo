// GENERATED FILE, DO NOT EDIT MANUALLY
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get g_article => 'Article';

  @override
  String get g_check => 'Vérifier';

  @override
  String get g_checking => 'Vérification…';

  @override
  String get g_delete => 'Supprimer';

  @override
  String get g_saveLink => 'Enregistrer un lien';

  @override
  String get g_search => 'Rechercher';

  @override
  String get g_server => 'Serveur';

  @override
  String get g_settings => 'Paramètres';

  @override
  String get g_share => 'Partager';

  @override
  String get g_sourceCode => 'Code source';

  @override
  String get g_synchronize => 'Synchroniser';

  @override
  String get g_system => 'Système';

  @override
  String get g_tag => 'Label';

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
      other: '$nString jours',
      one: '1 jour',
      zero: '0 jour',
    );
    return '$_temp0';
  }

  @override
  String humanize_future(String duration) {
    return 'dans $duration';
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
      other: '$nString heures',
      one: '1 heure',
      zero: '0 heure',
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
      zero: '0 minute',
    );
    return '$_temp0';
  }

  @override
  String humanize_past(String duration) {
    return 'il y a $duration';
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
      other: '$nString secondes',
      one: '1 seconde',
      zero: '0 seconde',
    );
    return '$_temp0';
  }

  @override
  String get article_addTags => 'Ajouter des labels';

  @override
  String get article_archive => 'Archiver l\'article';

  @override
  String get article_browseOriginal => 'Ouvrir l\'original';

  @override
  String get article_delete => 'Supprimer l\'article';

  @override
  String get article_details => 'Plus d\'informations';

  @override
  String get article_noContentFetched => 'Aucun contenu récupéré';

  @override
  String get article_notFound => 'Article introuvable';

  @override
  String get article_openInBrowser => 'Ouvrir dans le navigateur';

  @override
  String article_readingTime(int minutes) {
    final intl.NumberFormat minutesNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String minutesString = minutesNumberFormat.format(minutes);

    return '$minutesString min';
  }

  @override
  String get article_refetchContent => 'Recharger le contenu';

  @override
  String get article_readingSettings => 'Mise en page';

  @override
  String get article_share => 'Partager l\'article';

  @override
  String get article_star => 'Ajouter aux favoris';

  @override
  String get article_unarchive => 'Désarchiver l\'article';

  @override
  String get article_unstar => 'Retirer l\'article des favoris';

  @override
  String get articlefields_readingTime => 'Temps de lecture';

  @override
  String get articlefields_tags => 'Labels';

  @override
  String get articlefields_title => 'Titre';

  @override
  String get articlefields_website => 'Site web';

  @override
  String get filters_articleDomains => 'Domaines';

  @override
  String filters_articleDomainsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString domaines',
      one: '1 domaine',
      zero: 'Aucun domaine',
    );
    return '$_temp0';
  }

  @override
  String get filters_articleFavoriteStarred => 'Favori';

  @override
  String get filters_articleState => 'Statut';

  @override
  String get filters_articleStateUnread => 'Non-lu';

  @override
  String get filters_articleStateArchived => 'Archivé';

  @override
  String get filters_articleStateAll => 'Tous les statuts';

  @override
  String get filters_articleTags => 'Labels';

  @override
  String filters_articleTagsCount(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString labels',
      one: '1 label',
      zero: 'Aucun label',
    );
    return '$_temp0';
  }

  @override
  String get filters_searchbarHint => 'Rechercher dans les articles';

  @override
  String get filters_searchMode => 'Mode de recherche';

  @override
  String get filters_searchModeAll => 'Tous les champs';

  @override
  String get filters_searchModeContent => 'Contenu';

  @override
  String get filters_searchModeTitle => 'Titre';

  @override
  String get logconsole_title => 'Console de journalisation';

  @override
  String get logconsole_clear_logs => 'Effacer les journaux';

  @override
  String get logconsole_export_title => 'Exporter comme fichier';

  @override
  String logconsole_export_current_session(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString lignes',
      one: '1 ligne',
    );
    return 'Session en cours ($_temp0)';
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
      other: '$countString lignes',
      one: '1 ligne',
    );
    return 'Toutes les lignes($_temp0)';
  }

  @override
  String get listing_noArticles => 'Aucun article';

  @override
  String get listing_articlesAll => 'Tous les articles';

  @override
  String get listing_articlesArchived => 'Articles archivés';

  @override
  String get listing_articlesUnread => 'Articles non-lus';

  @override
  String get login_acceptSelfSigned => 'Autoriser les certificats auto-signés';

  @override
  String get login_actionLogin => 'Connexion';

  @override
  String get login_demoMode => 'Try in demo mode';

  @override
  String get login_existingSessionDialogConfirm => 'Déconnexion';

  @override
  String get login_existingSessionDialogMessage =>
      'Voulez-vous vous déconnecter de la session courante et en ouvrir une nouvelle ?';

  @override
  String get login_existingSessionDialogTitle => 'Une session est active';

  @override
  String get login_fieldClientId => 'ID client';

  @override
  String get login_fieldClientSecret => 'Clef secrète';

  @override
  String get login_fieldPassword => 'Mot de passe';

  @override
  String get login_fieldUsername => 'Nom d\'utilisateur';

  @override
  String get login_openLogConsole => 'Ouvrir la console de journalisation';

  @override
  String get readingsettings_fontFamily => 'Famille de police';

  @override
  String get readingsettings_fontSize => 'Taille de police';

  @override
  String get readdingsettings_textFormatting => 'Formatage du texte';

  @override
  String get readingsettings_title => 'Mise en page';

  @override
  String get save_confirmationTitle => 'Article sauvegardé !';

  @override
  String save_dubiousUrlMessage(String url) {
    return 'Cette URL à l\'air invalide. Sauvegarder quand même ?\n$url';
  }

  @override
  String get save_dubiousUrlConfirm => 'Sauvegarder';

  @override
  String get save_dubiousUrlTitle => 'URL anormale';

  @override
  String get save_noUrl => 'Aucune URL fournie';

  @override
  String get save_title => 'Sauvegarder l\'article';

  @override
  String get save_viewArticle => 'Voir l\'article';

  @override
  String get save_localModeError =>
      'A server connection is required to save new articles.';

  @override
  String save_malformedUrlError(String url) {
    return 'Malformed URL: $url';
  }

  @override
  String selector_selectbuttonlabel(String numberOfItems) {
    return 'Sélectionner $numberOfItems';
  }

  @override
  String get server_address => 'Adresse du serveur';

  @override
  String server_emptyField(String label) {
    return 'Entrez votre $label';
  }

  @override
  String get server_invalidUrl => 'Adresse invalide';

  @override
  String get server_unknownServerType => 'Type de serveur inconnu';

  @override
  String get server_unreachable => 'Serveur injoignable';

  @override
  String get server_versionNotSupported => 'Version du serveur non supportée';

  @override
  String get session_copiedToClipboard => 'Copié dans le presse-papier';

  @override
  String get session_invalidToken => 'invalide';

  @override
  String get session_logoutDialogConfirm => 'Déconnexion';

  @override
  String get session_logoutDialogMessage => 'Vous devrez vous reconnecter.';

  @override
  String get session_logoutDialogTitle => 'Déconnecter la session';

  @override
  String get session_logoutSession => 'Déconnecter la session';

  @override
  String get session_fieldAccessToken => 'Jeton d\'accès';

  @override
  String get session_fieldApiToken => 'Jeton d’API';

  @override
  String get session_fieldLastServerSync =>
      'Dernière synchronisation avec le serveur';

  @override
  String get session_fieldTokenExpiration => 'Expiration du token';

  @override
  String get session_forceTokenResfresh => 'Rafraîchir le jeton';

  @override
  String get session_neverSynced => 'jamais';

  @override
  String get session_renewDialogMessage =>
      'Le serveur refuse le jeton de session actuel. Vous devrez vous connecter à nouveau pour reprendre la synchronisation.';

  @override
  String get session_renewDialogTitle => 'Renouveler la session';

  @override
  String get session_title => 'Détails de la session';

  @override
  String get settings_bugReportLink => 'Signaler un bug';

  @override
  String get settings_clearCacheMessage =>
      'Le cache local sera supprimé et récupéré à nouveau depuis le serveur.';

  @override
  String get settings_itemAppearance => 'Apparence';

  @override
  String get settings_itemAbout => 'À propos';

  @override
  String get settings_itemAppBadge => 'Afficher le badge « non-lus »';

  @override
  String get settings_itemClearCache => 'Nettoyer le cache';

  @override
  String get settings_itemLogConsole => 'Console de journalisation';

  @override
  String get settings_itemOpenDeeplink => 'Ouvrir un lien profond';

  @override
  String get settings_itemLanguage => 'Langue';

  @override
  String get settings_helpToTranslate => 'Aider à traduire';

  @override
  String get settings_savedArticleTag => 'Ajouter un label en sauvegardant';

  @override
  String get settings_savedArticleTagLabel => 'Label automatique la sauvegarde';

  @override
  String get settings_itemSessionDetails => 'Détails de la session';

  @override
  String get settings_title => 'Réglages';

  @override
  String get settings_nativeArticleRenderer =>
      'Moteur de rendu d\'article natif';

  @override
  String get settings_valueThemeDark => 'Sombre';

  @override
  String get settings_valueThemeLight => 'Clair';

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
