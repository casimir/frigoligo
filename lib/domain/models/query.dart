import 'package:equatable/equatable.dart';

class Query with EquatableMixin {
  const Query({
    this.text = '',
    this.textMode = SearchTextMode.all,
    this.state = StateFilter.all,
    this.onlyStarred = false,
    this.tags = const [],
    this.domains = const [],
  });

  final String text;
  final SearchTextMode textMode;
  final StateFilter state;
  final bool onlyStarred;
  final List<String> tags;
  final List<String> domains;

  @override
  List<Object?> get props => [
    text,
    textMode,
    state,
    onlyStarred,
    tags,
    domains,
  ];

  Query copyWith({
    String? text,
    SearchTextMode? textMode,
    StateFilter? state,
    bool? onlyStarred,
    List<String>? tags,
    List<String>? domains,
  }) => Query(
    text: text ?? this.text,
    textMode: textMode ?? this.textMode,
    state: state ?? this.state,
    onlyStarred: onlyStarred ?? this.onlyStarred,
    tags: tags ?? this.tags,
    domains: domains ?? this.domains,
  );
}

enum SearchTextMode { all, title, content }

enum StateFilter { all, unread, archived }
