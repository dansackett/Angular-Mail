#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

# @ngInject
# MainCtrl Controller
MainCtrl = () ->
    vm = @

    vm.view = 'view'
    vm.changeView = (view = 'view') ->
        vm.view = view

    return

angular.module('angularMail').controller 'MainCtrl', MainCtrl

# -----------------------------------------------------------------------------

# @ngInject
# SearchBar Directive
SearchBar = () ->
    search_bar = {
        restrict: 'E'
        scope: {
            view: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/search_bar.html'
    }

    return search_bar

angular.module('angularMail').directive 'searchBar', SearchBar

# -----------------------------------------------------------------------------

# @ngInject
# MailBox Directive
MailBox = () ->
    mailbox = {
        restrict: 'E'
        scope: {
            view: '='
            changeView: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/mailbox.html'
    }

    return mailbox

angular.module('angularMail').directive 'mailbox', MailBox

# -----------------------------------------------------------------------------

# @ngInject
# Filters Directive
Filters = () ->
    filters = {
        restrict: 'E'
        scope: {
            view: '='
            changeView: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/filters.html'
    }

    return filters

angular.module('angularMail').directive 'filters', Filters

# -----------------------------------------------------------------------------

# @ngInject
# MessageList Directive
MessageList = () ->
    message_list = {
        restrict: 'E'
        scope: {
            view: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/message_list.html'
    }

    return message_list

angular.module('angularMail').directive 'messageList', MessageList

# -----------------------------------------------------------------------------

# @ngInject
# ViewEmail Directive
ViewEmail = () ->
    view_email = {
        restrict: 'E'
        scope: {
            view: '='
            changeView: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/view_email.html'
    }

    return view_email

angular.module('angularMail').directive 'viewEmail', ViewEmail

# -----------------------------------------------------------------------------

# @ngInject
# SendForm Directive
SendForm = () ->
    send_form = {
        restrict: 'E'
        scope: {
            view: '='
            changeView: '='
        }
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/send_form.html'
    }

    return send_form

angular.module('angularMail').directive 'sendForm', SendForm
