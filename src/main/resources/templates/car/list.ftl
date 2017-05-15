[#ftl]
<html>
<head>
    <title>Car Management System</title>
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/css/myList.css">
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
            </ul>
            <ul class="nav navbar-nav navbar-right">
            [#if user??]
                <li class="active"><a href="#"><i class="fa fa-user" aria-hidden="true"></i> ${user.firstName}</a></li>
                <li><a href="/logout"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span> LogOut</a></li>
            [#else]
                <li><a href="/signup"><i class="fa fa-user-plus" aria-hidden="true"></i> Sign Up</a></li>
                <li><a href="/login"><i class="fa fa-user" aria-hidden="true"></i> Login</a></li>
            [/#if]
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

        </div>
        <div class="row">
            <div class="col-lg-4 button-holder">
                <label>Make a search</label>
                <a class="btn btn-default" href="/search" role="button"><i class="fa fa-search" aria-hidden="true"></i> Search</a>
            </div>
            <div class="col-lg-4 button-holder">
                <label>Add a new car</label>
                <a class="btn btn-default" href="/car/add" role="button"><i class="fa fa-plus" aria-hidden="true"></i> Add car</a>
            </div>
            <div class="col-lg-4 button-holder">
                <label>View your car list</label>
                <a class="btn btn-default" href="/car/list" role="button"><i class="fa fa-list" aria-hidden="true"></i> Car list</a>
            </div>
        </div>
    </div>

    <hr>
    <div class="row">
        <div class="col-lg-12">
            <h2>My Car List</h2>
        </div>
    </div>
    <br>
    [#if cars?size == 0]
        <div class="row">
            <div class="col-lg-12">
                <h3>0 cars in the list</h3>
            </div>
        </div>[#else]
    
        [#list cars as car]
            <div class="row">
                <div class="col-lg-3">
                    <div class="thumbnail">
                        [#if car.imgUrl??]<img src="/ext-img/${car.imgUrl}"/>[/#if]
                    [#--<h3>Aici vine imageinea: "{car.imgUrl}"</h3>--]
                    [#--<img src="http://cdn.bmwblog.com/wp-content/uploads/BMW-M3-GTS-Garching-03.jpg">--]
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="row">
                        <div class="col-lg-12 car-header">
                        ${car.manufacturer} ${car.type}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            Fabrication Year: ${car.fabricationYear?string["0000"]}
                        </div>
                        <div class="col-lg-6">
                            Mileage: ${car.mileAge}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            Engine type: ${car.engineType}
                        </div>
                        <div class="col-lg-6">
                            Transmission Type: ${car.transmissionType}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            Color: ${car.colour}
                        </div>
                        <div class="col-lg-6">
                            Matriculation status: [#if car.matriculated?? && car.matriculated == true]Matriculated[#else]Not matriculated[/#if]
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <strong>Description</strong>
                            <p>"${car.extras}"</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="row">
                        <div class="col-lg-12 right-align car-header">
                            Price: ${car.price}
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-lg-12 right-align">
                            <a class="btn btn-default" href="/car/edit?id=${car.id?c}" role="button"><i class="fa fa-edit" aria-hidden="true"></i> Edit Car</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 right-align">
                            <a class="btn btn-default" href="/car/delete?id=${car.id?c}" role="button"><i class="fa fa-trash" aria-hidden="true"></i> Delete Car</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 right-align">
                            <a class="btn btn-default" href="/car/view?id=${car.id?c}" role="button"><i class="fa fa-eye" aria-hidden="true"></i> View Car</a>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
        [/#list]
    [/#if]

</div>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script> -->

</body>
</html>