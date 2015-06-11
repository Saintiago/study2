function getXmlHttp()
{
    var xmlhttp;
    try
    {
        xmlhttp = new ActiveXObject('Msxml2.XMLHTTP');
    }
    catch(e)
    {
        try
        {
            xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
        }
        catch(e)
        {
            xmlhttp = false;
        }    
    }
    
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined')
    {
        xmlhttp = new XMLHttpRequest();
    }
    
    return xmlhttp;
}

function vote()
{
    var req = getXmlHttp();
    req.onreadystatechange = function()
    {
        if (req.readyState == 4)
        {
            if (req.status == 200)
            {
                var voteNumber = document.getElementById('voteNum');
                voteNumber.innerText = req.responseText;
            }
        }
    };
    req.open('post', '/vote.php', true);
    req.send;
}

window.onload = function ()
{
    
};
