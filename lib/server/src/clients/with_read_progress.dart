class ReadProgressUpdate {
  const ReadProgressUpdate({
    required this.articleId,
    required this.progress,
    required this.updatedAt,
  });

  final int articleId;
  final double progress;
  final DateTime updatedAt;
}

mixin WithReadProgress {
  Future<List<ReadProgressUpdate>> getReadProgress(DateTime since);
  Future<void> putReadProgress(List<ReadProgressUpdate> updates);
}
