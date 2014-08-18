
/*
 * Services
 */

/*
 * EmailSelectService Factory
 * @ngInject
 */
var AlertService, EmailActionService, EmailSelectService, FilterService, MessageService, ModeService;

EmailSelectService = function(MessageService) {
  var emailsSelected, selectEmail, selectEmails, service, unselectEmails;
  emailsSelected = function() {
    var email, selected_num;
    selected_num = ((function() {
      var _i, _len, _ref, _results;
      _ref = MessageService.getMessages();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        email = _ref[_i];
        if (email.is_selected) {
          _results.push(email);
        }
      }
      return _results;
    })()).length > 0;
    return service.emailsSelected = selected_num;
  };
  selectEmail = function(email, emails) {
    var selected_num;
    email.is_selected = !email.is_selected;
    selected_num = ((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = emails.length; _i < _len; _i++) {
        email = emails[_i];
        if (email.is_selected) {
          _results.push(email);
        }
      }
      return _results;
    })()).length > 0;
    return service.emailsSelected = selected_num;
  };
  unselectEmails = function() {
    var email, _i, _len, _ref;
    _ref = MessageService.getMessages();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      email = _ref[_i];
      email.is_selected = false;
    }
    return service.emailsSelected = false;
  };
  selectEmails = function(type, emails) {
    var email, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _len5, _m, _n;
    if (type == null) {
      type = 'all';
    }
    for (_i = 0, _len = emails.length; _i < _len; _i++) {
      email = emails[_i];
      email.is_selected = false;
    }
    service.emailsSelected = true;
    if (type === 'all') {
      for (_j = 0, _len1 = emails.length; _j < _len1; _j++) {
        email = emails[_j];
        email.is_selected = true;
      }
    } else if (type === 'read') {
      for (_k = 0, _len2 = emails.length; _k < _len2; _k++) {
        email = emails[_k];
        if (email.is_read) {
          email.is_selected = true;
        }
      }
    } else if (type === 'unread') {
      for (_l = 0, _len3 = emails.length; _l < _len3; _l++) {
        email = emails[_l];
        if (!email.is_read) {
          email.is_selected = true;
        }
      }
    } else if (type === 'starred') {
      for (_m = 0, _len4 = emails.length; _m < _len4; _m++) {
        email = emails[_m];
        if (email.is_starred) {
          email.is_selected = true;
        }
      }
    } else if (type === 'unstarred') {
      for (_n = 0, _len5 = emails.length; _n < _len5; _n++) {
        email = emails[_n];
        if (!email.is_starred) {
          email.is_selected = true;
        }
      }
    }
    MessageService.updateMessages(emails);
  };
  service = {
    emailsSelected: emailsSelected,
    selectEmail: selectEmail,
    unselectEmails: unselectEmails,
    selectEmails: selectEmails
  };
  return service;
};

angular.module('angularMail').factory('EmailSelectService', EmailSelectService);


/*
 * EmailActionsService Factory
 * @ngInject
 */

EmailActionService = function($rootScope, MessageService, AlertService) {
  var archiveSelected, deleteSelected, editDraft, getCurrentEmail, moveToInbox, readSelected, saveEmail, service, setCurrentEmail, showEmail, spamSelected, starEmail, starSelected, unreadSelected, unstarSelected;
  getCurrentEmail = function() {
    return service.currentEmail;
  };
  setCurrentEmail = function(email) {
    service.currentEmail = email;
    return $rootScope.$broadcast('currentEmailUpdated');
  };
  showEmail = function(email) {
    service.currentEmail = email;
    email.is_read = true;
    return $rootScope.$broadcast('readingEmail');
  };
  saveEmail = function(to, subject, message, date, is_sent) {
    var email, in_inbox;
    in_inbox = to === 'me@angular-mail.com' && is_sent;
    email = getCurrentEmail();
    if (email && email.is_draft) {
      email.to_email = to;
      email.subject = subject;
      email.message = message;
      email.date = date;
      email.is_in_inbox = in_inbox;
      email.is_read = !in_inbox;
      email.is_sent = is_sent;
      email.is_draft = !is_sent;
      if (email.is_draft) {
        AlertService.createAlert('Email Draft Saved', 'success');
      } else {
        AlertService.createAlert('Email Sent', 'success');
      }
      MessageService.moveEmailToFront(email);
    } else {
      email = {
        id: MessageService.nextId(),
        from: 'Angular-Mail',
        from_email: 'me@angular-mail.com',
        subject: subject,
        to_email: to,
        message: message,
        date: date,
        is_in_inbox: in_inbox,
        is_read: !in_inbox,
        is_sent: is_sent,
        is_draft: !is_sent,
        is_selected: false,
        is_spam: false,
        is_archived: false,
        is_deleted: false,
        is_starred: false
      };
      if (email.is_draft) {
        AlertService.createAlert('Email Draft Saved', 'success');
      } else {
        AlertService.createAlert('Email Sent', 'success');
      }
      MessageService.addMessage(email);
    }
    return $rootScope.$broadcast('emailCreated');
  };
  editDraft = function(email) {
    setCurrentEmail(email);
    return $rootScope.$broadcast('editingDraft');
  };
  starEmail = function(email) {
    email.is_starred = !email.is_starred;
    if (email.is_starred) {
      AlertService.createAlert('Email Starred', 'success');
    } else {
      AlertService.createAlert('Email Unstarred', 'success');
    }
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  moveToInbox = function(emails) {
    angular.forEach(emails, function(email) {
      var valid;
      valid = !email.is_sent && !email.is_draft && email.is_selected;
      if (valid) {
        email.is_in_inbox = true;
        email.is_archived = false;
        email.is_spam = false;
        return email.is_deleted = false;
      }
    });
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  starSelected = function(emails) {
    var email, _i, _len;
    for (_i = 0, _len = emails.length; _i < _len; _i++) {
      email = emails[_i];
      if (email.is_selected) {
        email.is_starred = true;
      }
    }
    AlertService.createAlert('Emails Starred', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  unstarSelected = function(emails) {
    var email, _i, _len;
    for (_i = 0, _len = emails.length; _i < _len; _i++) {
      email = emails[_i];
      if (email.is_selected) {
        email.is_starred = false;
      }
    }
    AlertService.createAlert('Emails Unstarred', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  readSelected = function(emails) {
    var email, _i, _len;
    for (_i = 0, _len = emails.length; _i < _len; _i++) {
      email = emails[_i];
      if (email.is_selected) {
        email.is_read = true;
      }
    }
    AlertService.createAlert('Emails Marked as Read', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  unreadSelected = function(emails) {
    var email, _i, _len;
    for (_i = 0, _len = emails.length; _i < _len; _i++) {
      email = emails[_i];
      if (email.is_selected) {
        email.is_read = false;
      }
    }
    AlertService.createAlert('Emails Marked as Unread', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  spamSelected = function(emails) {
    angular.forEach(emails, function(email) {
      if (email.is_selected) {
        email.is_in_inbox = false;
        return email.is_spam = true;
      }
    });
    AlertService.createAlert('Emails Marked as Spam', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  archiveSelected = function(emails) {
    angular.forEach(emails, function(email) {
      if (email.is_selected) {
        email.is_in_inbox = false;
        return email.is_archived = true;
      }
    });
    AlertService.createAlert('Emails Archived', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  deleteSelected = function(emails) {
    angular.forEach(emails, function(email) {
      if (email.is_selected) {
        email.is_in_inbox = false;
        return email.is_deleted = true;
      }
    });
    AlertService.createAlert('Emails Deleted', 'success');
    return $rootScope.$broadcast('selectedEmailsUpdated');
  };
  service = {
    currentEmail: null,
    getCurrentEmail: getCurrentEmail,
    showEmail: showEmail,
    saveEmail: saveEmail,
    editDraft: editDraft,
    starEmail: starEmail,
    moveToInbox: moveToInbox,
    starSelected: starSelected,
    unstarSelected: unstarSelected,
    readSelected: readSelected,
    unreadSelected: unreadSelected,
    spamSelected: spamSelected,
    archiveSelected: archiveSelected,
    deleteSelected: deleteSelected
  };
  return service;
};
EmailActionService.$inject = ["$rootScope", "MessageService", "AlertService"];

angular.module('angularMail').factory('EmailActionService', EmailActionService);


/*
 * ModeService Factory
 * @ngInject
 */

ModeService = function($rootScope) {
  var changeMode, getMode, service;
  getMode = function() {
    return service.mode;
  };
  changeMode = function(mode) {
    if (mode == null) {
      mode = 'view';
    }
    service.mode = mode;
    return $rootScope.$broadcast('modeUpdated');
  };
  service = {
    mode: 'view',
    getMode: getMode,
    changeMode: changeMode
  };
  return service;
};
ModeService.$inject = ["$rootScope"];

angular.module('angularMail').factory('ModeService', ModeService);


/*
 * MessageService Factory
 * @ngInject
 */

MessageService = function($rootScope, $localStorage) {
  var addMessage, getMessages, moveEmailToFront, nextId, service, updateMessages;
  getMessages = function() {
    if (!$localStorage.messages) {
      $localStorage.messages = service.messages;
    }
    return $localStorage.messages;
  };
  addMessage = function(email) {
    return $localStorage.messages.unshift(email);
  };
  updateMessages = function(emails) {
    $localStorage.messages = emails;
    return $rootScope.$broadcast('messagesUpdated');
  };
  moveEmailToFront = function(email) {
    return $localStorage.messages.sort(function(a, b) {
      if (a.id < b.id) {
        return 1;
      }
      if (a.id > b.id) {
        return -1;
      }
      return 0;
    });
  };
  nextId = function() {
    return $localStorage.messages.length + 1;
  };
  service = {
    messages: messages,
    getMessages: getMessages,
    addMessage: addMessage,
    updateMessages: updateMessages,
    moveEmailToFront: moveEmailToFront,
    nextId: nextId
  };
  return service;
};
MessageService.$inject = ["$rootScope", "$localStorage"];

angular.module('angularMail').factory('MessageService', MessageService);


/*
 * FilterService Factory
 * @ngInject
 */

FilterService = function($rootScope) {
  var applyFilter, service;
  applyFilter = function(filter) {
    service.currentFilter = filter;
    $rootScope.$broadcast('filterUpdated');
    return service.currentFilter;
  };
  service = {
    currentFilter: 'inbox',
    getFilters: function() {
      return filters;
    },
    getCurrentFilter: function() {
      return service.currentFilter;
    },
    applyFilter: applyFilter
  };
  return service;
};
FilterService.$inject = ["$rootScope"];

angular.module('angularMail').factory('FilterService', FilterService);


/*
 * AlertService Factory
 * @ngInject
 */

AlertService = function($rootScope) {
  var clearAlert, createAlert, service;
  createAlert = function(message, type) {
    service.message = message;
    service.type = type;
    return $rootScope.$broadcast('alertUpdated');
  };
  clearAlert = function() {
    service.message = '';
    service.type = '';
    return $rootScope.$broadcast('alertUpdated');
  };
  service = {
    message: '',
    type: '',
    getMessage: function() {
      return service.message;
    },
    getType: function() {
      return service.type;
    },
    createAlert: createAlert,
    clearAlert: clearAlert
  };
  return service;
};
AlertService.$inject = ["$rootScope"];

angular.module('angularMail').factory('AlertService', AlertService);
