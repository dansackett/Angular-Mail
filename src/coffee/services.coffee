###
# Services
###

# -----------------------------------------------------------------------------

###
# EmailSelectService Factory
# @ngInject
###
EmailSelectService = () ->
    # Select a single Email
    selectEmail = (email, emails) ->
        email.is_selected = not email.is_selected
        selected_num = (email for email in emails when email.is_selected).length > 0
        service.emailsSelected = selected_num

    # Unselect all emails
    unselectEmails = () ->
        (email.is_selected = false for email in messages)
        service.emailsSelected = false

    # Select emails based on a type filter
    selectEmails = (type = 'all', emails) ->
        (email.is_selected = false for email in emails)
        service.emailsSelected = true

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

    # Create service
    service = {
        emailsSelected: false
        selectEmail: selectEmail
        unselectEmails: unselectEmails
        selectEmails: selectEmails
    }

    return service


angular.module('angularMail').factory 'EmailSelectService', EmailSelectService

# -----------------------------------------------------------------------------

###
# EmailActionsService Factory
# @ngInject
###
EmailActionService = ($rootScope, MessageService, AlertService) ->
    # Get the currently selected email
    getCurrentEmail = () ->
        service.currentEmail

    # Show the currently selected email in the view
    setCurrentEmail = (email) ->
        service.currentEmail = email
        $rootScope.$broadcast 'currentEmailUpdated'

    # Show the currently selected email in the view
    showEmail = (email) ->
        service.currentEmail = email
        email.is_read = true
        $rootScope.$broadcast 'readingEmail'

    # Create a new email
    saveEmail = (to, subject, message, date, is_sent) ->
        in_inbox = to is 'me@angular-mail.com' and is_sent

        email = getCurrentEmail()

        if email and email.is_draft
            email.to_email = to
            email.subject = subject
            email.message = message
            email.date = date
            email.is_in_inbox = in_inbox
            email.is_read = not in_inbox
            email.is_sent = is_sent
            email.is_draft = not is_sent

            if email.is_draft
                AlertService.createAlert 'Email Draft Saved', 'success'
            else
                AlertService.createAlert 'Email Sent', 'success'

            MessageService.moveEmailToFront email
        else
            email = {
                id: MessageService.nextId()
                from: 'Angular-Mail'
                from_email: 'me@angular-mail.com'
                subject: subject
                to_email: to
                message: message
                date: date
                is_in_inbox: in_inbox
                is_read: not in_inbox
                is_sent: is_sent
                is_draft: not is_sent
                is_selected: false
                is_spam: false
                is_archived: false
                is_deleted: false
                is_starred: false
            }

            if email.is_draft
                AlertService.createAlert 'Email Draft Saved', 'success'
            else
                AlertService.createAlert 'Email Sent', 'success'

            MessageService.addMessage email

        $rootScope.$broadcast 'emailCreated'

    # Edit draft
    editDraft = (email) ->
        setCurrentEmail email
        $rootScope.$broadcast 'editingDraft'

    # Star/Unstar an Email
    starEmail = (email) ->
        email.is_starred = !email.is_starred

        if email.is_starred
            AlertService.createAlert 'Email Starred', 'success'
        else
            AlertService.createAlert 'Email Unstarred', 'success'

        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Move and email to the inbox
    moveToInbox = (emails) ->
        angular.forEach emails, (email) ->
            valid = not email.is_sent and not email.is_draft and email.is_selected

            if valid
                email.is_in_inbox = true
                email.is_archived = false
                email.is_spam = false
                email.is_deleted = false

        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Star Selected Emails
    starSelected = (emails) ->
        (email.is_starred = true for email in emails when email.is_selected)
        AlertService.createAlert 'Emails Starred', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Unstar Selected Emails
    unstarSelected = (emails) ->
        (email.is_starred = false for email in emails when email.is_selected)
        AlertService.createAlert 'Emails Unstarred', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Mark Selected Emails as Read
    readSelected = (emails) ->
        (email.is_read = true for email in emails when email.is_selected)
        AlertService.createAlert 'Emails Marked as Read', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Mark Selected Emails as Unread
    unreadSelected = (emails) ->
        (email.is_read = false for email in emails when email.is_selected)
        AlertService.createAlert 'Emails Marked as Unread', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Mark Selected Emails as Spam
    spamSelected = (emails) ->
        angular.forEach emails, (email) ->
            if email.is_selected
                email.is_in_inbox = false
                email.is_spam = true

        AlertService.createAlert 'Emails Marked as Spam', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    # Mark Selected Emails as Archived
    archiveSelected = (emails) ->
        angular.forEach emails, (email) ->
            if email.is_selected
                email.is_in_inbox = false
                email.is_archived = true

        AlertService.createAlert 'Emails Archived', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'


    # Mark Selected Emails as Deleted
    deleteSelected = (emails) ->
        angular.forEach emails, (email) ->
            if email.is_selected
                email.is_in_inbox = false
                email.is_deleted = true

        AlertService.createAlert 'Emails Deleted', 'success'
        $rootScope.$broadcast 'selectedEmailsUpdated'

    service = {
        currentEmail: null
        getCurrentEmail: getCurrentEmail
        showEmail: showEmail
        saveEmail: saveEmail
        editDraft: editDraft
        starEmail: starEmail
        moveToInbox: moveToInbox
        starSelected: starSelected
        unstarSelected: unstarSelected
        readSelected: readSelected
        unreadSelected: unreadSelected
        spamSelected: spamSelected
        archiveSelected: archiveSelected
        deleteSelected: deleteSelected
    }

    return service

angular.module('angularMail').factory 'EmailActionService', EmailActionService

# -----------------------------------------------------------------------------

###
# ModeService Factory
# @ngInject
###
ModeService = ($rootScope) ->
    # Get the current mode
    getMode = () ->
        service.mode

    # Change the current mode
    changeMode = (mode = 'view') ->
        service.mode = mode
        $rootScope.$broadcast 'modeUpdated'

    service = {
        mode: 'view'
        getMode: getMode
        changeMode: changeMode
    }

    return service

angular.module('angularMail').factory 'ModeService', ModeService

# -----------------------------------------------------------------------------

###
# MessageService Factory
# @ngInject
###
MessageService = () ->
    # Add a new email message
    addMessage = (email) ->
        messages.unshift email

    # Move an email out of the stack to the front
    moveEmailToFront = (email) ->
        messages.sort (a,b) ->
            if a.id < b.id
             return 1
            if a.id > b.id
                return -1

            return 0

    # Get the next ID
    nextId = () ->
        return messages.length + 1

    service = {
        getMessages: () -> messages
        addMessage: addMessage
        moveEmailToFront: moveEmailToFront
        nextId: nextId
    }

    return service

angular.module('angularMail').factory 'MessageService', MessageService

# -----------------------------------------------------------------------------

###
# FilterService Factory
# @ngInject
###
FilterService = ($rootScope) ->
    # Apply a new filter
    applyFilter = (filter) ->
        service.currentFilter = filter
        $rootScope.$broadcast 'filterUpdated'
        service.currentFilter

    service = {
        currentFilter: 'inbox'
        getFilters: () -> filters
        getCurrentFilter: () -> service.currentFilter
        applyFilter: applyFilter
    }

    return service

angular.module('angularMail').factory 'FilterService', FilterService

# -----------------------------------------------------------------------------

###
# AlertService Factory
# @ngInject
###
AlertService = ($rootScope) ->
    # Create a new Alert
    createAlert = (message, type) ->
        service.message = message
        service.type = type
        $rootScope.$broadcast 'alertUpdated'

    # Create a new Alert
    clearAlert = () ->
        service.message = ''
        service.type = ''
        $rootScope.$broadcast 'alertUpdated'

    service = {
        message: ''
        type: ''
        getMessage: () -> service.message
        getType: () -> service.type
        createAlert: createAlert
        clearAlert: clearAlert
    }

    return service

angular.module('angularMail').factory 'AlertService', AlertService
