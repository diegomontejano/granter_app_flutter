import "package:flutter/services.dart";

// format the value with the mask (9.999.999.999,00)
class RealFormatter extends TextInputFormatter {
  RealFormatter({this.real = false, this.decimalUnit = 2})
      : assert(decimalUnit == 2 || decimalUnit == 3,
            "Please inform 2 or 3 decimal units");

  final bool real;
  final int decimalUnit;
  int maxLength = 12;

  addSeparator(String value) {
    var result = "";
    var pointCount = 0;
    for (var i = value.length - 1; i > -1; i--) {
      if (pointCount == 3) {
        result = "." + result;
        pointCount = 0;
      }
      pointCount = pointCount + 1;
      result = value[i] + result;
    }
    return result;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength == 0) {
      return newValue;
    }
    if (newValueLength > maxLength) {
      return oldValue;
    }

    const symbol = "R\$ ";
    final newText = StringBuffer();
    var centsValue = "";
    var finalValue = newValue.text;
    var number = int.parse(newValue.text);

    var textValue = newValue.text
        .padLeft(newValue.text.length == 1 ? decimalUnit + 1 : decimalUnit, "");
    if (textValue.length >= decimalUnit) {
      centsValue =
          textValue.substring(textValue.length - decimalUnit, textValue.length);
      finalValue = textValue.substring(0, textValue.length - decimalUnit);
    }

    // add cents after 0,
    if (textValue.length == decimalUnit) {
      finalValue = "0," + centsValue;
      if (real) {
        finalValue = symbol + finalValue;
      }
      newText.write(finalValue);

      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    // format number with 0, + cents
    if (number > 0 && number < 9) {
      if (decimalUnit == 3) {
        centsValue = "00" + number.toString();
      } else {
        centsValue = "0" + number.toString();
      }

      number = 0;
    } else if (number >= 10 && number < 100) {
      if (decimalUnit == 3) {
        centsValue = "0" + number.toString();
      } else {
        centsValue = number.toString();
      }

      number = 0;
    } else if (finalValue.isNotEmpty) {
      number = int.parse(finalValue);
    }

    if (number > 999) {
      finalValue = addSeparator(number.toString()) + "," + centsValue;
    } else {
      finalValue = number.toString() + "," + centsValue;
    }

    if (real) {
      finalValue = symbol + finalValue;
    }
    newText.write(finalValue);

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
