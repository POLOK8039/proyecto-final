<?php
    require_once "tracFun.php";
    $users = getUsersInProcess($_SESSION['trac']);

?>
<div style="text-align: center">
    <h2>Users in Process</h2>
</div>
<table class="table">
    <thead>
        <tr>
            <th>
                <span>ID</span>    
                <span class="column-order"></span>
            </th>
            <th>
                <span>Name</span>    
                <span class="column-order"></span>
            </th>                  
        </tr>
    </thead>
    <tbody>
        <?php foreach($users as $user): ?>
        <tr>
            <td><?php echo $user['User_ID'] ?></td>
            <td><?php echo $user['User_Name'] ?></td>
        </tr>
        <?php endforeach;?>
    </tbody>
</table>
<?php include FOOTER ?>