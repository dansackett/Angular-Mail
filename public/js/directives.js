
/*
 * Directives
 */

/*
 * Alert Directive
 * @ngInject
 */
var Alert, MailBox, SendForm, ViewEmail;

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
