<?php
    validateUser("ALL");

    //session_start(); //esta comentado ya que en todas las pantallas sale un mensaje de error
    

if (isset($_SESSION['message'])) {
    $message = $_SESSION['message'];
    echo "<div class='div-msg' id='disp'>
            <span id='{$message['type']}-msg' class='msg'>{$message['text']}</span>
        </div>";

    unset($_SESSION['message']);
}
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Packaking System</title>
        <link rel="stylesheet" href="<?php echo CSS . "global.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "forms.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "sidebar.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "home.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "header.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "table.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "footer.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "processView.css" ?>">
    </head>
<body>
    <?php include ASIDE ?>
    