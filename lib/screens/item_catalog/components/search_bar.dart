import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static const historyLength = 5;
  List<String> _searchHistory = <String>[
    'ICE',
    'S-Bahn',
    'TGV',
    'RE-Express',
  ];

  FloatingSearchBarController? _controller;
  List<String> _filteredSearchHistory = <String>[];
  String? _selectedTerm;

  List<String> filterSearchTerms({String? filter}) {
    if (filter == null || filter.isEmpty) {
      return _searchHistory.reversed.toList();
    }
    return _searchHistory.reversed.where((String term) => term.toLowerCase().contains(filter.toLowerCase())).toList();
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeAt(0);
    }
    setState(() {
      _filteredSearchHistory = filterSearchTerms(filter: null);
    });
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    setState(() {
      _filteredSearchHistory = filterSearchTerms(filter: null);
    });
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState() {
    super.initState();
    _controller = new FloatingSearchBarController();
    _filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: _controller,
      body: FloatingSearchBarScrollNotifier(
        child: SearchResultsListView(
          searchTerm: _selectedTerm,
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        _selectedTerm ?? 'Search',
        style: Theme.of(context).textTheme.headline6,
      ),
      hint: 'Search for a station',
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        setState(() {
          _filteredSearchHistory = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTerm(query);
          _selectedTerm = query;
        });
        _controller!.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (_filteredSearchHistory.isEmpty && _controller!.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (_filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(_controller!.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerm(_controller!.query);
                        _selectedTerm = _controller!.query;
                      });
                      _controller!.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                putSearchTermFirst(term);
                                _selectedTerm = term;
                              });
                              _controller!.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String? searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null || searchTerm!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Start searching',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    //final fsb = FloatingSearchBar.of(context);

    return ListView(
      //padding: EdgeInsets.only(top: fsb!.widget.height + fsb.widget.margins!.vertical),
      children: List.generate(
        4,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
