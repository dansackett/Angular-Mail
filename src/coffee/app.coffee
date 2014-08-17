#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

###
# MailboxCtrl Controller
# @ngInject
###
MailboxCtrl = ($scope, MessageService, FilterService, ModeService, EmailActionService) ->
    vm = @

    vm.mode = ModeService.getMode()
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)
        vm.mode = ModeService.getMode(mode)
        return

    vm.searchText = ''

    vm.filter = FilterService.getCurrentFilter()
    vm.filters = FilterService.getFilters()
    vm.applyFilter = (filter) ->
        FilterService.applyFilter(filter)
        return

    vm.messages = MessageService.getMessages()

    vm.currentEmail = EmailActionService.getCurrentEmail()
    vm.showEmail = (email) ->
        EmailActionService.showEmail(email)
        return

    $scope.$on 'currentEmailUpdated', () ->
        vm.mode = 'read'
        vm.currentEmail = EmailActionService.getCurrentEmail()
        return

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()
        return

    $scope.$on 'filterUpdated', () ->
        vm.filter = FilterService.getCurrentFilter()
        return

    return

angular.module('angularMail').controller 'MailboxCtrl', MailboxCtrl

# -----------------------------------------------------------------------------

###
# ViewEmailCtrl Controller
# @ngInject
###
ViewEmailCtrl = ($scope, ModeService, EmailActionService) ->
    vm = @

    vm.mode = ModeService.getMode()
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)
        return

    vm.currentEmail = EmailActionService.getCurrentEmail()

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()
        return

    $scope.$on 'currentEmailUpdated', () ->
        vm.mode = 'read'
        vm.currentEmail = EmailActionService.getCurrentEmail()
        return

    return

angular.module('angularMail').controller 'ViewEmailCtrl', ViewEmailCtrl

# -----------------------------------------------------------------------------

###
# SendEmailCtrl Controller
# @ngInject
###
SendEmailCtrl = ($scope, ModeService) ->
    vm = @

    vm.mode = ModeService.getMode()
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)
        return

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()
        return

    return

angular.module('angularMail').controller 'SendEmailCtrl', SendEmailCtrl

# -----------------------------------------------------------------------------

###
# EmailActionsService Factory
# @ngInject
###
EmailActionService = ($rootScope) ->
    EmailActionsService = {
        currentEmail: null
        showEmail: (email) ->
            EmailActionService.currentEmail = email
            $rootScope.$broadcast('currentEmailUpdated')
            return
        getCurrentEmail: () ->
            return EmailActionService.currentEmail
    }

    return EmailActionsService

angular.module('angularMail').factory 'EmailActionService', EmailActionService

# -----------------------------------------------------------------------------

###
# ModeService Factory
# @ngInject
###
ModeService = ($rootScope) ->
    ModeService = {
        mode: 'view'
        getMode: () ->
            return ModeService.mode
        changeMode: (mode = 'view') ->
            ModeService.mode = mode
            $rootScope.$broadcast('modeUpdated')
            return
    }

    return ModeService

angular.module('angularMail').factory 'ModeService', ModeService

# -----------------------------------------------------------------------------

###
# MessageService Factory
# @ngInject
###
MessageService = () ->
    MessageService = {
        getMessages: () ->
            return messages
    }

    return MessageService

angular.module('angularMail').factory 'MessageService', MessageService

# -----------------------------------------------------------------------------

###
# FilterService Factory
# @ngInject
###
FilterService = ($rootScope) ->
    FilterService = {
        currentFilter: 'inbox'
        getFilters: () -> filters
        getCurrentFilter: () -> FilterService.currentFilter
        applyFilter: (filter) ->
            FilterService.currentFilter = filter
            $rootScope.$broadcast('filterUpdated')
            return FilterService.currentFilter
    }

    return FilterService

angular.module('angularMail').factory 'FilterService', FilterService

# -----------------------------------------------------------------------------

###
# TypeFilter Filter
# @ngInject
###
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

###
# SearchFilter Filter
# @ngInject
###
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
