<?php
    require_once "../../config.php";

    function getUnitByCode($code) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_unitOfMeasure_info WHERE code = ?";
            $stmt = $db->prepare($query);
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("s", $code);
            $stmt->execute();
            $result = $stmt->get_result();
            $tag = $result->fetch_assoc();
    
            $stmt->close();
            return $tag;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $db->close();
        }
    }

    function getUnits() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_unitOfMeasure_info";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $db->close();
        }
    }

    function addUnit($code, $description) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL addUnit_of_measure(?, ?)");
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ss", $code, $description);

            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return true;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
        } finally {
            $db->close();
        }
    }

    function updateUnit($code, $description) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL updateUnit_of_measure(?, ?)");
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ss", $code, $description);

            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return true;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $db->close();
        }
    }

    /*function searchUnit($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM unit_of_measure WHERE code LIKE '%$search%'";
        $result = $db->query($query);
        
        $units = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $units[] = $row;
            }
        }
        
        return $units;
    }*/
?>