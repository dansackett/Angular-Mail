
/*
 * Filters
 */

/*
 * TypeFilter Filter
 * @ngInject
 */
var SearchFilter, TypeFilter;

TypeFilter = function() {
  return function(items, filter) {
    var filtered, item;
    if (filter === 'all') {
      return (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = items.length; _i < _len; _i++) {
          item = items[_i];
          if (!item.is_sent || !item.is_draft) {
            _results.push(item);
          }
        }
        return _results;
      })();
    }
    filtered = [];
    angular.forEach(items, function(item, key) {
      if (filter === 'inbox' && item.is_in_inbox) {
        return filtered.push(item);
      } else if (filter === 'starred' && item.is_starred) {
        return filtered.push(item);
      } else if (filter === 'spam' && item.is_spam) {
        return filtered.push(item);
      } else if (filter === 'sent' && item.is_sent) {
        return filtered.push(item);
      } else if (filter === 'draft' && item.is_draft) {
        return filtered.push(item);
      } else if (filter === 'archived' && item.is_archived) {
        return filtered.push(item);
      } else if (filter === 'deleted' && item.is_deleted) {
        return filtered.push(item);
      }
    });
    return filtered;
  };
};

angular.module('angularMail').filter('TypeFilter', TypeFilter);


/*
 * SearchFilter Filter
 * @ngInject
 */

SearchFilter = function() {
  return function(items, term) {
    var filtered;
    if (term === '') {
      return items;
    }
    filtered = [];
    angular.forEach(items, function(item, key) {
      var from, subject;
      term = term.toLowerCase();
      from = item.from.toLowerCase();
      subject = item.subject.toLowerCase();
      if (~from.indexOf(term)) {
        return filtered.push(item);
      } else if (~subject.indexOf(term)) {
        return filtered.push(item);
      }
    });
    return filtered;
  };
};

angular.module('angularMail').filter('SearchFilter', SearchFilter);
