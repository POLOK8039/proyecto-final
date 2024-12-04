<?php
    require_once "../../../config.php";

    function getOuts() {
        $db = connectdb();
        
        try {
            $query = "SELECT * FROM vw_outbound_info;";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $outs = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $outs[] = $row;
            }
            
            return $outs;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }

    function getOutboundDateByNum($num) {
        $db = connectdb();
        
        try {
            $query = "SELECT date FROM vw_outbound_info WHERE num = ?";
            $stmt = mysqli_prepare($db, $query);
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            mysqli_stmt_bind_param($stmt, 'i', $num);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $outboundInfo = mysqli_fetch_assoc($result);
    
            if ($outboundInfo) {
                return $outboundInfo['date'];
            } else {
                return false;
            }
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
        } finally {
            mysqli_close($db);
        }
    }
    
    
    function getOutboundByNum($num) {
        $db = connectdb();
    
        try {
            echo "num: " . htmlspecialchars($num) . "<br>";
            $query = "SELECT num, package_quantity, zone FROM packaging WHERE outbound = '$num';";
            $result = mysqli_query($db, $query);
    
            if ($result === false) {
                throw new Exception('Query execution error: ' . htmlspecialchars(mysqli_error($db)));
            }
    
            $packaging = [];
            while ($pkg_row = mysqli_fetch_assoc($result)) {
                $packaging[] = $pkg_row;
            }
    
            if (empty($packaging)) {
                echo "No packaging found for this outbound.";
            }
    
            return $packaging;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            mysqli_close($db);
        }
    }
    
    

    function updateOutbound($num, $date, $packaging = []) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("UPDATE outbound SET date = ? WHERE num = ?");
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("si", $date, $num);
            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error)); 
            }

            if (!empty($packaging)) {
                $placeholders = implode(',', array_fill(0, count($packaging), '?'));
                $update_query = "UPDATE packaging SET outbound = NULL WHERE outbound = ? AND num NOT IN ($placeholders)";
                $update_stmt = $db->prepare($update_query);
    
                if ($update_stmt === false) {
                    throw new Exception('Update preparation error: ' . htmlspecialchars($db->error));
                }
    
                $params = array_merge([$num], $packaging);
                $types = str_repeat('i', count($params));
                $update_stmt->bind_param($types, ...$params);
    
                if (!$update_stmt->execute()) {
                    throw new Exception('Update execution error: ' . htmlspecialchars($update_stmt->error));
                }

                foreach ($packaging as $pkg_num) {
                    $update_query = "UPDATE packaging SET outbound = ? WHERE num = ?";
                    $update_stmt = $db->prepare($update_query);
                    if ($update_stmt === false) {
                        throw new Exception('Update preparation error: ' . htmlspecialchars($db->error));
                    }
    
                    $update_stmt->bind_param("ii", $num, $pkg_num);
                    if (!$update_stmt->execute()) {
                        throw new Exception('Update execution error: ' . htmlspecialchars($update_stmt->error));
                    }
                }
            } else {
                $update_query = "UPDATE packaging SET outbound = NULL WHERE outbound = ?";
                $update_stmt = $db->prepare($update_query);
                if ($update_stmt === false) {
                    throw new Exception('Update preparation error: ' . htmlspecialchars($db->error));
                }
    
                $update_stmt->bind_param("i", $num);
                if (!$update_stmt->execute()) {
                    throw new Exception('Update execution error: ' . htmlspecialchars($update_stmt->error));
                }
            }

            $count_query = "SELECT COUNT(*) AS total FROM packaging WHERE outbound = ?";
            $count_stmt = $db->prepare($count_query);
            if ($count_stmt === false) {
                throw new Exception('Count query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $count_stmt->bind_param("i", $num);
            $count_stmt->execute();
            $result = $count_stmt->get_result();
            $row = $result->fetch_assoc();
            $new_exit_quantity = $row['total'];
    
            $update_outbound_query = "UPDATE outbound SET exit_quantity = ? WHERE num = ?";
            $update_outbound_stmt = $db->prepare($update_outbound_query);
            if ($update_outbound_stmt === false) {
                throw new Exception('Outbound update preparation error: ' . htmlspecialchars($db->error));
            }
    
            $update_outbound_stmt->bind_param("ii", $new_exit_quantity, $num);
            if (!$update_outbound_stmt->execute()) {
                throw new Exception('Outbound update execution error: ' . htmlspecialchars($update_outbound_stmt->error));
            }

            if ($new_exit_quantity == 0) {
                $delete_query = "DELETE FROM outbound WHERE num = ?";
                $delete_stmt = $db->prepare($delete_query);
                if ($delete_stmt === false) {
                    throw new Exception('Delete query preparation error: ' . htmlspecialchars($db->error));
                }
    
                $delete_stmt->bind_param("i", $num);
                if (!$delete_stmt->execute()) {
                    throw new Exception('Delete execution error: ' . htmlspecialchars($delete_stmt->error));
                }
            }
    
            return true;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
        } finally {
            if (isset($stmt)) $stmt->close();
            if (isset($update_stmt)) $update_stmt->close();
            if (isset($count_stmt)) $count_stmt->close();
            if (isset($update_outbound_stmt)) $update_outbound_stmt->close();
            if (isset($delete_stmt)) $delete_stmt->close();
            $db->close();
        }
    }

    function disableOutbound($num) {
        $db = connectdb();
    
        try {
            $stmt = $db->prepare("CALL dropOutBound(?)");
            
            if ($stmt === false) {
                throw new Exception('Query preparation error: ' . htmlspecialchars($db->error));
            }
    
            $stmt->bind_param("i", $num);
    
            if (!$stmt->execute()) {
                throw new Exception('Execution error: ' . htmlspecialchars($stmt->error)); 
            }
    
            return true;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
    
        } finally {
            $stmt->close();
            mysqli_close($db);
        }
    }

    function getZones() {
        $db = connectdb();
        
        try {
            $query = "SELECT DISTINCT zone FROM packaging WHERE zone IS NOT NULL AND zone != ''";
            $result = $db->query($query);
            if (!$result) {
                throw new Exception("Query Error: " . $db->error);
            }
    
            $zones = [];
            while ($row = $result->fetch_assoc()) {
                $zones[] = $row['zone'];
            }
            return $zones;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return [];
        } finally {
            $db->close();
        }
    }

    function packagingByZone($zone) {
        $db = connectdb();
    
        try {
            $query = "SELECT num, package_quantity FROM packaging WHERE zone = ? AND outbound IS NULL";
            $stmt = $db->prepare($query);
            if (!$stmt) {
                throw new Exception("Preparation Error: " . $db->error);
            }
    
            $stmt->bind_param('s', $zone);
            $stmt->execute();
            $result = $stmt->get_result();
    
            $packaging = [];
            while ($row = $result->fetch_assoc()) {
                $packaging[] = $row;
            }
            return $packaging;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return [];
        } finally {
            $stmt->close();
            $db->close();
        }
    }

    function insertOutbound($date, $selected_packaging) {
        $db = connectdb();
    
        try {
            $query = "INSERT INTO outbound (date, exit_quantity) VALUES (?, ?)";
            $stmt = $db->prepare($query);
            $exit_quantity = count($selected_packaging);
            $stmt->bind_param('si', $date, $exit_quantity);
    
            if (!$stmt->execute()) {
                throw new Exception('Error during outbound registration: ' . htmlspecialchars($stmt->error));
            }
    
            $outbound_id = $stmt->insert_id;
    
            updatePackagingStatus($selected_packaging, $outbound_id);
    
            return $outbound_id;
    
        } catch (Exception $e) {
            echo 'Caught exception: ', $e->getMessage(), "\n";
            return false;
        } finally {
            $stmt->close();
            $db->close();
        }
    }
    
    function updatePackagingStatus($packaging_ids, $outbound_id) {
        $db = connectdb();
        $ids = implode(",", array_map('intval', $packaging_ids));
        $query = "UPDATE packaging SET outbound = ? WHERE num IN ($ids)";
        $stmt = $db->prepare($query);
        $stmt->bind_param('i', $outbound_id);
        $stmt->execute();
        $stmt->close();
        $db->close();
    }

    function getPackagingByZoneAndOutbound($zone, $outbound_num) {
        $db = connectdb();
        $query = "SELECT num, package_quantity, outbound FROM packaging  WHERE zone = ?";
        
        $stmt = $db->prepare($query);
        $stmt->bind_param('s', $zone);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $packaging = [];
        while ($row = $result->fetch_assoc()) {
            $packaging[] = $row;
        }
    
        $stmt->close();
        $db->close();
        return $packaging;
    }
    
    function getEditablePackagingByZoneAndOutbound($zone, $outbound_num) {
        $db = connectdb();
        $query = "SELECT num, package_quantity, outbound FROM packaging  WHERE zone = ? AND (outbound = ? OR outbound IS NULL)";
        
        $stmt = $db->prepare($query);
        $stmt->bind_param('si', $zone, $outbound_num);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $packaging = [];
        while ($row = $result->fetch_assoc()) {
            $packaging[] = $row;
        }
    
        $stmt->close();
        $db->close();
        return $packaging;
    }
    
?>