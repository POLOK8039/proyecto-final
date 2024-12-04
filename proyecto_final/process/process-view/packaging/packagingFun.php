<?php
    require_once "../../config.php";
    require_once __DIR__."/../../../materials/material/materialFun.php";
    require_once __DIR__."/../tracFun.php";

    function getPackagings() {
        $db = connectdb();
        $packagings = [];
        
        try {
            $query = "SELECT * FROM vw_packaging_info";
            $result = $db->query($query);
            
            if ($result === false) {
                throw new Exception("Error executing query: " . $db->error);
            }
            
            while ($row = $result->fetch_assoc()) {
                $packagings[] = $row;
            }
        } catch (Exception $e) {
            error_log ("Error occurred: " . $e->getMessage());
        } finally {
            mysqli_close($db);
        }
    
        return $packagings;
    }

    function getAvailableMaterial($packaging) {
        $db = connectdb();
    
        try {
            $query = "call availableMaterial($packaging)";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $frozono = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $frozono[] = $row;
            }
    
            return $frozono;
    
        } catch (Exception $e) {
            error_log('Caught exception: '.$e->getMessage());
            return null;
    
        } finally {
            mysqli_close($db);
        }
    }


    function startPackaging($destination){
        $db = connectdb();

        $trac = $_SESSION['trac'];
        $user = $_SESSION['num'];

        $query = "call startPackaging(?, ?, ?);";

        $stmt = $db->prepare($query);

        $stmt->bind_param("sii", $destination, $trac, $user);

        error_log("QUERY: $query");
        error_log("PARAMS: $destination, $user, $trac");

        try {
            $result = $stmt->execute();
            $_SESSION['Destination'] = $destination;
            return $result;
        } catch (\Throwable $th) {
            error_log("ERROR: ".$th->getMessage());
            return false;
        }
    }
    function addPackagesQuan($quantity){
        $db = connectdb();

        $trac = $_SESSION['trac'];
        $user = $_SESSION['num'];

        $query = "call add_packaging_quantity(?, ?, ?);";

        $stmt = $db->prepare($query);

        $stmt->bind_param("iii", $quantity, $user, $trac);

        error_log("QUERY: $query");
        error_log("PARAMS: $quantity, $user, $trac");

        try {
            return $stmt->execute();
        } catch (\Throwable $th) {
            error_log("ERROR: ".$th->getMessage());
            return false;
        }
    }

    function addMaterialToPackaging($material, $packaging, $quantity){
        $db = connectdb();
        $query = "call addMaterialToPackaging('$material', $packaging, $quantity)";

        error_log("QUERY Material: $query");
        return mysqli_query($db, $query);
    }

    function getMaterialsInPackaging(){
        $db = connectdb();


        $packaging = getTraceabilityByID($_SESSION['trac'])['ID'];

        $query="SELECT * FROM vw_material_process WHERE Packaging = $packaging;";
        error_log("QUERY: $query");
        $result = $db->query($query);

        $rows = []; 
        
        while ($row = $result->fetch_assoc()) {
            $rows[] = $row; 
        }
    
        return $rows; 
    }
    function addPackaging($code, $height, $width, $length, $weight, $package_quantity, $zone, $tag) {
        $db = connectdb();
        try {
            $stmt = $db->prepare("CALL addPackaging(?, ?, ?, ?, ?, ?, ?, ?)");
            if ($stmt === false) {
                throw new Exception("Error preparing statement: " . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("sddddisi", $code, $height, $width, $length, $weight, $package_quantity, $zone, $tag);
            $stmt->execute();
    
            $result = $stmt->get_result();
            if ($result) {
                $row = $result->fetch_assoc();
                return [
                    'success' => $row['success'],
                    'message' => $row['message']
                ];
            } else {
                throw new Exception("No result returned from procedure.");
            }
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => 'Error: ' . $e->getMessage()
            ];
        } finally {
            if (isset($stmt)) {
                $stmt->close();
            }
            mysqli_close($db);
        }
    }
    

    function getZones() {
        $db = connectdb();
        $query = "SELECT * FROM zone";

        return $result = mysqli_query($db, $query);
    }

    function getTags() {
        $db = connectdb();
        $query = "SELECT * FROM tag";

        return $result = mysqli_query($db, $query);
    }

    function getOuts() {
        $db = connectdb();
    
        try {
            $query = "SELECT * FROM vw_outbound_info";
            $result = mysqli_query($db, $query);
            
            if (!$result) {
                throw new Exception("Database Query Error: " . mysqli_error($db));
            }
    
            $outs = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $outs[] = $row;
            }
    
            return $outs;
        } catch (Exception $e) {
            return [
                'success' => 0,
                'message' => 'Error: ' . $e->getMessage()
            ];
        } finally {
            mysqli_close($db);
        }
    }
?>