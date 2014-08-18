###
# Controllers
###

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

    vm.editDraft = (email) ->
        EmailActionService.editDraft(email)

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

    $scope.$on 'readingEmail', () ->
        vm.mode = 'read'
        vm.currentEmail = EmailActionService.getCurrentEmail()

    $scope.$on 'currentEmailUpdated', () ->
        vm.currentEmail = EmailActionService.getCurrentEmail()

    $scope.$on 'editingDraft', () ->
        vm.mode = ModeService.changeMode 'compose'
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

    $scope.$on 'readingEmail', () ->
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

    vm.to = 'me@angular-mail.com'
    vm.subject = ''
    vm.date = ''
    vm.message = ''

    vm.mode = ModeService.getMode()
    vm.changeMode = (mode) ->
        ModeService.changeMode(mode)

    vm.sendEmail = (is_sent) ->
        email = EmailActionService.currentEmail
        EmailActionService.saveEmail(vm.to, vm.subject, vm.message, moment().format('MMMM Do YYYY'), is_sent)

        # Reset values
        ModeService.changeMode 'view'
        vm.to = 'me@angular-mail.com'
        vm.subject = ''
        vm.message = ''

    $scope.$on 'editingDraft', () ->
        email = EmailActionService.getCurrentEmail()
        vm.to = email.to_email
        vm.subject = email.subject
        vm.message = email.message

    $scope.$on 'modeUpdated', () ->
        vm.mode = ModeService.getMode()

    return

angular.module('angularMail').controller 'SendEmailCtrl', SendEmailCtrl
