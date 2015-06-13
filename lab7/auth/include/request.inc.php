<?php
    function GetParam($paramName)
    {
        return (isset($_REQUEST[$paramName]))
            ? $_REQUEST[$paramName]
            : '';
    }

    function GetAllParams()
    {
        foreach ($_REQUEST as $name => $value)
        {
            $arParams[$name] = GetParam($name);
        }
        return $arParams;
    }