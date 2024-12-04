<?php
    session_start(); 
    require_once "../config.php";
    require_once "logFun.php";
    $msg = "We're so excited to see you again!";

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        $username = $_POST['username'];
        $password = $_POST['password'];
        
        if (login($username, $password)) {
            error_log("Login succesfull for ".$_SESSION['num']);
            header("Location: /");
            exit();
        } else {
            $msg = 'Username or password incorrect.';
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="<?php echo CSS . "global.css" ?>">
        <link rel="stylesheet" href="<?php echo CSS . "login.css" ?>">
    </head>
<body>
    <div id="msg" data-msg="<?php echo htmlspecialchars($msg); ?>"></div>
    <div class="container">
        <div class="login row">
            <div class="division col-6" id="leftDiv">
                <a class="div-link" id="link" href="#">
                    <img class="bi" id="toggleImage" src="<?php echo SVG . "closed-lock.svg"; ?>">
                </a>
                <h4 id="toggleText">Forgot password?</h4>
                <p id="paragraph">Select the icon for more information</p>
            </div>
            <div class="division col-6" id="rightDiv">
                <form action="" method="post">
                    <h2>Welcome back!</h2>
                    <p id="msgDisplay"><?php echo $msg ?></p>
                    <input class="form-control" id="username" name="username" type="text" autocomplete="off" required placeholder="User">
                    <input class="form-control" id="password" name="password" type="password" autocomplete="off" placeholder="Password">
                    <button class="btn-primary" type="submit">Login</button>
                </form>
            </div>
        </div>
    </div>
    <script src="<?php echo JS . "login.js" ?>"></script>
</body>
</html>