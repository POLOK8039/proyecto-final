<?php
    require_once("../../../config.php");
    require_once("zoneFun.php");

    if (isset($_GET['code'])) {
        $code = $_GET['code'];
        
        if (disableZone($code)) {
            echo "Zone deactivated successfully.";
        } else {
            echo "Error al desactivar la zona.";
        }

        header("Location: index.php");
        exit();
    } else {
        echo "Código de zona no proporcionado.";
    }
?>