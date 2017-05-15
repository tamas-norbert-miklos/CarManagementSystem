[#ftl]

<html lang="en">
<head>
	<title>Car Management System</title>
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/css/bootstrap-select.min.css"> -->
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/app.css">
	<link rel="stylesheet" type="text/css" href="css/myList.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="js/numberOfCars.js"></script>
</head>
<body onload="brandChanged();autoEnable();onLoad();">
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
	      <a class="navbar-brand" href="/search">Car Management System</a>
	    </div>
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li class="active"><a href="/search">Home</a></li>
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
		<div class="row">
			<div class="col-lg-12">
				<h4 class="dbsize">The current number of cars in the system: </h4>
			</div>
		</div>
		<form id="forSearch" action="/search">
			<div class="row">
				<div class="col-lg-6">
						<div class="row" id="searchText" align="left">
							<div class="col-lg-12">Search</div>
						</div>
						<hr>
						<div class="row">
							<div class="form-group col-lg-6">
                                <label>Manufacturer</label>
                                <select name="manufacturer" id="manufacturer" onchange="brandChanged();autoEnable();" class="form-control">
                                    <optgroup label="Manufacturer">
                                        <option value="All" [#if searchModel.type?? && searchModel.type == 'All']selected[/#if] >All</option>

										[#list map?keys as manufacturer]
                                       	    <option value="${manufacturer}" [#if searchModel.manufacturer == manufacturer]selected[/#if]>${manufacturer}</option>
                                       	[/#list]
                                    </optgroup>
                                </select>
						 	</div>
							[#--[#assign car_manufacuters = map?keys]--]
							[#--[#assign car_types = map?values]--]
							[#--[#list car_manufacuters as car_manufacturer]--]
							    [#--'$${car_manufacturer}': [ [#list ]]--]
							[#--[/#list]--]

						  	<div class="form-group col-lg-6">
						  		<label>Type</label>
							    <select name="type" id="type"  class="form-control">
								  <optgroup label="Type">
								  </optgroup>
								</select>
						  	</div>
						</div>
						<div class="row">
							<div class="form-group col-lg-6">
							    <label for="price">Price up to</label>
							    <input type="text" class="form-control" name="price" id="price" value="[#if searchModel.price != 0]${searchModel.price?string["0"]}[/#if]" placeholder="ex: 2000">
						 	</div>
						  	<div class="form-group col-lg-6">
							    <label for="fabricationYear">First Registration</label>
							    <input type="text" class="form-control" name="fabricationYear" value="[#if searchModel.fabricationYear != 0]${searchModel.fabricationYear?string["0"]}[/#if]" placeholder="ex: 2005">
						  	</div>
						</div>
						<div class="row">
							<div class="form-group col-lg-6">
                            <label for="mileAge">Mileage up to</label>
                            <input type="text" class="form-control"
                                   type="number" step="any" name="mileAge" value="[#if searchModel.mileAge != 0]${searchModel.mileAge?string["0"]}[/#if]" placeholder="ex: 2000">
                        </div>
						  	<div class="form-group col-lg-6">
						  		<div class="row">
						  			<div class="col-lg-12">
						  				<label for="transmissionType">Transmission type</label>
						  			</div>
						  		</div>
						  		<div class="row">
						  			<div class="col-lg-6">
						  				<div class="checkbox">
											<label><input type="checkbox" name="transmissionType" [#if searchModel.transmissionType?seq_contains('MANUAL') ]checked[/#if] value="MANUAL">Manual</label>
										</div>
						  			</div>
						  			<div class="col-lg-6">
						  				<div class="checkbox">
											<label><input type="checkbox" name="transmissionType" [#if searchModel.transmissionType?seq_contains('AUTOMATIC') ]checked[/#if] value="AUTOMATIC">Automatic</label>
										</div>
						  			</div>
						  		</div>
						  	</div>
						</div>
						<div class="row">
							<div class="form-group col-lg-6">
								<label>Color</label>
								<br>
								<select  name="colour" class="form-control">
								  <optgroup label="Color">
								    [#list colours as colour]
								        <option value="${colour}" [#if searchModel.colour?? && searchModel.colour == colour]selected[/#if] >${colour}</option>
								    [/#list]
								  </optgroup>
								</select>
						 	</div>
						  	<div class="form-group col-lg-6">
						  		<div class="row">
						  			<div class="col-lg-12">
						  				<label>Engine type</label>
						  			</div>
						  		</div>
						  		<div class="row">
						  			<div class="col-lg-3">
						  				<div class="checkbox">
											<label><input type="checkbox" name="engineType" [#if searchModel.engineType?seq_contains('PETROL')]checked[/#if] value="PETROL">petrol</label>
										</div>
						  			</div>
						  			<div class="col-lg-3">
						  				<div class="checkbox">
											<label><input type="checkbox" name="engineType" [#if searchModel.engineType?seq_contains('DIESEL')]checked[/#if] value="DIESEL">diesel</label>
										</div>
						  			</div>
                                    <div class="col-lg-3">
                                        <div class="checkbox">
                                            <label><input type="checkbox" name="engineType" [#if searchModel.engineType?seq_contains('ELECTRIC')]checked[/#if] value="ELECTRIC">electric</label>
                                        </div>
                                    </div>
						  			<div class="col-lg-3">
						  				<div class="checkbox">
											<label><input type="checkbox" name="engineType" [#if searchModel.engineType?seq_contains('HYBRID')]checked[/#if] value="HYBRID">hybrid</label>
										</div>
						  			</div>
						  		</div>
						  	</div>
						</div>
						<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Search</button>

				</div>
				<div class="col-lg-6">
					<div class="thumbnail">
						<img src="https://ocmsites.org/news/wp-content/uploads/sites/15/2015/10/parking.jpg">
					</div>
				</div>
			</div>
		</form>
		<hr>

		<div class="row">
			<div class="col-lg-12">
                <h4>Search results: </h4>
			</div>
		</div>
        <br>
		[#if results?size == 0]
		    <div class="row">
				<div class="col-lg-12">
                    <h3>0 cars found</h3>
				</div>
			</div>[#else]

			[#list results as car]
				<div class="row">
					<div class="col-lg-3">
						<div class="thumbnail">
							[#if car.imgUrl??]<img src="/ext-img/${car.imgUrl}"/>[/#if]
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
								Matriculation status: Matriculated
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<strong>Description</strong>
								<p>${car.extras}</p>
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
								<a class="btn btn-default" href="/car/view?id=${car.id?c}" role="button"><i class="fa fa-eye" aria-hidden="true"></i> View Car</a>
							</div>
						</div>
					</div>
				</div>
				<hr>
			[/#list]
		[/#if]


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

            var model = 'All';
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

        }
        function onLoad() {
            var manufacturer = document.getElementById('manufacturer').value;
            if(manufacturer != 'All') {
                document.getElementById('type').value = "[#if searchModel.type??]${searchModel.type}[/#if]";
            } else {
                document.getElementById('type').options[0].selected = true;
			}
        }
    </script>
	<script type="text/javascript" src="js/search.js"></script>
<!-- <script type="text/javascript" src="index.js"></script> -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.2/js/bootstrap-select.min.js"></script> -->

</body>