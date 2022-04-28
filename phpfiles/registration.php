<?php

    $firstName = $_POST["firstName"];
    $lastName= $_POST["lastName"];
    $email= $_POST["email"];
    
    
    require_once 'connect.php';

$findexist="select * from employee where firstName  ='$firstName'";

        $resultsearch=mysqli_query($conn,$findexist);
    if(mysqli_num_rows($resultsearch)>0)
    {
           while($row=mysqli_fetch_array($resultsearch))
          {
              $result["success"] = "3";
              $result["message"] = "user Already exist";

              echo json_encode($result);
              mysqli_close($conn);
          }
  }
else{

    $sql = "INSERT INTO employee (firstName,lastName,email) VALUES ('$firstName','$lastName','$email');";

    if ( mysqli_query($conn, $sql) ) {
        $result["success"] = "1";
        $result["message"] = "Registration success";

        echo json_encode($result);
        mysqli_close($conn);

    } else {
        $result["success"] = "0";
        $result["message"] = "error in Registration";
        echo json_encode($result);
        mysqli_close($conn);
    }
}

?>
