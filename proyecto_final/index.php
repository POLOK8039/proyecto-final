<?php
    require_once "config.php";
    if(getAction() == 'logout'){
        logout();
    }
    include HEAD;
    include HOME;
    include FOOT;
?>