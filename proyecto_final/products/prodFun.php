<?php
require_once __DIR__."/../config.php";
function addProduct($code, $name, $description, $height, $width, $length, $weight, $packaging_protocol) {
    $db = connectdb();

    try {
        $stmt = $db->prepare("CALL addProduct(?, ?, ?, ?, ?, ?, ?, ?)");
        if ($stmt === false) {
            throw new Exception('Error preparing statement: ' . htmlspecialchars($db->error));
        }

        $stmt->bind_param("sssddddi", $code, $name, $description, $height, $width, $length, $weight, $packaging_protocol);

        $result = $stmt->execute();
        if ($result === false) {
            throw new Exception('Error executing statement: ' . htmlspecialchars($stmt->error));
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



function getProducts() {
    $db = connectdb();
    
    try {
        $query = "SELECT * FROM vw_product_info;";
        $result = mysqli_query($db, $query);

        if ($result === false) {
            throw new Exception('Error en la ejecución de la consulta: ' . htmlspecialchars(mysqli_error($db)));
        }

        $products = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $products[] = $row;
        }

        return $products;

    } catch (Exception $e) {
        return [
            'success' => 0,
            'message' => 'Ocurrió un error al obtener los productos: ' . $e->getMessage()
        ];

    } finally {
        mysqli_close($db);
    }
}

function getProtocols() {
    $db = connectdb();

    try {
        $query = "SELECT * FROM vw_packaging_protocol_info;";
        $result = mysqli_query($db, $query);

        if ($result === false) {
            throw new Exception('Query execution error: ' . mysqli_error($db));
        }

        return $result;

    } catch (Exception $e) {
        echo "Error: " . $e->getMessage();
        return false;

    } finally {
        mysqli_close($db);
    }
}


function getProductByCode($code) {
    try {
        $db = connectdb();
        $query = "SELECT * FROM vw_product_info WHERE code = '$code';";
        $result = mysqli_query($db, $query);

        if (!$result) {
            throw new Exception('Error en la consulta: ' . mysqli_error($db));
        }

        $product = mysqli_fetch_assoc($result);
        mysqli_close($db);
        return $product;
    } catch (Exception $e) {
        error_log($e->getMessage());
        return false;
    }
}

function updateProduct($code, $name, $description, $height, $width, $length, $weight, $packaging_protocol) {
    try {
        $db = connectdb();
        $stmt = $db->prepare("CALL UpdateProduct (?,?,?,?,?,?,?,?)");
        if ($stmt === false) {
            return false;
        }
        $stmt->bind_param("sssddddi", $code, $name, $description, $height, $width, $length, $weight, $packaging_protocol);
        if (!$stmt->execute()) {
            return false;
        }
        $stmt->close();
        $db->close();
    } catch (Exception $e) {
        return false;
    }
    return true;
}

function disableProduct($code) {
    try {
        $db = connectdb();
        $stmt = $db->prepare("CALL dropProduct(?)");
        if ($stmt === false) {
            return false;
        }
        $stmt->bind_param("s", $code);
        if (!$stmt->execute()) {
            return false;
        }
        $stmt->close();
        $db->close();
    } catch (Exception $e) {
        return false;
    }
    return true;
}

/*function searchProduct($search){
    $db = connectdb();
    
    $search = $db->real_escape_string($search);

    $query = "SELECT * FROM product WHERE code like '%$search%'";
    $result = $db->query($query);
    
    $products = [];
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }
    
    return $products;
}*/

?>