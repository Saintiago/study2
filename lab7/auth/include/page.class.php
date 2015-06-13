<?php
    class Page
    {
        const TEMPLATE_DIR = TEMPLATE_DIR;
        
        private $userAuthenticated = false;
        private $userLoginFailed = false;
        private $userAuthErrorMessage = '';
        private $userLogin = '';
        private $template = '';
        private $vars = array();
        
        public function showPage()
        {
            echo $this->buildPage();
        }
        
        function __construct($template, $vars = array())
        {
            $user = new User;
            $user->checkAuth();
            $this->userAuthenticated = $user->isAuthenticated();
            $this->userLoginFailed = $user->isLoginFailed();
            $this->userAuthErrorMessage = $user->getErrorMessage();
            $this->userLogin = $user->getLogin();
            $this->template = $template;
            $this->vars = $vars;
            $user->storeUserInSession();
        }
        
        private function buildPage()
        {
            $auth = $this->getAuth();
            $header = $this->getView("header.html", $this->vars);
            $content = $this->getContent();
            $footer = $this->getView("footer.html", $this->vars);
            
            return $header . $auth . $content . $footer;
        }
        
        private function getView($template, $vars)
        {
            $smarty = new Smarty();
            $smarty->setTemplateDir(TEMPLATE_DIR);
            $smarty->setCompileDir(TEMPLATE_C_DIR);
            $smarty->assign($vars);
            
            $template = $this->TEMPLATE_DIR . $template;
        
            return $smarty->fetch($template);
        }
      
        private function getAuth()
        {
            if ($this->userAuthenticated)
            {
                $auth = $this->getView('hello.html', array("name" => $this->userLogin));
            }
            else
            {
                $authVars = array("error" => '');
                if ($this->userLoginFailed)
                {
                    $authVars['error'] = $this->userAuthErrorMessage;
                }
                $auth = $this->getView('loginForm.html', $authVars);
            }
            return $auth;
        }
        
        private function getContent()
        {
            return $this->userAuthenticated ? $this->getView($this->template, $this->vars) : '';
        }
    }