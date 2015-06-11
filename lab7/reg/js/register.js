var ERROR = 
{
    LOGIN: 'Incorrect login',
    EMAIL: 'Incorrect email',
    PASSWORD_EMPTY: 'Empty password',
    CONFIRM_EMPTY: 'Empty confirm password',
    PASSWORD_NOT_MATCH: 'Passwords don\'t match'
};

var Regexp = 
{
    LOGIN: '([A-Za-z_ 0-9])+',
    EMAIL: '([A-Za-z_ 0-9])+',
    PASSWORD: '(.)+'
};

function validate()
{
    var errorContainer = document.getElementById('errors');
    var login = document.getElementById('login').value;
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    var confirmPassword = document.getElementById('confirmPassword').value;
    
    var errors = [];
    if (!validateRegex(login, Regexp.LOGIN)) errors.push(ERROR.LOGIN);
    if (!validateRegex(email, Regexp.EMAIL)) errors.push(ERROR.EMAIL);
    if (!validateRegex(password, Regexp.PASSWORD)) errors.push(ERROR.PASSWORD_EMPTY);
    if (!validateRegex(confirmPassword, Regexp.PASSWORD)) errors.push(ERROR.CONFIRM_EMPTY);
    if (!validatePassword(password, confirmPassword)) errors.push(ERROR.PASSWORD_NOT_MATCH);
    
    if (errors.length > 0)
    {
        errorContainer.innerText = errors.join('; ');
    }
    else
    {
        errorContainer.innerText = 'OK!';
    }
    
    return false;
}

function validatePassword(pass, confirm)
{
    var match = false;
    if (pass == confirm) return true;
}

function validateRegex(str, regexp)
{
    var regex = new RegExp(regexp);
    return regex.test(str);
}

window.onload = function()
{
    var regForm = document.getElementById('regForm');
    regForm.onsubmit = validate;    
};

