<?php
    function StoreSurvey($arFields)
    {
        return file_put_contents(GetSurveyPath($arFields["email"]), serialize($arFields));
    }

    function ShowSurvey($arFields)
    {
        echo 'First Name: ' . $arFields['first_name'] . "\n";
        echo 'Last Name: ' . $arFields['last_name'] . "\n"; 
        echo 'Email: ' . $arFields['email'] . "\n";
        echo 'Age: ' . $arFields['age'] . "\n";
    }

    function FetchSurvey()
    {
    	$res = false;
    	$email = GetParam('email');
    	if (!empty($email))
		{
			$res =  array
	       	(
	           'first_name' => isset($_GET['first_name']) ? $_GET['first_name'] : '', 
	           'last_name' => isset($_GET['last_name']) ? $_GET['last_name'] : '', 
	           'email' => $email, 
	           'age' => isset($_GET['age']) ? $_GET['age'] : '',
			);
		}
		return $res;
    }

    function LoadSurvey($email)
    {
        $res = false;
		$filePath = GetSurveyPath($email);
        if (file_exists($filePath))
		{
			$survey = file_get_contents($filePath);
			$res = unserialize($survey);
		}
		return $res;
    }
	
	function GetSurveyPath($email)
	{
		return $_SERVER['DOCUMENT_ROOT'] . '/data/' . $email . '.txt';
	}