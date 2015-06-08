

function sayHello()
{
     var nameFiled = document.getElementById('nameField');
     var helloHead = document.getElementById('helloHead');
     var name = nameField.value;
     
     helloHead.innerText = 'JavaScript is greeting your, ' + name +'!';
     helloHead.style.backgroundColor = getRandomColor();
}

function getRandomColor() 
{
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

window.onload = function()
{
    var button = document.getElementById('nameButton');
    button.onclick = sayHello;
};