###
# Directives
###

# -----------------------------------------------------------------------------

###
# Alert Directive
# @ngInject
###
Alert = () ->
    directive = {
        restrict: 'E'
        scope: {}
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/alerts.html'
    }

    return directive

angular.module('angularMail').directive 'alert', Alert

# -----------------------------------------------------------------------------

###
# MailBox Directive
# @ngInject
###
MailBox = () ->
    directive = {
        restrict: 'E'
        scope: {}
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/mailbox.html'
    }

    return directive

angular.module('angularMail').directive 'mailbox', MailBox

# -----------------------------------------------------------------------------

###
# ViewEmail Directive
# @ngInject
###
ViewEmail = () ->
    directive = {
        restrict: 'E'
        scope: {}
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/view_email.html'
    }

    return directive

angular.module('angularMail').directive 'viewEmail', ViewEmail

# -----------------------------------------------------------------------------

###
# SendForm Directive
# @ngInject
###
SendForm = () ->
    directive = {
        restrict: 'E'
        scope: {}
        link: (scope, elem, attrs) ->
        templateUrl: 'templates/send_form.html'
    }

    return directive

angular.module('angularMail').directive 'sendForm', SendForm
