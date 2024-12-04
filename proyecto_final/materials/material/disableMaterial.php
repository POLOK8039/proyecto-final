<?php
    require_once("../../config.php");
    require_once("materialFun.php");

    if (isset($_GET['code'])) {
        $code = $_GET['code'];
        
        if (disableMaterial($code)) {
            echo "Material deactivated correctly.";
        } else {
            echo "Error disabling material.";
        }

        header("Location: index.php");
        exit();
    } else {
        echo "Code of material not provided.";
    }
?>