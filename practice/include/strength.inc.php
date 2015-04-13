<?php
    function CalcStrength($password)
    {
        $strength = 0;
        
        $strength += CalcLengthStrength($password);
        $strength += CalcDigitStrength($password);
        $strength += CalcUpperStrength($password);
        $strength += CalcLowerStrength($password);
	$strength += CalcOnlyDigitsStrength($password);
        $strength += CalcOnlyCharsStrength($password); 
        $strength += CalcRepeatStrength($password);

        return $strength;
    }

    function CalcLengthStrength($password)
    {
        return 4 * strlen($password);
    }

    function CalcDigitStrength($password)
    {
        $digitCount = 0;
        for ($i = 0; $i < strlen($password); $i++)
        {
            if (ctype_digit($password[$i])) $digitCount++;
        }
        return $digitCount * 4;
    }

    function CalcUpperStrength($password)
    {
        $upperCount = 0;
	$passLength = strlen($password);
        for ($i = 0; $i < $passLength; $i++)
        {
            if (ctype_upper($password[$i])) $upperCount++;
        }
        return $upperCount ? ($passLength - $upperCount) * 2 : 0;
    }

    function CalcLowerStrength($password)
    {
        $lowerCount = 0;
	$passLength = strlen($password);
        for ($i = 0; $i < $passLength; $i++)
        {
            if (ctype_upper($password[$i])) $lowerCount++;
        }
        return $lowerCount ? ($passLength - $lowerCount) * 2 : 0;
    }

    function CalcOnlyDigitsStrength($password)
    {
        return ctype_digit($password) ? -strlen($password) : 0;
    }

    function CalcOnlyCharsStrength($password)
    {
        return ctype_alpha($password) ? -strlen($password) : 0;
    }

    function CalcRepeatStrength($password)
    {
        $repeat = 0;
        for ($i = 0; $i < strlen($password); $i++)
	{
	    if (substr_count($password, $password[$i]) > 1)
	    {
	        $repeat--;
	    }
	}
        return $repeat;
    }

    function AllowedChars($password)
    {
        return ctype_alnum($password);
    }