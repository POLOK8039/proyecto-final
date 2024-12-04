<?php
    require_once "../../config.php";

    function getReports() {
        try {
            $db = connectdb();
            $query = "SELECT * FROM report";
            $result = mysqli_query($db, $query);
            $reports = [];
            while($row = mysqli_fetch_assoc($result)){
                $reports[] = $row;
            }
            mysqli_close($db);
            return $reports;
        } catch (Exception $e) {
            return false; 
        }
    }

    function getTraceabilities() {
        try {
            $db = connectdb();
            $query = "SELECT * FROM vw_traceability_info";
            $result = mysqli_query($db, $query);
            return $result;
        } catch (Exception $e) {
            return false;
        }
    }

    function addReport($start_date, $end_date, $report_date, $packed_products, $observations, $traceability) {
        try {
            $db = connectdb();
            if ($db === false) {
                throw new Exception('Database connection error: '. htmlspecialchars(mysqli_connect_error()));
            }
    
            $stmt = $db->prepare("CALL addReport(?,?,?,?,?,?)");
            if ($stmt === false) {
                throw new Exception('Error preparing the query: '. htmlspecialchars(mysqli_error($db)));
            }
    
            $stmt->bind_param("sssisi", $start_date, $end_date, $report_date, $packed_products, $observations, $traceability);
    
            $result = $stmt->execute();
            if ($result === false) {
                throw new Exception('Error executing the query: '. htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            $db->close();
    
            return $result;
    
        } catch (Exception $e) {
            return false;
        }
    }

    /*function searchReport($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM report WHERE folio = $search";
        $result = $db->query($query);
        
        $reports = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $reports[] = $row;
            }
        }
        
        return $reports;
    }*/
?>