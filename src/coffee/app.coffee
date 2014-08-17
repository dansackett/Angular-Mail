#= require config.coffee

angular.module 'angularMail', []

# -----------------------------------------------------------------------------

###
# MailboxCtrl Controller
# @ngInject
###
MailboxCtrl = ($scope, MessageService, FilterService, ModeService, EmailActionService, EmailSelectService) ->
    vm = @

    vm.searchText = ''

    vm.mode = ModeService.getMode()
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)

    vm.filter = FilterService.getCurrentFilter()
    vm.filters = FilterService.getFilters()
    vm.applyFilter = (filter) ->
        FilterService.applyFilter(filter)

    vm.emails = MessageService.getMessages()
    vm.currentEmail = EmailActionService.getCurrentEmail()
    vm.showEmail = (email) ->
        EmailActionService.showEmail(email)

    vm.starEmail = (email) ->
        EmailActionService.starEmail(email)

    vm.emailsSelected = EmailSelectService.emailsSelected
    vm.selectEmails = (type, emails) ->
        EmailSelectService.selectEmails(type, emails)
        vm.emailsSelected = EmailSelectService.emailsSelected

    vm.selectEmail = (email, emails) ->
        EmailSelectService.selectEmail(email, emails)
        vm.emailsSelected = EmailSelectService.emailsSelected

    vm.unselectEmails = () ->
        EmailSelectService.unselectEmails()
        vm.emailsSelected = EmailSelectService.emailsSelected

    vm.starSelected = (emails) ->
        EmailActionService.starSelected(emails)

    vm.moveToInbox = (emails) ->
        EmailActionService.moveToInbox(emails)

    vm.unstarSelected = (emails) ->
        EmailActionService.unstarSelected(emails)

    vm.readSelected = (emails) ->
        EmailActionService.readSelected(emails)

    vm.unreadSelected = (emails) ->
        EmailActionService.unreadSelected(emails)

    vm.archiveSelected = (emails) ->
        EmailActionService.archiveSelected(emails)

    vm.spamSelected = (emails) ->
        EmailActionService.spamSelected(emails)

    vm.deleteSelected = (emails) ->
        EmailActionService.deleteSelected(emails)

    $scope.$on 'selectedEmailsUpdated', () ->
        EmailSelectService.unselectEmails()
        vm.emailsSelected = EmailSelectService.emailsSelected

    $scope.$on 'currentEmailUpdated', () ->
        vm.mode = 'read'
        vm.currentEmail = EmailActionService.getCurrentEmail()

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()

    $scope.$on 'filterUpdated', () ->
        vm.filter = FilterService.getCurrentFilter()

    $scope.$on 'emailCreated', () ->
        vm.messages = MessageService.getMessages()

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

    vm.currentEmail = EmailActionService.getCurrentEmail()

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()

    $scope.$on 'currentEmailUpdated', () ->
        vm.mode = 'read'
        vm.currentEmail = EmailActionService.getCurrentEmail()

    return

angular.module('angularMail').controller 'ViewEmailCtrl', ViewEmailCtrl

# -----------------------------------------------------------------------------

###
# SendEmailCtrl Controller
# @ngInject
###
SendEmailCtrl = ($scope, ModeService, EmailActionService) ->
    vm = @

    vm.mode = ModeService.getMode()
    vm.from = ''
    vm.subject = ''
    vm.date = ''
    vm.message = ''
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)

    vm.sendEmail = (from, subject, message, date, is_sent) ->
        EmailActionService.createEmail(from, subject, message, date, is_sent)

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()

    $scope.$on 'emailCreated', () ->
        vm.mode = 'view'

    return

angular.module('angularMail').controller 'SendEmailCtrl', SendEmailCtrl

# -----------------------------------------------------------------------------

###
# EmailSelectService Factory
# @ngInject
###
EmailSelectService = () ->
    EmailSelectService = {
        emailsSelected: false
        selectEmail: (email, emails) ->
            email.is_selected = not email.is_selected
            selected_num = (email for email in emails when email.is_selected).length > 0
            EmailSelectService.emailsSelected = selected_num
        unselectEmails: () ->
            (email.is_selected = false for email in messages)
            EmailSelectService.emailsSelected = false
        selectEmails: (type = 'all', emails) ->
            (email.is_selected = false for email in emails)
            EmailSelectService.emailsSelected = true

            if type == 'all'
                (email.is_selected = true for email in emails)
            else if type == 'read'
                (email.is_selected = true for email in emails when email.is_read)
            else if type == 'unread'
                (email.is_selected = true for email in emails when not email.is_read)
            else if type == 'starred'
                (email.is_selected = true for email in emails when email.is_starred)
            else if type == 'unstarred'
                (email.is_selected = true for email in emails when not email.is_starred)
    }

    return EmailSelectService

angular.module('angularMail').factory 'EmailSelectService', EmailSelectService

# -----------------------------------------------------------------------------

###
# EmailActionsService Factory
# @ngInject
###
EmailActionService = ($rootScope) ->
    EmailActionService = {
        currentEmail: null
        getCurrentEmail: () ->
            EmailActionService.currentEmail
        showEmail: (email) ->
            EmailActionService.currentEmail = email
            email.is_read = true
            $rootScope.$broadcast('currentEmailUpdated')
        createEmail: (from, subject, message, date, is_sent) ->
            messages.push {
                from: from
                from_email: 'me@angularmail.com'
                subject: subject
                message: message
                date: date
                is_in_inbox: false
                is_read: false
                is_sent: is_sent
                is_draft: not is_sent
                is_selected: false
                is_spam: false
                is_archived: false
                is_deleted: false
                is_starred: false
            }
            $rootScope.$broadcast('emailCreated')
        starEmail: (email) ->
            email.is_starred = !email.is_starred
            $rootScope.$broadcast('selectedEmailsUpdated')
        moveToInbox: (emails) ->
            angular.forEach emails, (email) ->
                valid = not email.is_sent and not email.is_draft and email.is_selected

                if valid
                    email.is_in_inbox = true
                    email.is_archived = false
                    email.is_spam = false
                    email.is_deleted = false
            $rootScope.$broadcast('selectedEmailsUpdated')
        starSelected: (emails) ->
            (email.is_starred = true for email in emails when email.is_selected)
            $rootScope.$broadcast('selectedEmailsUpdated')
        unstarSelected: (emails) ->
            (email.is_starred = false for email in emails when email.is_selected)
            $rootScope.$broadcast('selectedEmailsUpdated')
        readSelected: (emails) ->
            (email.is_read = true for email in emails when email.is_selected)
            $rootScope.$broadcast('selectedEmailsUpdated')
        unreadSelected: (emails) ->
            (email.is_read = false for email in emails when email.is_selected)
            $rootScope.$broadcast('selectedEmailsUpdated')
        spamSelected: (emails) ->
            angular.forEach emails, (email) ->
                if email.is_selected
                    email.is_in_inbox = false
                    email.is_spam = true
            $rootScope.$broadcast('selectedEmailsUpdated')
        archiveSelected: (emails) ->
            angular.forEach emails, (email) ->
                if email.is_selected
                    email.is_in_inbox = false
                    email.is_archived = true
            $rootScope.$broadcast('selectedEmailsUpdated')
        deleteSelected: (emails) ->
            angular.forEach emails, (email) ->
                if email.is_selected
                    email.is_in_inbox = false
                    email.is_deleted = true
            $rootScope.$broadcast('selectedEmailsUpdated')
    }

    return EmailActionService

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
            ModeService.mode
        changeMode: (mode = 'view') ->
            ModeService.mode = mode
            $rootScope.$broadcast('modeUpdated')
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
            messages
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
            FilterService.currentFilter
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
