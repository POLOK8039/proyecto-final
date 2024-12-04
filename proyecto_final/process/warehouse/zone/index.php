<?php 
    $action = isset($_GET['a']) ? $_GET['a'] : null;

    require_once "../../../config.php";
    
    include HEAD;
    
    crudRedirect($action,
    "listZones.php", "addZone.php", "editZone.php", "disableZone.php"
);

    include FOOT;
?>