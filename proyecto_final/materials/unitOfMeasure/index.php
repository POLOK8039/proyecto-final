<?php

require_once "../../config.php";

session_start();

if(!validateUser("ADMIN", "SUPER")){
    header("Location: /");
    exit;
}


include HEAD;

crudRedirect(getAction(), "listUnit.php", 
    "addUnit.php", "editUnit.php"
);

include FOOT;
?>