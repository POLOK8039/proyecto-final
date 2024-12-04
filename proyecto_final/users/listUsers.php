<?php
    require_once("../config.php");
    require "userFun.php";
    $users = getUsers();


    //$search = isset($_GET['search']) ? $_GET['search'] : '';
    //$users = empty($search) ? getUsers() : searchUser($search);
?>
    <main class="tables">
        <div class="background">
            <?php 
            $link="?a=add";
            include HEADER;
            ?>
            <h1>Users</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            <span>Num</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Name</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>Date of birth</span>
                            <span class="column-order"></span>
                        </th>
                        <th>
                            <span>User type</span>
                            <span class="column-order"></span>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($users as $user): ?>
                    <tr>
                        <td><?php echo $user['num']; ?></td>
                        <td><?php echo $user['full_name']; ?></td>
                        <td><?php echo $user['date_of_birth']; ?></td>
                        <td><?php echo $user['user']; ?></td>
                        <?php if(validateUser("ADMIN","SUPER")):?>
                        <td>
                            <a class="btn" href="?a=edit&num=<?php echo $user['num'];?>">Edit</a>
                        </td>
                        <?php endif;?>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <?php include FOOTER ?>
        </div>
    </main>