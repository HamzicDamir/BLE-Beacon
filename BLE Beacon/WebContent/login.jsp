<html>
<head>
<link rel="stylesheet" href="./material.min.css">
<script src="./material.min.js"></script>
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<style>
.mdl-layout {
	align-items: center;
  justify-content: center;
}
.mdl-layout__content {
	padding: 24px;
	flex: none;
}
</style>
<script type="text/javascript">
$.ajaxSetup({
	url:"login",
    async: false
});

$.getJSON("login",{session:"session"}, function(result){
	if(result.exists=="true"){
		document.location.href='/BLE_Beacon/main';	
	}
});
</script>
<body>
<div class="mdl-layout mdl-js-layout mdl-color--grey-100">
<main class="mdl-layout__content">
	<div class="mdl-card mdl-shadow--6dp">
		<div class="mdl-card__title mdl-color--primary mdl-color-text--white">
			<h2 class="mdl-card__title-text">Login</h2>
		</div>
		<div class="mdl-card__supporting-text">
			<form action="#">
				<div class="mdl-textfield mdl-js-textfield">
					<input class="mdl-textfield__input" type="text" id="username" />
					<label class="mdl-textfield__label" for="username">Username</label>
				</div>
				<div class="mdl-textfield mdl-js-textfield">
					<input class="mdl-textfield__input" type="password" id="password" />
					<label class="mdl-textfield__label" for="password">Password</label>
				</div>
			</form>
		</div>
		<div id="errorDiv" style="display:none;text-align:center; color:deeppink; font-weight:bold;margin-bottom:5px;">Username or password are incorrect!!!</div>
		<div id="submitDiv" class="mdl-card__actions mdl-card--border">
			<div style="float:right">
				<button id="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent">Sign in</button>
				<div id="loading" class="mdl-spinner mdl-js-spinner is-active" style="display:none"></div>
			</div>
		</div>
	</div>
</main>
</div>
<script type="text/javascript">

$("#submit").click(function(){
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	$("#submit").hide();
	$("#loading").show();
	$.ajax({
     	  method: "POST",
     	  data: { "setSession":"setSession",
     		  	   "username": username,
     	  		  "password": password
     	  },
		  success:function(data){
			  if(data.exists=="true"){
				  document.location.href='/BLE_Beacon/main';	
			  }
			  else
			  {
				  $("#loading").hide();
				  $("#submit").show();
				  $("#errorDiv").show();
				  			  
			  }
		  }
     });
	 
});
</script>
</body>
</html>