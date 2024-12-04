<?php
    require_once "../../config.php";
    function addMaterial($code, $name, $description, $available_quantity, $unit_of_measure) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL addMaterial(?, ?, ?, ?, ?)");
            if ($stmt === false) {
                throw new Exception('Error preparing statement: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("sssis", $code, $name, $description, $available_quantity, $unit_of_measure);
            $result = $stmt->execute();
            
            if ($result === false) {
                throw new Exception('Error executing statement: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ',  $e->getMessage(), "\n";
            return false;
        } finally {
            $db->close();
        }
    }

    function getMaterial() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_material_info;";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $materials = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $materials[] = $row;
            }
    
            return $materials;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return null;
    
        } finally {
            mysqli_close($db);
        }
    }

function getUnitMeasure() {
    $db = connectdb();

    try {
        $query = "SELECT * FROM vw_unitOfMeasure_info;";
        $result = mysqli_query($db, $query);

        if ($result === false) {
            throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
        }

        return $result;

    } catch (Exception $e) {
        echo 'Caught exception: ', $e->getMessage(), "\n";
        return null;

    } finally {
        $db->close();
    }
}

function getMaterialByCode($code) {
    $db = connectdb();

    try {
        $query = "SELECT * FROM vw_material_info WHERE code = '$code';";
        $result = mysqli_query($db, $query);

        if ($result === false) {
            throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
        }

        $material = mysqli_fetch_assoc($result);
        return $material;

    } catch (Exception $e) {
        echo 'Caught exception: ', $e->getMessage(), "\n";
        return null;

    } finally {
        mysqli_close($db);
    }
}

    function updateMaterial($code, $name, $description, $available_quantity, $active, $unit_of_measure) {
        $db = connectdb();
        try {
            $stmt = $db->prepare("CALL UpdateMaterial(?, ?, ?, ?, ?, ?)");
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
            
            $stmt->bind_param("sssiis", $code, $name, $description, $available_quantity, $active, $unit_of_measure);
            
            $result = $stmt->execute();
            
            if ($result) {
                $resultMessage = $stmt->get_result();
                if ($resultMessage) {
                    $row = $resultMessage->fetch_assoc();
                    return [
                        'success' => $row['success'],
                        'message' => $row['message']
                    ];
                } else {
                    return [
                        'success' => 0,
                        'message' => 'No response was obtained from the procedure.'
                    ];
                }
            } else {
                return [
                    'success' => 0,
                    'message' => 'Error in the execution of the procedure.'
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => $e->getMessage()
            ];
        } finally {
            $stmt->close();
            $db->close();
        }
    }

    function disableMaterial($code) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL dropMaterial(?)");
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("s", $code);

            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return true;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false; // Return false or handle the error as needed
    
        } finally {
            $db->close();
        }
    }

    /*function searchMaterial($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM material WHERE code LIKE '%$search%'";
        $result = $db->query($query);
        
        $materials = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $materials[] = $row;
            }
        }
        
        return $materials;
    }*/
?>