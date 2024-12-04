<?php
    require_once "../../../config.php";

    function getZones() {
        $db = connectdb();
        
        try {
            $query = "SELECT * FROM zone WHERE active = 1";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $zones = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $zones[] = $row;
            }
            
            return $zones;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return [];
    
        } finally {
            mysqli_close($db);
        }
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
    

    function getZoneByCode($code) {
        try {
            $db = connectdb();
            $query = "SELECT * FROM vw_zone_info WHERE code = '$code';";
            $result = mysqli_query($db, $query);
            if (!$result) {
                throw new Exception("Query failed: " . mysqli_error($db));
            }
            $zone = mysqli_fetch_assoc($result);
            mysqli_close($db);
            return $zone;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return null;
        }
    }

    function updateZone($code, $area, $available_capacity, $total_capacity) {
        $db = connectdb();
        
        try {
            $stmt = $db->prepare("CALL updateZone(?, ?, ?, ?)");
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ssii", $code, $area, $available_capacity, $total_capacity);
            $stmt->execute();

            if ($stmt->error) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            return [
                'success' => 1,
                'message' => 'Zone updated successfully.'
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
            if (isset($stmt) && $stmt instanceof mysqli_stmt) {
                $stmt->close();
            }
            $db->close();
        }
    }
    

    function disableZone($code) {
        $db = connectdb();
        
        try {
            $stmt = $db->prepare("CALL dropZone(?)");
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("s", $code);
            
            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            return [
                'success' => 1,
                'message' => 'Zone disabled successfully.'
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
            if (isset($stmt) && $stmt) {
                $stmt->close();
            }
            $db->close();
        }
    }

    /*function searchZone($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM zone WHERE code like '%$search%'";
        $result = $db->query($query);
        
        $zones = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $zones[] = $row;
            }
        }
        
        return $zones;
    }*/
?>