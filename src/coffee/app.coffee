#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

# @ngInject
# MainCtrl Controller
MainCtrl = (MessageService, FilterService) ->
    vm = @

    vm.mode = 'view'
    vm.searchText = ''
    vm.filter = 'inbox'
    vm.filters = FilterService.getFilters()

    vm.getMessages = () ->
        return MessageService.getMessages()

    vm.messages = vm.getMessages()

    vm.applyFilter = (filter = 'inbox') ->
        vm.filter = FilterService.applyFilter(filter)

    vm.changeMode = (mode = 'view') ->
        vm.mode = mode

    return

angular.module('angularMail').controller 'MainCtrl', MainCtrl

# -----------------------------------------------------------------------------

# @ngInject
# MessageService Factory
MessageService = () ->
    MessageService = {
        getMessages: () ->
            return messages
    }

    return MessageService

angular.module('angularMail').factory 'MessageService', MessageService

# -----------------------------------------------------------------------------

# @ngInject
# FilterService Factory
FilterService = () ->
    FilterService = {
        getFilters: () -> filters
        applyFilter: (filter) ->
            return filter
    }

    return FilterService

angular.module('angularMail').factory 'FilterService', FilterService

# -----------------------------------------------------------------------------

# @ngInject
# TypeFilter Filter
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

        filtered

angular.module('angularMail').filter 'TypeFilter', TypeFilter

# -----------------------------------------------------------------------------

# @ngInject
# SearchBar Directive
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

# @ngInject
# MailBox Directive
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
            typeFilter: '@'
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/mailbox.html'
    }

    return directive

angular.module('angularMail').directive 'mailbox', MailBox

# -----------------------------------------------------------------------------

# @ngInject
# Filters Directive
Filters = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            changeMode: '='
            filters: '='
            applyFilter: '='
            typeFilter: '@'
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/filters.html'
    }

    return directive

angular.module('angularMail').directive 'filters', Filters

# -----------------------------------------------------------------------------

# @ngInject
# MessageList Directive
MessageList = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            messages: '='
            search: '@'
            typeFilter: '@'
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/message_list.html'
    }

    return directive

angular.module('angularMail').directive 'messageList', MessageList

# -----------------------------------------------------------------------------

# @ngInject
# ViewEmail Directive
ViewEmail = () ->
    directive = {
        restrict: 'E'
        scope: {
            mode: '='
            changeMode: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/view_email.html'
    }

    return directive

angular.module('angularMail').directive 'viewEmail', ViewEmail

# -----------------------------------------------------------------------------

# @ngInject
# SendForm Directive
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
