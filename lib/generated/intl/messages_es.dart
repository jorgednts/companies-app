// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogButton": MessageLookupByLibrary.simpleMessage("Ok"),
        "alertDialogMessageGenericError": MessageLookupByLibrary.simpleMessage(
            "Ocurrio un error. Inténtalo de nuevo"),
        "alertDialogMessageNetworkError": MessageLookupByLibrary.simpleMessage(
            "Conexión fallida. Inténtalo de nuevo"),
        "alertDialogMessageUnauthorizedAuth":
            MessageLookupByLibrary.simpleMessage(
                "Credenciales no válidas. Inténtalo de nuevo"),
        "alertDialogTitle": MessageLookupByLibrary.simpleMessage("Ops"),
        "loginScreenButtonText":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "loginScreenEmptyFormText":
            MessageLookupByLibrary.simpleMessage("Completar el campo"),
        "loginScreenFormEmailLabelText":
            MessageLookupByLibrary.simpleMessage("E-mail"),
        "loginScreenFormInvalidEmail": MessageLookupByLibrary.simpleMessage(
            "Introduzca una dirección de correo electrónico válida. Ej: abc@abc.com.br\n"),
        "loginScreenFormInvalidPassword": MessageLookupByLibrary.simpleMessage(
            "La contraseña debe contener al menos 8 caracteres"),
        "loginScreenFormPasswordLabelText":
            MessageLookupByLibrary.simpleMessage("Contraseña"),
        "loginScreenIntroductionText": MessageLookupByLibrary.simpleMessage(
            "Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan."),
        "loginScreenWelcomeText":
            MessageLookupByLibrary.simpleMessage("Bienvenidos a empresas"),
        "mainScreenHintTextAppBar":
            MessageLookupByLibrary.simpleMessage("Buscar"),
        "mainScreenNoEnterpriseResult": MessageLookupByLibrary.simpleMessage(
            "No se encontraron empresas para una búsqueda realizada.")
      };
}
