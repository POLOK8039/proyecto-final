<?php
    require_once "../../config.php";

    function getTagByNumber($num) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_tag_info WHERE num = '$num';";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $tag = mysqli_fetch_assoc($result);
            return $tag;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }

    function getTags() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_tag_info";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $tags = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $tags[] = $row;
            }
            return $tags;
    
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
    

    function addTag($date, $tag_type, $destination) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL addTag(?, ?, ?, @tag_num)");
            if ($stmt === false) {
                throw new Exception('Error preparing statement: ' . $db->error);
            }

            $stmt->bind_param("sss", $date, $tag_type, $destination);

            if (!$stmt->execute()) {
                throw new Exception('Error executing statement: ' . $stmt->error);
            }
    
            $stmt->close();

            $result = $db->query("SELECT @tag_num AS tag_num");
            if ($result === false) {
                throw new Exception('Error retrieving output parameter: ' . $db->error);
            }
    
            $row = $result->fetch_assoc();
            return [
                'success' => 1,
                'tag_num' => $row['tag_num']
            ];
    
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => $e->getMessage()
            ];
    
        } finally {
            $db->close();
        }
    }
    

    function updateTag($num, $date, $tag_type, $destination) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL UpdateTag(?,?,?,?)");
            if ($stmt === false) {
                throw new Exception('Error in preparing the query: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("isss", $num, $date, $tag_type, $destination);
    
            $result = $stmt->execute();
    
            if (!$result) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            return $result;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            if (isset($stmt)) {
                $stmt->close();
            }
            mysqli_close($db);
        }
    }

    /*function searchTag($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);
    
        $query = "SELECT * FROM tag WHERE date LIKE '%$search%';";
        $result = $db->query($query);
        
        $tags = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $tags[] = $row;
            }
        }
        
        return $tags;
    }*/
    
?>