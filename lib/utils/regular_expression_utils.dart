class RegularExpressionUtils {
  static String alphabetSpacePattern = "[a-zA-ZÆØÅæøå_ ]";
  static String numberPattern = r"^[0-9]+$";
  static String expiryDatePattern = r"^(0[1-9]|1[0-2])\/\d{2}$";
  static String emailPattern = r"[a-zA-Z0-9$_@.-]";
  static String emailValidationPattern =
      r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
  static const onlyLetters = r'^[a-zA-Z ]*$';
  static const onlyDigits = r'^[0-9]*$';
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const password = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$';
  static const alphanumeric = r'^[a-zA-Z0-9]*$';
  static const postalCode = r'^\d{5,6}$';
  static const panCard = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
  static const gstNumber =
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
  static const dob = r'^[0-9\/\-]*$';
  static String numberWithDotPattern = r'^\d+(\.\d{0,2})?$';
}
