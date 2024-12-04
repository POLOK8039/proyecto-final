<?php
    require_once "../../config.php";

    function addIncident($date, $description, $traceability) {
        try {
            $db = connectdb();
            $stmt = $db->prepare("CALL addIncident(?, ?, ?)");
            $stmt->bind_param("sss", $date, $description, $traceability);
            return $stmt->execute();
        } catch (Exception $e) {
            echo "Error occurred: " . $e->getMessage();
        }
    }

    function getIncident() {
        try {
            $db = connectdb();
            $query = "SELECT * FROM vw_incident_info";
            $result = mysqli_query($db, $query);
            $incidents = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $incidents[] = $row;
            }
            mysqli_close($db);
            return $incidents;
        } catch (Exception $e) {
            echo "Error occurred: " . $e->getMessage();
        }
    }

    function getTraceabilityIncident() {
        try {
            $db = connectdb();
            $query = "SELECT * FROM vw_traceability_info";
            $result = mysqli_query($db, $query);
            if (!$result) {
                throw new Exception('Query error: ' . mysqli_error($db));
            }
            $traceabilities = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $traceabilities[] = $row;
            }
            mysqli_close($db);
            return $traceabilities;
        } catch (Exception $e) {
            echo "Error occurred: " . $e->getMessage();
        }
    }
    
    function getIncidentByNumber($num) {
        try {
            $db = connectdb();
            $stmt = $db->prepare("SELECT * FROM vw_incident_info WHERE num = ?");
            $stmt->bind_param("s", $num);
            $stmt->execute();
            $result = $stmt->get_result();
            $incident = $result->fetch_assoc();
            $stmt->close();
            return $incident;
        } catch (Exception $e) {
            echo "Error occurred: " . $e->getMessage();
        } finally {
            mysqli_close($db);
        }
    }

    //num, date, description, traceability
    function updateIncident($num, $date, $description, $traceability) {
        $db = connectdb();
        
        $stmt = $db->prepare("CALL UpdateIncident(?, ?, ?, ?)");
        
        if ($stmt === false) {
            die('Query preparation error: ' . htmlspecialchars($db->error));
        }
    
        // Vincular los parámetros
        $stmt->bind_param("issi", $num, $date, $description, $traceability);
        
        // Ejecutar el procedimiento
        if ($stmt->execute()) {
            $result = true; 
        } else {
            $result = false;
            echo "Execution error: " . htmlspecialchars($stmt->error); 
        }
        
        $stmt->close();
        $db->close();
        
        return $result; 
    }
?>