<?php
    require_once "../../config.php";

    function getTagTypeByCode($code) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_tag_type_info WHERE code = '$code';";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $tagType = mysqli_fetch_assoc($result);
            return $tagType;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    

    function getTagTypes() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_tag_type_info";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Error retrieving tag types: ' . mysqli_error($db));
            }
    
            return $result;
    
        } catch (Exception $e) {
            echo "<p>Error: " . $e->getMessage() . "</p>";
            return false;
        } finally {
            mysqli_close($db);
        }
    }

    function addTagType($code, $description) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL addTagType(?, ?)");
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ss", $code, $description);
    
            $result = $stmt->execute();
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $db->close();
        }
    }

    function updateTagType($code, $description) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL UpdateTagType(?, ?)");
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ss", $code, $description);
    
            $result = $stmt->execute();
    
            if (!$result) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $db->close();
        }
    }    

    /*function searchTagType($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM tag_type WHERE code LIKE '%$search%'";
        $result = $db->query($query);
        
        $tag_types = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $tag_types[] = $row;
            }
        }
        
        return $tag_types;
    }*/
?>