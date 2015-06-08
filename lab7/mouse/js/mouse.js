function mousePos(e)
{
    var posX = e.pageX;
    var posY = e.pageY;

    var mouseX = document.getElementById('mouseX');
    var mouseY = document.getElementById('mouseY');
    
    mouseX.innerText = posX;
    mouseY.innerText = posY;
}

window.onload = function()
{
    document.onmousemove = mousePos;    
};

