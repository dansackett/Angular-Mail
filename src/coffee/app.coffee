#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

# @ngInject
# MainCtrl Controller
MainCtrl = () ->
    vm = @

    vm.viewing_emails = true
    vm.composing_email = false
    vm.reading_email = false

angular.module('angularMail').controller 'MainCtrl', MainCtrl

# -----------------------------------------------------------------------------

# @ngInject
# SearchBar Directive
SearchBar = () ->
    search_bar = {
        restrict: 'E'
        scope: {
            viewingEmails: '='
        }
        link: link
        templateUrl: 'templates/search_bar.html'
    }

    return search_bar

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'searchBar', SearchBar

# -----------------------------------------------------------------------------

# @ngInject
# MailBox Directive
MailBox = () ->
    mailbox = {
        restrict: 'E'
        scope: {
            viewingEmails: '='
            readingEmail: '='
        }
        link: link
        templateUrl: 'templates/mailbox.html'
    }

    return mailbox

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'mailbox', MailBox

# -----------------------------------------------------------------------------

# @ngInject
# Filters Directive
Filters = () ->
    filters = {
        restrict: 'E'
        scope: {
            viewingEmails: '='
        }
        link: link
        templateUrl: 'templates/filters.html'
    }

    return filters

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'filters', Filters

# -----------------------------------------------------------------------------

# @ngInject
# MessageList Directive
MessageList = () ->
    message_list = {
        restrict: 'E'
        scope: {
            viewingEmails: '='
        }
        link: link
        templateUrl: 'templates/message_list.html'
    }

    return message_list

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'messageList', MessageList

# -----------------------------------------------------------------------------

# @ngInject
# ViewEmail Directive
ViewEmail = () ->
    view_email = {
        restrict: 'E'
        scope: {
            readingEmail: '='
        }
        link: link
        templateUrl: 'templates/view_email.html'
    }

    return view_email

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'viewEmail', ViewEmail

# -----------------------------------------------------------------------------

# @ngInject
# SendForm Directive
SendForm = () ->
    send_form = {
        restrict: 'E'
        scope: {
            composingEmail: '='
        }
        link: link
        templateUrl: 'templates/send_form.html'
    }

    return send_form

    link = (scope, elem, attrs) ->

angular.module('angularMail').directive 'sendForm', SendForm
