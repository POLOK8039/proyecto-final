<?php

require_once "../../config.php";

session_start();

if(!validateUser("ADMIN", "SUPER")){
    header("Location: /");
    exit;
}


include HEAD;

crudRedirect(getAction(), "listMaterial.php", 
    "addMaterial.php", "editMaterial.php", "disableMaterial.php"
);

include FOOT;
?>