<?php
    require_once("../config.php");
    require "userFun.php";
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    $supervisors = getSupervisors();
    $userTypes = getUserTypes();

    if (isset($_GET['num'])) {
        $num = $_GET['num'];
        $user = getUserByNumber($num);

        if (!$user) {
            echo "User not found";
            exit;
        }
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $name = $_POST['name'];
        $first_surname = $_POST['first_surname'];
        
        //
        $second_surname = empty($_POST['second_surname']) ? NULL : $_POST['second_surname'];
        $date = empty($_POST['date']) ? NULL : $_POST['date'];
        $neighborhood = empty($_POST['neighborhood']) ? NULL : $_POST['neighborhood'];
        $street = empty($_POST['street']) ? NULL : $_POST['street'];
        $postal_code = empty($_POST['postal_code']) ? NULL : $_POST['postal_code'];
        $phone = empty($_POST['phone']) ? NULL : $_POST['phone'];
        $email = empty($_POST['email']) ? NULL : $_POST['email'];

        $user_type = empty($_POST['user_type']) ? NULL : $_POST['user_type'];
        $supervisor = empty($_POST['supervisor']) ? NULL : $_POST['supervisor'];

        if (updateUser(num:$num, username: $username, password: $password, name: $name, firstSurname: $first_surname, secondSurname: $second_surname, dateOfBirth: $date, neighborhood: $neighborhood, street: $street, postalCode: $postal_code, phone: $phone, email: $email, userType: $user_type, supervisor: $supervisor)) {
            echo "<div class='div-msg' id='success-msg'><span class='msg'>Usuario actualizado con éxito.</span></div>";

        } else {
            echo "<div class='div-msg' id='success-msg'><span class='msg'>Error al actualizar el producto.</span></div>";
        }



        header("Location: index.php");
        exit();
    }
?>
<head>
    <script src="userForm.js"></script>
</head>

<main class="forms">
        <div class="background">
            <form class="form" action="" method="post" autocomplete="off">
                
                <header class="header">
                    <img src="<?php  echo SVG . "icon.svg" ?>">
                    <h1>Edit Users</h1>
                </header>

                <?php if(validateUser("ADMIN")):?>
                    <a class="btn-primary" href="?a=del&num=<?php echo $user['num']; ?>" onclick="return confirm('Are you sure you want to disable this user?');">Disable</a>
                <?php endif; ?>
                <hr>
                <h2>Profile</h2>
                <div class="rows">
                    <div class="row-lg-10">
                        <h4 for="name">Name</h4>
                        <div class="inputs">
                        <input type="text" id="name" name="name"  maxlength="50"  value="<?php echo $user['name']; ?>" required>
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="first_surname">First Surname</h4>
                        <div class="inputs">
                        <input type="text" id="first_surname" name="first_surname" maxlength="30" value="<?php echo $user['first_surname']; ?>" required>
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="second_surname">Second Surname</h4>
                        <div class="inputs">
                        <input type="text" id="second_surname" name="second_surname" maxlength="30" value="<?php echo $user['second_surname']; ?>">
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="date">Date of Birth</h4>
                        <div class="inputs">
                        <input type="date" id="date" name="date" value="<?php echo $user['date_of_birth']; ?>" required>
                        </div>
                    </div>
                </div>
                
                <hr>
                <h2>Access Credentials</h2>
                <div class="rows">
                    <div class="row-lg-10">
                        <h4 for="username">User</h4>
                        <div class="inputs">
                            <input type="text" id="username" name="username" maxlength="30" value="<?php echo $user['username']; ?>" required>
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="email">Email</h4>
                        <div class="inputs">
                        <input type="email" id="email" name="email" maxlength="30" value="<?php echo $user['email']; ?>" required>
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="phone">Phone number</h4>
                        <div class="inputs">
                        <input type="text" id="phone" name="phone" maxlength="15" value="<?php echo $user['phone']; ?>" required>
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="password">Password</h4>
                        <div class="inputs">
                        <input type="text" id="password" name="password" maxlength="40" value="<?php echo $user['password']; ?>" required>
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="user_type">User type</h4>
                            <select class="inputs" id="user_type" name="user_type" required>
                                <?php
                                    while ($type = mysqli_fetch_assoc($userTypes)) {
                                        $selected = $user['user_type'] === $type['code'] ? 'selected' : '';
                                        echo "<option value='{$type['code']}' $selected>{$type['name']}</option>";
                                    }
                                ?>
                            </select>
                    </div>
                    <div class="row-md-5">
                        <h4 for="supervisor">Supervisor</h4>
                        <select class="inputs" id="supervisor" name="supervisor" required>
                            <?php 
                                while ($supervisor = mysqli_fetch_assoc($supervisors)) {
                                    $selected = $user['supervisor'] === $supervisor['num'] ? 'selected' : '';
                                    echo "<option value='{$supervisor['num']}' $selected>{$supervisor['full_name']}</option>";
                                }
                            ?>
                        </select>
                    </div>
                </div>

                <hr>
                <h2>Address</h2>
                <div class="rows">
                    <div class="row-md-5">
                        <h4 for="">Postal code</h4>
                        <div class="inputs">
                        <input type="number" id="postal_code" name="postal_code"  value="<?php echo $user['postal_code']; ?>" maxlength="5">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="">Neighborhood</h4>
                        <div class="inputs">
                        <input type="text" id="neighborhood" name="neighborhood"   maxlength="50" value="<?php echo $user['neighborhood']; ?>">
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="">Street</h4>
                        <div class="inputs">
                        <input type="text" id="street" name="street"   maxlength="50"  value="<?php echo $user['street']; ?>">
                        </div>
                    </div>
                </div>

                <hr>
                <footer class="footer">
                    <button class="btn-primary" type="submit">Update</button>
                </footer>

            </form>
        </div>
    </main>
    <?php include FOOT ?>