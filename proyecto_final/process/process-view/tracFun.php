<?php 

function getTraceabilities(){
    $db = connectdb();

    $query = "SELECT "
            ."ID, Product, Packaging_ID, State, Date "
        ."FROM vw_traceability_info";
    
    $result = $db->query($query);

    $data = [];

    while($row = $result->fetch_assoc()){
        $data [] = $row;
    }

    return $data;
}
function getTraceabilityByID($id){
    $db = connectdb();

    $query = "SELECT "
            ."ID, Product, Packaging_ID, State, Date "
        ."FROM vw_traceability_info WHERE ID = '$id'";
    
    $result = $db->query($query);

    $data = [];

    while($row = $result->fetch_assoc()){
        $data = $row;
    }

    return $data;
}

function getUsersInProcess($trac_id){
    $db = connectdb();

    $query = "SELECT User_ID, User_Name FROM vw_users_in_process "
        ."WHERE Traceability_ID = $trac_id";

    $result = $db->query($query);

    $users = [];

    while($row = $result->fetch_assoc()){
        $users[] = $row;
    }

    return $users;
}
function getProcessByID($id){
    $db = connectdb();

    $query = "SELECT * FROM vw_process WHERE Traceability = $id";
    
    $result = $db->query($query);

    $data = [];

    while($row = $result->fetch_assoc()){
        $data = $row;
    }

    return $data;
}
function startProcess(){
    $db = connectdb();

    session_start();
    $user = $_SESSION['num'];
    error_log("Sesion: ".$user);
    $query = "call startProcess($user)";
    error_log("query: ".$query);

    $result = mysqli_query($db, $query);

    while ($row = $result->fetch_assoc()) {
        $data = [
            'Traceability' => $row['Traceability'],
            'Packaging' => $row['Packaging']
        ];
    }

    if(isset($data)){
        return $data;
    } else {
        return false;
    }
}

function printNull($data){
    return $data ?? '--';
}

function getCodeFromTraceabilityByProcess($tr) {
    $db = connectdb();

    $stmt = $db->prepare("
        SELECT State
        FROM vw_process 
        WHERE Traceability = ?
    ");
    $stmt->bind_param("i", $tr);
    $stmt->execute();
    $result = $stmt->get_result();

    $validStates = [
        'START' => 'Starting Process',
        'PACKG' => 'Packing Products',
        'WARHS' => 'In Warehouse'
    ];

    if ($row = $result->fetch_assoc()) {
        $stateDescription = $row['State'];
        
        foreach ($validStates as $code => $description) {
            if ($description === $stateDescription) {
                return $code;
            }
        }
    }

    return null;
}

?>