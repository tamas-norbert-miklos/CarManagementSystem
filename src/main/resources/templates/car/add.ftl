[#ftl]
[#import "/spring.ftl" as spring /]

<html lang="en">
<title>[#if car.id > 0]Edit car page[#else]Add car page[/#if]</title>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add car</title>

    <!-- Bootstrap -->
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/css/addCar.css">

</head>
<body onload="brandChanged();onLoad();">
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
            <a class="navbar-brand">Car Management System</a>
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
<ul class="nav navbar-nav navbar-right">
[#if errors??]
    [#list errors as error]
        <ul class="list-group">
            <li class="list-group-item list-group-item-danger">[#if error.field??]${error.field}: [/#if]${error.defaultMessage}</li>
        </ul>
    [/#list]
[/#if]
</ul>

<div class="container">
    <div class="jumbotron">
        <h1><i class="fa fa-car" aria-hidden="true"></i> Car Management System</h1>
        <p>Tomato tomato ching chong potato.</p>
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
    <hr>
    <div class="row">
        <div class="col-lg-12">
            <div class="row" id="searchText" align="left">
            [#if car.id?? && car.id > 0]
                <div class="col-lg-12">Edit your car</div>
            [#else]
                <div class="col-lg-12">Add a car to the system</div>
            [/#if]

            </div>
        </div>
    </div>
    <br>

    <form method="post" action="/car/save" enctype="multipart/form-data">

        <div class="row">
            <div class="col-lg-6">
                <label>Manufacturer</label>
                <select name="manufacturer" id="manufacturer" onchange="autoEnable();brandChanged();" class="form-control">
                        <option disabled [#if car.manufacturer??][#else]selected[/#if]>-- Select an option --</option>
                    [#list map?keys as manufacturer]
                        <option value="${manufacturer}" [#if car.manufacturer?? && car.manufacturer == manufacturer]selected[/#if]>${manufacturer}</option>
                    [/#list]
                </select>
            </div>
            <div class="col-lg-6">
                <label>Type</label>
                <select name="type" id="type"  class="form-control">
                        [#--<option disabled [#if car.type??][#else]selected[/#if]>-- Select a type --</option>--]
                </select>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-6">
                <label>Fabrication Year</label>
                <input name="fabricationYear" type="input" value="[#if car.fabricationYear != 0]${car.fabricationYear?string["0000"]}[/#if]" class="form-control"
                       placeholder="From 1900 to present">
            </div>
            <div class="col-lg-6">
                <label>Mileage</label>
                <input name="mileAge" type="input" value="[#if car.mileAge != 0]${car.mileAge?string["0"]}[/#if]" class="form-control" placeholder="In Kilometers">
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-6">
                <label>Engine Type</label>
                <div class="input-group">
                      <span class="input-group-addon">
                        <input type="radio" name="engineType" value="PETROL"
                               [#if car.engineType?? && car.engineType == 'PETROL']checked[/#if]>Petrol</input>
					  </span>
                    <span class="input-group-addon">
                          <input type="radio" name="engineType" value="DIESEL"
                                 [#if car.engineType?? && car.engineType == 'DIESEL']checked[/#if]>Diesel</input>
                      	</span>
                    <span class="input-group-addon">
                         	 <input type="radio" name="engineType" value="HYBRID"
                                    [#if car.engineType?? && car.engineType == 'HYBRID']checked[/#if]>Hybrid</input>
                      		</span>
                    <span class="input-group-addon">
                      		 	   <input type="radio" name="engineType" value="ELECTRIC"
                                          [#if car.engineType?? && car.engineType == 'ELECTRIC']checked[/#if]>Electric</input>
								</span>
                </div>
            </div>
            <div class="col-lg-6">
                <label>Transmission Type</label>
                <div class="input-group">
                      <span class="input-group-addon">
                        <input type="radio" name="transmissionType" value="MANUAL"
                               [#if car.transmissionType?? && car.transmissionType == 'MANUAL']checked[/#if]>Manual</input>
					  </span>
                    <span class="input-group-addon">
                          <input type="radio" name="transmissionType" value="AUTOMATIC"
                                 [#if car.transmissionType?? && car.transmissionType == 'AUTOMATIC']checked[/#if]>Automatic</input>
                      	</span>
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-6">
                <label>Color</label>
                <select  name="colour" class="form-control">
                    <option disabled[#if car.colour??][#else]selected[/#if]>-- Select a color --</option>
                    [#list colours as colour]
                        <option value="${colour}" [#if car.colour?? && car.colour == colour]selected[/#if] >${colour}</option>
                    [/#list]
                </select>
            </div>
            <div class="col-lg-6">
                <label>Matriculation status</label>
                <div class="input-group">
                                <span class="input-group-addon">
									<input type="radio" name="matriculated"
                                           value="true"[#if car.matriculated?? && car.matriculated == true]checked[/#if]>Yes, the car is matriculated</input>
                                </span>
                    <span class="input-group-addon">
                       				<input type="radio" name="matriculated"
                                           value="false"[#if car.matriculated?? && car.matriculated == false]checked[/#if]>No, the car isn't matriculated</input>
									 </span>
                </div>

            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-6">
                <label for="price">Price</label>
                <input name="price" type="input" value="[#if car.price != 0]${car.price?string["0000"]}[/#if]" class="form-control" placeholder="Price">
            </div>
            <div class="col-lg-6">
                [#if car.imgUrl??]
                <div class="form-group">
                    <label>Car Image</label> <br>
                    <img src="/ext-img/${car.imgUrl}"/> <br>
                    <label for="carPhoto">Choose another image</label>
                    <input type="file" id="carPhoto" name="file" accept="image/*">
                </div>
                    [#else]
                        <div class="form-group">
                            <label for="carPhoto">Car Image</label>
                            <input type="file" id="carPhoto" name="file" accept="image/*">
                            <p class="help-block">Insert an image of the car here.</p>
                        </div>
                [/#if]
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-lg-12">
                <label for="extras">Description</label>
                <textarea id="extras"  type="text" class="form-control" rows="3" cols="4" name="extras"
                          placeholder="Description">[#if car.extras??]${car.extras}[/#if]</textarea>
            </div>
        </div>
        <br>

        <div class="row">
            <div class="col-lg-12 button-holder">
            [#if car.id??]
                <input name="id" type="hidden" value="${car.id?c}"/>
            [/#if]
                <input class="btn btn-default btn-lg" value="[#if car.id > 0]Save changes[#else]Add car[/#if]"
                       type="submit"/>
            </div>
        </div>
    </form>
    <br>

[#if message??]${message}[/#if]

</div>
<script>
    [#assign car_manufacuters = map?keys]
    var DATA = {
    [#list car_manufacuters as car_manufacturer]
        '${car_manufacturer}' : [ [#list map[car_manufacturer] as type]'${type}',[/#list] ],
    [/#list]
    };

    function brandChanged() {
        var manufacturers = document.getElementById('manufacturer');
        var brand = manufacturers.options[manufacturers.selectedIndex].value;
        var models = DATA[brand];
        var modelSelect = document.getElementById('type');
        modelSelect.style.display = 'block';
        modelSelect.innerHTML = '';

        var model = '-- Select an option --';
        var opt = document.createElement('option');
        opt.value = model;
        opt.innerHTML = model;
        modelSelect.appendChild(opt);

        for (var i = 0; i < models.length; i++) {
            var model = models[i];
            var opt = document.createElement('option');
            opt.value = model;
            opt.innerHTML = model;
            modelSelect.appendChild(opt);
        }
        document.getElementById('type').options[0].disabled = true;
    }
    function onLoad() {
        var manufacturer = document.getElementById('manufacturer').value;
        if(manufacturer != "-- Select an option --") {
            document.getElementById('type').value = "[#if car.type??]${car.type}[/#if]";
        } else {
            document.getElementById('type').value = "-- Select an option --";
        }
    }
</script>
<script src="/js/add.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>
</html>