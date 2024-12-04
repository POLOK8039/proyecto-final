<?php
    require_once("../../config.php");
    require_once("protocolFun.php");

    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        
        if (disableProtocol($num)) {
            error_log("Protocol deactivated correctly.");
        } else {
            error_log("Error disabling protocol.");
        }
    } else {
        error_log("Protocol code not provided.");
    }

    header("Location: /protocols/protocol/");
    exit();
?>