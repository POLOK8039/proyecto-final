<?php
    require_once("../config.php");
    require_once("userFun.php");

    if (validateUser("ADMIN") && isset($_GET['num'])) {
        $num = $_GET['num'];
        
        if (disableUser($num)) {
            echo "user successfully disabled.";
        } else {
            echo "Error deactivating user.";
        }

        header("Location: index.php");
        exit();
    } else {
        echo "User code not provided.";
    }
?>