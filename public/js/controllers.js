
/*
 * Controllers
 */

/*
 * MailboxCtrl Controller
 * @ngInject
 */
var AlertCtrl, MailboxCtrl, SendEmailCtrl, ViewEmailCtrl;

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
