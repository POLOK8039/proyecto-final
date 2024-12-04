<?php
    require "userFun.php";

    $user_types = getUserTypes();
    $supervisors = getSupervisors();

    
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $name = $_POST['name'];
        $first_surname = $_POST['first_surname'];
        $second_surname = empty($_POST['second_surname']) ? NULL : $_POST['second_surname'];
        $date = empty($_POST['date']) ? NULL : $_POST['date'];
        $neighborhood = empty($_POST['neighborhood']) ? NULL : $_POST['neighborhood'];
        $street = empty($_POST['street']) ? NULL : $_POST['street'];
        $postal_code = empty($_POST['postal-code']) ? NULL : $_POST['postal-code'];
        $phone = empty($_POST['phone']) ? NULL : $_POST['phone'];
        $email = empty($_POST['email']) ? NULL : $_POST['email'];
        $user_type = empty($_POST['user_type']) ? NULL : $_POST['user_type'];
        $supervisor = $_POST['supervisor']== "NULL" ? NULL : $_POST['supervisor'];

        $result = addUser(
            $username, $password, $name, $first_surname, $second_surname, $date, $neighborhood, $street, $postal_code, $phone, $email, $user_type, $supervisor
        );

        if ($result) {
            $_SESSION['message'] = [
                'text' => 'Successful registration',
                'type' => 'success'
            ];
        } else {
            $_SESSION['message'] = [
                'text' => 'Error',
                'type' => 'error'
            ];
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
                    <h1>Add Users</h1>
                </header>
                <hr>
                <h2>Profile</h2>
                <div class="rows">
                    <div class="row-lg-10">
                        <h4 for="name">Name</h4>
                        <div class="inputs">
                            <input name="name" id="name" type="text" maxlength="50"   required>
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="first_surname">First Surname</h4>
                        <div class="inputs">
                            <input name="first_surname" id="first_surname" type="text"   maxlength="30" required>
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="second_surname">Second Surname</h4>
                        <div class="inputs">
                            <input name="second_surname" id="second_surname" type="text" maxlength="30" >
                        </div>
                    </div>
                    <div class="row-sm-3">
                        <h4 for="date">Date of Birth</h4>
                        <div class="inputs">
                            <input type="date" name="date" id="date" required>
                        </div>
                    </div>
                </div>
                
                <hr>
                <h2>Access Credentials</h2>
                <div class="rows">
                    <div class="row-lg-10">
                        <h4 for="username">User</h4>
                        <div class="inputs">
                            <input name="username" id="username"  type="text"  maxlength="30"  required placeholder="@Username">
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="email">Email</h4>
                        <div class="inputs">
                            <input name="email" id="email" type="email"   maxlength="30" placeholder="you@example.com">
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="phone">Phone number</h4>
                        <div class="inputs">
                            <input name="phone" id="phone" type="text"    maxlength="15"   placeholder="555-666-7777">
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="password">Password</h4>
                        <div class="inputs">
                            <input type="text" name="password" id="password"   maxlength="40" required placeholder="Hi_everyone_01">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="user_type">User type</h4>
                        <select required name="user_type" id="user_type" class="inputs" name="">
                            <?php 
                                while ($user_type = mysqli_fetch_assoc($user_types)):   
                                    echo "<option value='{$user_type['code']}'>{$user_type['name']}</option>";
                                endwhile; 
                            ?>
                        </select>
                    </div>
                    <div class="row-md-5">
                        <h4 for="supervisor">Supervisor</h4>
                        <select class="inputs" name="supervisor" id="supervisor">
                            <option value="NULL">...</option>

                            <?php 
                                while ($supervisor = mysqli_fetch_assoc($supervisors)):   
                                    echo "<option value='{$supervisor['num']}'>{$supervisor['full_name']}</option>";
                                endwhile;
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
                            <input name="postal-code" id="postal-code" type="number" placeholder="22254" min="5">
                        </div>
                    </div>
                    <div class="row-md-5">
                        <h4 for="">Neighborhood</h4>
                        <div class="inputs">
                            <input name="neighborhood" id="neighborhood" type="text" placeholder="Your neighborhood" maxlength="50">
                        </div>
                    </div>
                    <div class="row-lg-10">
                        <h4 for="">Street</h4>
                        <div class="inputs">
                            <input name="street" id="street" type="text" placeholder="Yor street" maxlength="50">
                        </div>
                    </div>
                </div>

                <hr>
                <footer class="footer">
                    <button class="btn-primary" type="submit">Confirm</button>
                </footer>

            </form>
        </div>
    </main>
    <?php include FOOT ?>