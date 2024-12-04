<?php
    require_once "../../config.php";

    function getZones() {
        $db = connectdb();
        
        try {
            $query = "SELECT * FROM vw_zone_info";
            $result = mysqli_query($db, $query);
            
            if (!$result) {
                throw new Exception("Database Query Error: " . mysqli_error($db));
            }
    
            $zones = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $zones[] = $row;
            }
    
            return $zones;
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => 'Error: ' . $e->getMessage()
            ];
        } finally {
            mysqli_close($db);
        }
    }

    function addPackagingInZone($zone){
        $db = connectdb();
        $trac = $_SESSION['trac'];
        $user = $_SESSION['num'];

        $query = "call addPackagingInZone('$zone', $trac, $user)";
        error_log($query);
        
        return  mysqli_query($db, $query);
    }

    function addZone($code, $area, $available_capacity, $total_capacity) {
        $db = connectdb();
        
        try {
            $stmt = $db->prepare("CALL addZone(?, ?, ?, ?)");
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ssii", $code, $area, $available_capacity, $total_capacity);
            $stmt->execute();
    
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
    
            return [
                'success' => $row['success'],
                'message' => $row['message']
            ];
    
        } catch (mysqli_sql_exception $e) {
            return [
                'success' => 0,
                'message' => 'An unexpected error occurred: ' . $e->getMessage()
            ];
    
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => 'An unexpected error occurred: ' . $e->getMessage()
            ];
    
        } finally {
            $stmt->close();
            $db->close();
        }
    }

?>