const loginMinLength = 3;
const loginMaxLength = 30;

const emailValidationRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

const passwordMinLength = 6;
const passwordMaxLength = 30;

const passwordSpecialSymbols = r'@$!%*?&_';
const passwordValidationRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_]).*$';
