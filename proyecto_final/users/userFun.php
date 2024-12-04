<?php
    require_once "../config.php";
    function addUser ($username, $password, $name, $firstSurname, $secondSurname, $dateOfBirth, $neighborhood, $street, $postalCode, $phone, $email, $userType, $supervisor) {
        $db = connectdb();
        
        // Valores nulos
        $secondSurname = empty($secondSurname) ? null : $secondSurname;
        $dateOfBirth = empty($dateOfBirth) ? null : $dateOfBirth;
        $neighborhood = empty($neighborhood) ? null : $neighborhood;
        $street = empty($street) ? null : $street;
        $postalCode = empty($postalCode) ? null : $postalCode;
        $phone = empty($phone) ? null : $phone;
        $email = empty($email) ? null : $email;
        $userType = empty($userType) ? null : $userType;
        $supervisor = empty($supervisor) ? null : $supervisor;
    
        try {
            $stmt = $db->prepare("CALL addUser (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            if ($stmt === false) {
                throw new Exception('Error en la preparación de la consulta: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("ssssssssisssi", $username, $password, $name, $firstSurname, $secondSurname, $dateOfBirth, $neighborhood, $street, $postalCode, $phone, $email, $userType, $supervisor);
    
            $result = $stmt->execute();
            $stmt->close();
            $db->close();
    
            return $result;
        } catch (Exception $e) {
            // Manejo de excepciones
            error_log('Excepción capturada: '. $e->getMessage());
            return false; // O maneja el error de otra manera según sea necesario
        }
    }
    
    function getUsers() {
        if(validateUser("SUPER")): 
            $db = connectdb();
    
            try {
                $query = "SELECT * FROM vw_user_personal_info WHERE user='employee';";
                $result = mysqli_query($db, $query);
        
                if ($result === false) {
                    throw new Exception('Error retrieving users: ' . mysqli_error($db));
                }
        
                $users = [];
                while ($row = mysqli_fetch_assoc($result)) {
                    $users[] = $row;
                }
        
                return $users;
        
            } catch (Exception $e) {
                echo "<p>Error: " . $e->getMessage() . "</p>";
                return false;
        
            } finally {
                mysqli_close($db);
            }

        endif; 
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_user_personal_info;";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Error retrieving users: ' . mysqli_error($db));
            }
    
            $users = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $users[] = $row;
            }
    
            return $users;
    
        } catch (Exception $e) {
            echo "<p>Error: " . $e->getMessage() . "</p>";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    

    function getUserTypes() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_user_type_info;";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Error retrieving user types: ' . mysqli_error($db));
            }
    
            return $result;
    
        } catch (Exception $e) {
            echo "<p>Error: " . $e->getMessage() . "</p>";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    
    function getSupervisors() {
        $db = connectdb();
    
        try {
            $query = "SELECT num, full_name FROM vw_supervisor;";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Error retrieving supervisors: ' . mysqli_error($db));
            }
    
            return $result;
    
        } catch (Exception $e) {
            echo "<p>Error: " . $e->getMessage() . "</p>";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    

    function getUserByNumber($num) {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_user_edit_info WHERE num = '$num';";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Error retrieving user: ' . mysqli_error($db));
            }
    
            $user = mysqli_fetch_assoc($result);
            return $user;
    
        } catch (Exception $e) {
            echo "<p>Error: " . $e->getMessage() . "</p>";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    

    function updateUser ($num, $username, $password, $name, $firstSurname, $secondSurname, $dateOfBirth, $neighborhood, $street, $postalCode, $phone, $email, $userType, $supervisor) {
        $db = connectdb();
    
        // Valores nulos
        $secondSurname = empty($secondSurname) ? null : $secondSurname;
        $dateOfBirth = empty($dateOfBirth) ? null : $dateOfBirth;
        $neighborhood = empty($neighborhood) ? null : $neighborhood;
        $street = empty($street) ? null : $street;
        $postalCode = empty($postalCode) ? null : $postalCode;
        $phone = empty($phone) ? null : $phone;
        $email = empty($email) ? null : $email;
        $userType = empty($userType) ? null : $userType;
        $supervisor = empty($supervisor) ? null : $supervisor;
    
        try {
            $stmt = $db->prepare("CALL UpdateUser (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    
            if ($stmt === false) {
                throw new Exception('Error en la preparación de la consulta: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("issssssssisssi", $num, $username, $password, $name, $firstSurname, $secondSurname, $dateOfBirth, $neighborhood, $street, $postalCode, $phone, $email, $userType, $supervisor);
    
            $result = $stmt->execute();
            if (!$result) {
                throw new Exception("Error en la ejecución: " . htmlspecialchars($stmt->error));
            }
    
            $stmt->close();
            $db->close();
    
            return $result;
        } catch (Exception $e) {
            // Manejo de excepciones
            echo 'Excepción capturada: ',  $e->getMessage(), "\n";
            return false; // O maneja el error de otra manera según sea necesario
        }
    }
    
    function disableUser($num) {
        $db = connectdb();
        
        try {
            $stmt = $db->prepare("CALL dropUser(?)");
    
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("i", $num);
    
            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error));
            }
    
            return true;
            
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return false;
        
        } finally {
            if (isset($stmt) && $stmt instanceof mysqli_stmt) {
                $stmt->close();
            }
            if (isset($db) && $db instanceof mysqli) {
                $db->close();
            }
        }
    }
    
    


    /*function searchUser($search){
        $db = connectdb();
        
        $search = $db->real_escape_string($search);

        $query = "SELECT * FROM vw_user_personal_info WHERE num = $search";
        $result = $db->query($query);
        
        $users = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $users[] = $row;
            }
        }
        
        return $users;
    }*/
?>