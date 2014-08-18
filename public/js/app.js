'use strict';
var Alert, AlertCtrl, AlertService, EmailActionService, EmailSelectService, FilterService, MailBox, MailboxCtrl, MessageService, ModeService, SearchFilter, SendEmailCtrl, SendForm, TypeFilter, ViewEmail, ViewEmailCtrl, filters, messages;

angular.module('angularMail', ['ngStorage']);


/* Base Configuration For Application */


/* Filters */

filters = [
  {
    name: 'inbox',
    text: 'Inbox'
  }, {
    name: 'all',
    text: 'All Mail'
  }, {
    name: 'sent',
    text: 'Sent'
  }, {
    name: 'draft',
    text: 'Draft'
  }, {
    name: 'starred',
    text: 'Starred'
  }, {
    name: 'spam',
    text: 'Spam'
  }, {
    name: 'archived',
    text: 'Archived'
  }, {
    name: 'deleted',
    text: 'Deleted'
  }
];


/* Email Messages */

messages = [
  {
    id: 9,
    from: 'Dan Sackett',
    to_email: 'me@angular-mail.com',
    from_email: 'danesackett@gmail.com',
    subject: 'Hello, this is an email!',
    message: 'This is the message',
    date: 'August 15th, 2014',
    is_in_inbox: true,
    is_read: true,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: true
  }, {
    id: 8,
    from: 'Tony Hawk',
    to_email: 'me@angular-mail.com',
    from_email: 'tonyhawk@gmail.com',
    subject: 'Did you see that sweet jump I did?',
    message: 'It was the best jump in the world',
    date: 'August 4th, 2014',
    is_in_inbox: true,
    is_read: false,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }, {
    id: 7,
    from: 'Bill Simmons',
    to_email: 'me@angular-mail.com',
    from_email: 'billsimmons@gmail.com',
    subject: 'New Mailbag column is finally up',
    message: 'Just finished the new mailbag column. Go and check it out!',
    date: 'August 1st, 2014',
    is_in_inbox: true,
    is_read: false,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }, {
    id: 6,
    from: 'Dikembe Mutumbo',
    to_email: 'me@angular-mail.com',
    from_email: 'mountmutumbo@gmail.com',
    subject: 'No No No',
    message: 'You\'ll never dunk on me!',
    date: 'July 20th, 2014',
    is_in_inbox: true,
    is_read: false,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }, {
    id: 5,
    from: 'Jimmy Buffet',
    to_email: 'me@angular-mail.com',
    from_email: 'margaritaville@gmail.com',
    subject: 'Come on down to margaritaville',
    message: 'We\'ll be waiting for you',
    date: 'July 13th, 2014',
    is_in_inbox: false,
    is_read: true,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: true,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }, {
    id: 4,
    from: 'Father Time',
    to_email: 'me@angular-mail.com',
    from_email: 'fathertime@gmail.com',
    subject: 'You\'re getting old',
    message: 'We\'re ready for you',
    date: 'July 13th, 2014',
    is_in_inbox: false,
    is_read: true,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: true,
    is_deleted: false,
    is_starred: false
  }, {
    id: 3,
    from: 'Junk',
    to_email: 'me@angular-mail.com',
    from_email: 'no-reply@gmail.com',
    subject: 'Junk Mail',
    message: 'I\'m garbage',
    date: 'July 3rd, 2014',
    is_in_inbox: false,
    is_read: false,
    is_sent: false,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: true,
    is_deleted: true,
    is_starred: false
  }, {
    id: 2,
    from: 'Dan Sackett',
    to_email: 'me@angular-mail.com',
    from_email: 'danesackett@gmail.com',
    subject: 'Great Scott!',
    message: 'You sent this message!',
    date: 'July 3rd, 2014',
    is_in_inbox: false,
    is_read: true,
    is_sent: true,
    is_draft: false,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }, {
    id: 1,
    from: 'Dan Sackett',
    to_email: 'me@angular-mail.com',
    from_email: 'danesackett@gmail.com',
    subject: 'Draft',
    message: 'Draft Message',
    date: 'July 1st, 2014',
    is_in_inbox: false,
    is_read: true,
    is_sent: false,
    is_draft: true,
    is_selected: false,
    is_spam: false,
    is_archived: false,
    is_deleted: false,
    is_starred: false
  }
];


/*
 * Services
 */


/*
 * EmailSelectService Factory
 * @ngInject
 */

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
EmailSelectService.$inject = ["MessageService"];

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


/*
 * Controllers
 */


/*
 * MailboxCtrl Controller
 * @ngInject
 */

MailboxCtrl = function($scope, MessageService, FilterService, ModeService, EmailActionService, EmailSelectService) {
  var vm;
  vm = this;
  vm.searchText = '';
  vm.mode = ModeService.getMode();
  vm.changeMode = function(mode) {
    return ModeService.changeMode(mode);
  };
  vm.filter = FilterService.getCurrentFilter();
  vm.filters = FilterService.getFilters();
  vm.applyFilter = function(filter) {
    return FilterService.applyFilter(filter);
  };
  vm.emails = MessageService.getMessages();
  vm.currentEmail = EmailActionService.getCurrentEmail();
  vm.showEmail = function(email) {
    return EmailActionService.showEmail(email);
  };
  vm.starEmail = function(email) {
    return EmailActionService.starEmail(email);
  };
  vm.emailsSelected = EmailSelectService.emailsSelected();
  vm.selectEmails = function(type, emails) {
    EmailSelectService.selectEmails(type, emails);
    return vm.emailsSelected = EmailSelectService.emailsSelected;
  };
  vm.selectEmail = function(email, emails) {
    EmailSelectService.selectEmail(email, emails);
    return vm.emailsSelected = EmailSelectService.emailsSelected;
  };
  vm.editDraft = function(email) {
    return EmailActionService.editDraft(email);
  };
  vm.unselectEmails = function() {
    EmailSelectService.unselectEmails();
    return vm.emailsSelected = EmailSelectService.emailsSelected;
  };
  vm.starSelected = function(emails) {
    return EmailActionService.starSelected(emails);
  };
  vm.moveToInbox = function(emails) {
    return EmailActionService.moveToInbox(emails);
  };
  vm.unstarSelected = function(emails) {
    return EmailActionService.unstarSelected(emails);
  };
  vm.readSelected = function(emails) {
    return EmailActionService.readSelected(emails);
  };
  vm.unreadSelected = function(emails) {
    return EmailActionService.unreadSelected(emails);
  };
  vm.archiveSelected = function(emails) {
    return EmailActionService.archiveSelected(emails);
  };
  vm.spamSelected = function(emails) {
    return EmailActionService.spamSelected(emails);
  };
  vm.deleteSelected = function(emails) {
    return EmailActionService.deleteSelected(emails);
  };
  $scope.$on('selectedEmailsUpdated', function() {
    EmailSelectService.unselectEmails();
    return vm.emailsSelected = EmailSelectService.emailsSelected;
  });
  $scope.$on('readingEmail', function() {
    vm.mode = 'read';
    return vm.currentEmail = EmailActionService.getCurrentEmail();
  });
  $scope.$on('currentEmailUpdated', function() {
    return vm.currentEmail = EmailActionService.getCurrentEmail();
  });
  $scope.$on('editingDraft', function() {
    vm.mode = ModeService.changeMode('compose');
    return vm.currentEmail = EmailActionService.getCurrentEmail();
  });
  $scope.$on('modeUpdated', function() {
    return vm.mode = ModeService.getMode();
  });
  $scope.$on('filterUpdated', function() {
    return vm.filter = FilterService.getCurrentFilter();
  });
  $scope.$on('emailCreated', function() {
    return vm.messages = MessageService.getMessages();
  });
  $scope.$on('messagesUpdated', function() {
    return vm.messages = MessageService.getMessages();
  });
};
MailboxCtrl.$inject = ["$scope", "MessageService", "FilterService", "ModeService", "EmailActionService", "EmailSelectService"];

angular.module('angularMail').controller('MailboxCtrl', MailboxCtrl);


/*
 * ViewEmailCtrl Controller
 * @ngInject
 */

ViewEmailCtrl = function($scope, ModeService, EmailActionService) {
  var vm;
  vm = this;
  vm.mode = ModeService.getMode();
  vm.changeMode = function(mode) {
    return ModeService.changeMode(mode);
  };
  vm.currentEmail = EmailActionService.getCurrentEmail();
  $scope.$on('modeUpdated', function() {
    return vm.mode = ModeService.getMode();
  });
  $scope.$on('readingEmail', function() {
    vm.mode = 'read';
    return vm.currentEmail = EmailActionService.getCurrentEmail();
  });
};
ViewEmailCtrl.$inject = ["$scope", "ModeService", "EmailActionService"];

angular.module('angularMail').controller('ViewEmailCtrl', ViewEmailCtrl);


/*
 * SendEmailCtrl Controller
 * @ngInject
 */

SendEmailCtrl = function($scope, ModeService, EmailActionService, AlertService) {
  var vm;
  vm = this;
  vm.to = 'me@angular-mail.com';
  vm.subject = '';
  vm.date = '';
  vm.message = '';
  vm.mode = ModeService.getMode();
  vm.changeMode = function(mode) {
    return ModeService.changeMode(mode);
  };
  vm.sendEmail = function(is_sent) {
    var email;
    email = EmailActionService.currentEmail;
    if (!vm.to || !vm.subject || !vm.message) {
      AlertService.createAlert('Please fill out all of the fields', 'danger');
      return;
    }
    EmailActionService.saveEmail(vm.to, vm.subject, vm.message, moment().format('MMMM Do YYYY'), is_sent);
    ModeService.changeMode('view');
    vm.to = 'me@angular-mail.com';
    vm.subject = '';
    return vm.message = '';
  };
  $scope.$on('editingDraft', function() {
    var email;
    email = EmailActionService.getCurrentEmail();
    vm.to = email.to_email;
    vm.subject = email.subject;
    return vm.message = email.message;
  });
  $scope.$on('modeUpdated', function() {
    return vm.mode = ModeService.getMode();
  });
};
SendEmailCtrl.$inject = ["$scope", "ModeService", "EmailActionService", "AlertService"];

angular.module('angularMail').controller('SendEmailCtrl', SendEmailCtrl);


/*
 * Alert Controller
 * @ngInject
 */

AlertCtrl = function($scope, AlertService) {
  var vm;
  vm = this;
  vm.message = AlertService.getMessage();
  vm.type = AlertService.getType();
  vm.clearAlert = function() {
    return AlertService.clearAlert();
  };
  $scope.$on('alertUpdated', function() {
    vm.message = AlertService.getMessage();
    return vm.type = AlertService.getType();
  });
};
AlertCtrl.$inject = ["$scope", "AlertService"];

angular.module('angularMail').controller('ViewEmailCtrl', ViewEmailCtrl);


/*
 * Directives
 */


/*
 * Alert Directive
 * @ngInject
 */

Alert = function() {
  var directive;
  directive = {
    restrict: 'E',
    scope: {},
    link: function(scope, elem, attrs) {},
    templateUrl: 'templates/alerts.html'
  };
  return directive;
};

angular.module('angularMail').directive('alert', Alert);


/*
 * MailBox Directive
 * @ngInject
 */

MailBox = function() {
  var directive;
  directive = {
    restrict: 'E',
    scope: {},
    link: function(scope, elem, attrs) {},
    templateUrl: 'templates/mailbox.html'
  };
  return directive;
};

angular.module('angularMail').directive('mailbox', MailBox);


/*
 * ViewEmail Directive
 * @ngInject
 */

ViewEmail = function() {
  var directive;
  directive = {
    restrict: 'E',
    scope: {},
    link: function(scope, elem, attrs) {},
    templateUrl: 'templates/view_email.html'
  };
  return directive;
};

angular.module('angularMail').directive('viewEmail', ViewEmail);


/*
 * SendForm Directive
 * @ngInject
 */

SendForm = function() {
  var directive;
  directive = {
    restrict: 'E',
    scope: {},
    link: function(scope, elem, attrs) {},
    templateUrl: 'templates/send_form.html'
  };
  return directive;
};

angular.module('angularMail').directive('sendForm', SendForm);


/*
 * Filters
 */


/*
 * TypeFilter Filter
 * @ngInject
 */

TypeFilter = function() {
  return function(items, filter) {
    var filtered, item;
    if (filter === 'all') {
      return (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = items.length; _i < _len; _i++) {
          item = items[_i];
          if (!item.is_sent || !item.is_draft) {
            _results.push(item);
          }
        }
        return _results;
      })();
    }
    filtered = [];
    angular.forEach(items, function(item, key) {
      if (filter === 'inbox' && item.is_in_inbox) {
        return filtered.push(item);
      } else if (filter === 'starred' && item.is_starred) {
        return filtered.push(item);
      } else if (filter === 'spam' && item.is_spam) {
        return filtered.push(item);
      } else if (filter === 'sent' && item.is_sent) {
        return filtered.push(item);
      } else if (filter === 'draft' && item.is_draft) {
        return filtered.push(item);
      } else if (filter === 'archived' && item.is_archived) {
        return filtered.push(item);
      } else if (filter === 'deleted' && item.is_deleted) {
        return filtered.push(item);
      }
    });
    return filtered;
  };
};

angular.module('angularMail').filter('TypeFilter', TypeFilter);


/*
 * SearchFilter Filter
 * @ngInject
 */

SearchFilter = function() {
  return function(items, term) {
    var filtered;
    if (term === '') {
      return items;
    }
    filtered = [];
    angular.forEach(items, function(item, key) {
      var from, subject;
      term = term.toLowerCase();
      from = item.from.toLowerCase();
      subject = item.subject.toLowerCase();
      if (~from.indexOf(term)) {
        return filtered.push(item);
      } else if (~subject.indexOf(term)) {
        return filtered.push(item);
      }
    });
    return filtered;
  };
};

angular.module('angularMail').filter('SearchFilter', SearchFilter);
