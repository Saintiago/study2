var ERROR = 
{
    LOGIN: 'Incorrect login',
    PASSWORD_EMPTY: 'Empty password',
};

var Regexp = 
{
    LOGIN: '([A-Za-z_ 0-9])+',
    PASSWORD: '(.)+'
};

function validate()
{
    var errorContainer = document.getElementById('errors');
    var login = document.getElementById('login').value;
    var password = document.getElementById('password').value;
    
    var errors = [];
    if (!validateRegex(login, Regexp.LOGIN)) errors.push(ERROR.LOGIN);
    if (!validateRegex(password, Regexp.PASSWORD)) errors.push(ERROR.PASSWORD_EMPTY);
    
    if (errors.length > 0)
    {
        errorContainer.innerText = errors.join('; ');
        return false;
    }
}

function validateRegex(str, regexp)
{
    var regex = new RegExp(regexp);
    return regex.test(str);
}

window.onload = function()
{
    var authForm = document.getElementById('authForm');
    authForm.onsubmit = validate;    
};

