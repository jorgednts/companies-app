// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "alertDialogMessageGenericError":
            MessageLookupByLibrary.simpleMessage("Occurred error. Try again"),
        "alertDialogMessageNetworkError":
            MessageLookupByLibrary.simpleMessage("Connection fail. Try again"),
        "alertDialogMessageUnauthorizedAuth":
            MessageLookupByLibrary.simpleMessage(
                "Invalid credentials. Try again"),
        "alertDialogTitle": MessageLookupByLibrary.simpleMessage("Ops"),
        "loginScreenButtonText":
            MessageLookupByLibrary.simpleMessage("Sing in"),
        "loginScreenEmptyFormText":
            MessageLookupByLibrary.simpleMessage("Fill the field"),
        "loginScreenFormEmailLabelText":
            MessageLookupByLibrary.simpleMessage("E-mail"),
        "loginScreenFormInvalidEmail": MessageLookupByLibrary.simpleMessage(
            "Enter a valid email address. Ex: abc@abc.com.br"),
        "loginScreenFormInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "Password must contain at least 8 characters"),
        "loginScreenFormPasswordLabelText":
            MessageLookupByLibrary.simpleMessage("Password"),
        "loginScreenIntroductionText": MessageLookupByLibrary.simpleMessage(
            "Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan."),
        "loginScreenWelcomeText":
            MessageLookupByLibrary.simpleMessage("Welcome to companies")
      };
}
