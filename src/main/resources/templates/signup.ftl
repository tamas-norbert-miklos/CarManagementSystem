[#ftl]

<html>
<head>
    <title>Car Management System</title>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/signup.css">
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">Car Management System</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="/search">Home</a></li>
                <li><a href="">About</a></li>
                <li><a href="">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="/signup"><i class="fa fa-user-plus" aria-hidden="true"></i> Sign Up</a></li>
                <li><a href="/login"><i class="fa fa-user" aria-hidden="true"></i> Login</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<div class="container">
    <div class="jumbotron">
        <h1><i class="fa fa-car" aria-hidden="true"></i> Car Management System</h1>
        <p>Tomato tomato ching chong potato.</p>
    </div>
    <div>
        <div class="row">
            <div class="col-lg-6">
                <h3><i class="fa fa-user-plus" aria-hidden="true"></i> Sign Up</h3>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-6">
                <form method="post" action="/signup">
                    <div class="row">
                        <div class="form-group col-lg-12">
                            <label for="exampleInputEmail1">Email address</label>
                            <input name="email" type="email" value="${user.email!''}" class="form-control" id="exampleInputEmail1" placeholder="Email">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-lg-12">
                            <label for="exampleInputPassword1">Password</label>
                            <input name="password" type="password" value="${user.password!''}" class="form-control" id="exampleInputPassword1" placeholder="Password">
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-lg-6">
                            <label for="firstName">First Name</label>
                            <input name="firstName" type="text" value="${user.firstName!''}" class="form-control" id="firstName" placeholder="">
                        </div>
                        <div class="form-group col-lg-6">
                            <label for="lastName">Last Name</label>
                            <input name="lastName" type="text" value="${user.lastName!''}" class="form-control" id="lastName" placeholder="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-lg-12">
                            <label for="phoneNumber">Phone Number</label>
                            <input name="phoneNumber" type="text" value="${user.phoneNumber!''}" class="form-control" id="phoneNumber" placeholder="0750 123 456">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-default">Create Account</button>
                </form>
            </div>
            <div class="col-lg-6">
                <div class="thumbnail">
                    <img src="images/signup.jpg">
                </div>
            </div>
        </div>
    </div>


    <hr>

</div>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script> -->

</body>
</html>