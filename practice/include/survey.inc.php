<?php
    function execAction($action)
    {
        $res = false;
        switch($action)
        {
            case 'store':
                $res = execStore();
                break;
            case 'show':
                $res = execShow();
                break;
            default:
                echo 'Неизвестная операция.' . "\n";
                break;
        }
        return $res;
    }
    
    function execStore()
    {
        $res = false;
        $email = GetParam('email');
        $fetchedSurvey = FetchSurvey
        (
            $email,
            GetParam('first_name'),
            GetParam('last_name'),
            GetParam('age')
        );
        if (is_array($fetchedSurvey))
        {
            $res = StoreSurvey($fetchedSurvey);
        }
        return $res;
    }
    
    function execShow()
    {
        $res = false;
        $id = GetParam('id');
        $survey = LoadSurveyById($id);
        $res = (count($survey) != 0);
        if (is_array($survey))
        {
            ShowSurvey($survey);
        }
        return $res;
    }

    function findDvd($title)
    {
        $title = dbQuote($title);
        $query = "SELECT * FROM dvd WHERE title LIKE '%{$title}%'";
        return dbSelect($query);
    }
    
    function StoreSurvey($arFields)
    {
        $result = false;
        if (is_array($arFields))
        {
            $existingSurvey = GetSurveyByEmail($arFields['email']);
            if (count($existingSurvey) == 0)
            {
                $query = "INSERT INTO survey (first_name, last_name, email, age) VALUES ";
                $query .= "('{$arFields[first_name]}', '{$arFields[last_name]}', '{$arFields[email]}', {$arFields[age]});";
                $result = dbInsert($query);    
            }
            
        }
        return $result;
    }
    
    function GetSurveyList()
    {
        $query = "SELECT * FROM survey";
        $surveys = dbSelect($query);
        $fetchedSurveys = array();
        foreach ($surveys as $key => $survey) 
        {
            $fetchedSurveys[] = FetchSurvey
            (
                $survey['email'],
                $survey['first_name'],
                $survey['last_name'],
                $survey['age'],
                $survey['survey_id']
            );
        }
        return $fetchedSurveys;
    }

    function ShowSurvey($arFields)
    {
        echo 'First Name: ' . $arFields['first_name'] . "\n";
        echo 'Last Name: ' . $arFields['last_name'] . "\n"; 
        echo 'Email: ' . $arFields['email'] . "\n";
        echo 'Age: ' . $arFields['age'] . "\n";
    }

    function FetchSurvey($email, $firstName = '', $lastName = '', $age = '', $id = '')
    {
    	$fetchedSurvey = array();
    	if (strlen($email) > 0)
		{
			$fetchedSurvey =  array
	       	(
	           'first_name' => $firstName, 
	           'last_name' => $lastName, 
	           'email' => $email, 
	           'age' => $age,
	           'id' => $id
			);
		}
		return $fetchedSurvey;
    }

    function LoadSurveyByEmail($email)
    {
        $survey = GetSurveyByEmail($email);
        $fetchedSurvey = array();
        if (count($survey) > 0)
        {
            $fetchedSurvey = FetchSurvey
            (
                $survey[0]['email'],
                $survey[0]['first_name'],
                $survey[0]['last_name'],
                $survey[0]['age']
            );
        }
        return $fetchedSurvey;
    }

    function LoadSurveyById($id)
    {
        $survey = GetSurveyById($id);
        $fetchedSurvey = array();
        if (count($survey) > 0)
        {
            $fetchedSurvey = FetchSurvey
            (
                $survey[0]['email'],
                $survey[0]['first_name'],
                $survey[0]['last_name'],
                $survey[0]['age']
            );
        }
        return $fetchedSurvey;
    }
    
    function GetSurveyByEmail($email)
    {
        $survey = array();
        if (strlen($email) > 0)
        {
            $email = dbQuote($email);
            $query = "SELECT * FROM survey WHERE email = '{$email}'";
            $survey = dbSelect($query);
        }
        return $survey;    
    }
    
    function GetSurveyById($id)
    {
        $survey = array();
        if (intval($id) > 0)
        {
            $email = dbQuote($id);
            $query = "SELECT * FROM survey WHERE survey_id = {$id}";
            $survey = dbSelect($query);
        }
        return $survey;    
    }
	
	function GetSurveyPath($email)
	{
		return $_SERVER['DOCUMENT_ROOT'] . '/practice/data/' . $email . '.txt';
	}