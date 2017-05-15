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
    <div class="row">
    [#if user??]
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
        <hr>
    [/#if]

    [#if errors??]
        [#list errors as error]
            <span style="color:red"> ${error}</span>
            <br>
        [/#list]
    [/#if]
    </div>

    <hr>
    <div class="row">
        <div class="col-lg-4">
            <h2>${car.manufacturer} ${car.type}
                [#if user??]<a class="btn btn-default" href="/car/edit?id=${car.id?c}" role="button"><i class="fa fa-edit" aria-hidden="true"></i> Edit Car</a>[/#if]
            </h2>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-lg-6">
            <div class="thumbnail">
            [#if car.imgUrl??]<img src="/ext-img/${car.imgUrl}"/>[/#if]
            </div>
        </div>
        <div class="col-lg-6">
            <div class="row">
                <div class="col-lg-4">
                    <h4>Manufacturer</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.manufacturer}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Type</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.type}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Price</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.fabricationYear?string["0"]}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Mileage</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.mileAge}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Engine type</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.engineType}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Transmission type</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.transmissionType}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Color</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.colour}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Matriculation status</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.matriculated?string('Matriculated','Not matriculated')}</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <h4>Description</h4>
                </div>
                <div class="col-lg-8">
                    <h4>${car.extras}</h4>
                </div>
            </div>

            <br>

            <div class="row">
                <div class="col-lg-4">
                    <h4>Price</h4>
                </div>
                <div class="col-lg-4">
                    <h4>${car.price}</h4>
                </div>
            </div>
        </div>
    </div>

    <hr>

    <div class="row">
        <div class="col-lg-6">
            <h2>Seller details:</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-2">
            <h4>Name</h4>
        </div>
        <div class="col-lg-4">
            <h4>${seller.firstName} ${seller.lastName}</h4>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-2">
            <h4>Phone number</h4>
        </div>
        <div class="col-lg-4">
            <h4>${seller.phoneNumber}</h4>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-2">
            <h4>E-mail address</h4>
        </div>
        <div class="col-lg-4">
            <h4>${seller.email}</h4>
        </div>
    </div>

    <br>
</div>


<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script> -->

</body>
</html>