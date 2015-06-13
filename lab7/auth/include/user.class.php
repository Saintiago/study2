<?php
    
    class User
    {
        private $ERROR_MESSAGE = "Authentification error";
        private $login = '';
        private $isAuthenticated = false;
        private $failedLogin = false;
        
        function __construct()
        {
            $logout = GetParam('logout');
            if (strlen($logout) > 0)
            {
                $this->logout();
            }
            else
            {
                $this->getUserFromSession();
            }
        }
        
        public function getLogin()
        {
            return $this->login;
        }
        
        public function getErrorMessage()
        {
            return $this->ERROR_MESSAGE;
        }
        
        public function isLoginFailed()
        {
            return $this->failedLogin;
        }
        
        public function isAuthenticated()
        {
            return $this->isAuthenticated;
        }
        
        public function checkAuth()
        {
            $login = GetParam('login');
            if (strlen($login) > 0)
            {
                $password = GetParam('password');
                $this->failedLogin = true;
                $rightPassword = $this->getPasswordByLogin($login);
                if (strlen($rightPassword) > 0 && $rightPassword == $password)
                {
                    $this->authenticate($login);
                    $this->failedLogin = false;
                }
            }
        }
        
        public function storeUserInSession()
        {
            $_SESSION['authenticated'] = $this->isAuthenticated;
            $_SESSION['login'] = $this->login;
        }
        
        private function logout()
        {
            $this->isAuthenticated = false;
        }
        
        private function authenticate($login)
        {
            $this->isAuthenticated = true;
            $this->login = $login;
        }
        
        private function getUserFromSession()
        {
            $this->isAuthenticated = ($_SESSION['authenticated']) ? $_SESSION['authenticated'] : false;
            $this->login = ($_SESSION['login']) ? $_SESSION['login'] : '';
            $this->failedLogin = ($_SESSION['failedLogin']) ? $_SESSION['failedLogin'] : false;
        }
        
        private function getPasswordByLogin($login)
        {
            $password = '';
            $login = dbQuote($login);
            $query = "SELECT * FROM user WHERE login = '{$login}'";
            $user = dbSelect($query);
            $password = $user[0]['password'];
            return $password;
        }
    }
