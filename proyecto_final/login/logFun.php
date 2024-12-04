<?php
require_once __DIR__ . "/../config.php";

//AGREGUE ESTE IF POR QUE ME SALIA ESTE ERROR:
//Notice: session_start(): Ignoring session_start() because a session is already active 
//if (session_status() === PHP_SESSION_NONE) {
//    session_start();
//}
function login($username, $password)
{
    $db = connectdb();
    $stmt = $db->prepare("call login(?,?)");
    
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();


    $result = $stmt->get_result();
    $bool = $result->num_rows > 0;
    if ($bool) {
        $user = $result->fetch_assoc();
        
        $_SESSION['num'] = $user['num'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['user_type'] = $user['user_type'];
    }   
    return $bool;
}

function logout(){
    session_start();

    session_unset();
    
    session_destroy();

    //delete the cookies
    //if (ini_get("session.use_cookies")) {
    //    $params = session_get_cookie_params();
    //    setcookie(session_name(), '', time() - 3600, $params["path"], $params["domain"], $params["secure"], $params["httponly"]);
    //}

    header("Location: /login/");
    exit;
}

function validateUser(string ...$validUsers){

    validateSession();
    
    error_log("Validating...".$_SESSION['user_type']);

    if($validUsers == "ALL"){
        return true;
    }

    return in_array($_SESSION['user_type'], $validUsers);
}
?>