#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

# MainCtrl Controller
### @ngInject ###
MainCtrl = (MessageService, FilterService) ->
    vm = @

    vm.mode = 'view'
    vm.searchText = ''
    vm.currentEmail = null
    vm.filter = 'inbox'
    vm.filters = FilterService.getFilters()

    vm.getMessages = () ->
        return MessageService.getMessages()

    vm.messages = vm.getMessages()

    vm.applyFilter = (filter = 'inbox') ->
        vm.filter = FilterService.applyFilter(filter)

    vm.changeMode = (mode = 'view') ->
        vm.mode = mode

    vm.showEmail = (email) ->
        vm.mode = 'read'
        vm.currentEmail = email

    return

angular.module('angularMail').controller 'MainCtrl', MainCtrl

# -----------------------------------------------------------------------------

# MessageService Factory
### @ngInject ###
MessageService = () ->
    MessageService = {
        getMessages: () ->
            return messages
    }

    return MessageService

angular.module('angularMail').factory 'MessageService', MessageService

# -----------------------------------------------------------------------------

# FilterService Factory
### @ngInject ###
FilterService = () ->
    FilterService = {
        getFilters: () -> filters
        applyFilter: (filter) ->
            return filter
    }

    return FilterService

angular.module('angularMail').factory 'FilterService', FilterService

# -----------------------------------------------------------------------------

# TypeFilter Filter
### @ngInject ###
TypeFilter = () ->
    (items, filter) ->
        if filter == 'all'
            return (item for item in items when not item.is_sent || not item.is_draft)

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

# SearchFilter Filter
### @ngInject ###
SearchFilter = () ->
    (items, term) ->
        if term == ''
            return items

        filtered = []

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

# -----------------------------------------------------------------------------

# SearchBar Directive
### @ngInject ###
SearchBar = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            search: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/search_bar.html'
    }

    return directive

angular.module('angularMail').directive 'searchBar', SearchBar

# -----------------------------------------------------------------------------

# MailBox Directive
### @ngInject ###
MailBox = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            changeMode: '='
            messages: '='
            filters: '='
            search: '@'
            applyFilter: '='
            showEmail: '='
            typeFilter: '@'
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/mailbox.html'
    }

    return directive

angular.module('angularMail').directive 'mailbox', MailBox

# -----------------------------------------------------------------------------

# ViewEmail Directive
### @ngInject ###
ViewEmail = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            changeMode: '='
            currentEmail: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/view_email.html'
    }

    return directive

angular.module('angularMail').directive 'viewEmail', ViewEmail

# -----------------------------------------------------------------------------

# SendForm Directive
### @ngInject ###
SendForm = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            changeMode: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/send_form.html'
    }

    return directive

angular.module('angularMail').directive 'sendForm', SendForm
