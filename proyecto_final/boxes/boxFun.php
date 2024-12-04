<?php
    require_once __DIR__."/../config.php";
    function addBox($height, $width, $length, $weight) {
        $db = connectdb();
        
        try {
            $stmt = $db->prepare("CALL addBox (?,?,?,?)");
            if ($stmt === false) {
                throw new Exception('Error en la preparación de la sentencia: ' . htmlspecialchars($db->error));
            }
            $stmt->bind_param("dddd", $height, $width, $length, $weight);

            $result = $stmt->execute();
            
            if ($result === false) {
                throw new Exception('Error al ejecutar la sentencia: ' . htmlspecialchars($stmt->error));
            }
            $stmt->close();
        } catch (Exception $e) {
            error_log($e->getMessage());
            return false;
        } finally {
            $db->close();
        }
        return $result;
    }
    function getBoxes() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_box_info;";
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

    function getBoxByNumber($num) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_box_info WHERE num = ?";
            $stmt = $db->prepare($query);
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("s", $num);
            $stmt->execute();
            $result = $stmt->get_result();
            $protocol = $result->fetch_assoc();
    
            $stmt->close();
            return $protocol;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return null;
    
        } finally {
            $db->close();
        }
    }

    function getBoxesByVol($volMin) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_box_info WHERE volume >= ?";
            $stmt = $db->prepare($query);
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("i", $volMin);
            $stmt->execute();
            $result = $stmt->get_result();
    
            $stmt->close();
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return null;
    
        } finally {
            $db->close();
        }
    }

function updateBox($num, $height, $width, $length, $weight) {
    $db = connectdb();
    
    try {
        $stmt = $db->prepare("CALL UpdateBox(?, ?, ?, ?, ?)");
        
        if ($stmt === false) {
            throw new Exception('Error en la preparación de la sentencia: ' . htmlspecialchars($db->error));
        }

        $stmt->bind_param("idddd", $num, $height, $width, $length, $weight);
        
        if (!$stmt->execute()) {
            throw new Exception('Error al ejecutar la sentencia: ' . htmlspecialchars($stmt->error));
        }
        
        $result = true;
        
        $stmt->close();
    } catch (Exception $e) {
        error_log($e->getMessage());
        $result = false;
    } finally {
        $db->close();
    }
    
    return $result; 
}

function disableBox($num) {
    $db = connectdb();

    try {
        $stmt = $db->prepare("CALL dropBox(?)");

        if ($stmt === false) {
            throw new Exception('Error en la preparación de la sentencia: ' . htmlspecialchars($db->error));
        }

        $stmt->bind_param("i", $num);

        if (!$stmt->execute()) {
            throw new Exception('Error al ejecutar la sentencia: ' . htmlspecialchars($stmt->error));
        }

        $result = true;
        
        $stmt->close();
    } catch (Exception $e) {
        error_log($e->getMessage());
        $result = false;
    } finally {
        $db->close();
    }

    return $result; 
}

        /*function searchBox($search){
            $db = connectdb();
            
            $search = $db->real_escape_string($search);

            $query = "SELECT * FROM box WHERE num = $search";
            $result = $db->query($query);
            
            $boxes = [];
            if ($result) {
                while ($row = $result->fetch_assoc()) {
                    $boxes[] = $row;
                }
            }
            
            return $boxes;
        }*/

?>