###
# Filters
###

# -----------------------------------------------------------------------------

###
# TypeFilter Filter
# @ngInject
###
TypeFilter = () ->
    (items, filter) ->
        if filter == 'all'
            return (item for item in items when not item.is_sent or not item.is_draft)

        filtered = []

        angular.forEach items, (item, key) ->
            if filter == 'inbox' && item.is_in_inbox
                filtered.push item
            else if filter == 'starred' && item.is_starred
                filtered.push item
            else if filter == 'spam' && item.is_spam
                filtered.push item
            else if filter == 'sent' && item.is_sent
                filtered.push item
            else if filter == 'draft' && item.is_draft
                filtered.push item
            else if filter == 'archived' && item.is_archived
                filtered.push item
            else if filter == 'deleted' && item.is_deleted
                filtered.push item

        return filtered

angular.module('angularMail').filter 'TypeFilter', TypeFilter

# -----------------------------------------------------------------------------

###
# SearchFilter Filter
# @ngInject
###
SearchFilter = () ->
    (items, term) ->
        if term == ''
            return items

        filtered = []

        # Match both the from and subject fields
        angular.forEach items, (item, key) ->
            term = term.toLowerCase()
            from = item.from.toLowerCase()
            subject = item.subject.toLowerCase()

            if ~from.indexOf term
                filtered.push item
            else if ~subject.indexOf term
                filtered.push item

        return filtered

angular.module('angularMail').filter 'SearchFilter', SearchFilter
