<!DOCTYPE html>
<html>
<head>

<meta charset='utf-8'>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="inc/jquery-2.2.3.min.js"></script>
<script src="inc/dmenu.js"></script>

<link rel="stylesheet" href="css/dmenu.css" />

<title></title>

</head>

<body>

<div id='cssmenu'>
<ul>
	<li class='active'><a href='http://blog.surroindustries.com'><span>SURRO</span></a></li>
   
	<li class='has-sub'><a href='#'><span id="SelectedUser">Users</span></a>
	<ul id="Users"></ul>
	</li>
   
	<li class='has-sub'><a href='#'><span id="SelectedNetwork">Networks</span></a>
	<ul id = "Networks"></ul>
	</li>
	
	<li class='last'><a href='#'><span>Contact</span></a></li>

</ul>
</div>

<script>


function loadUsers() 
{
	var xhttp;
	
	if (window.XMLHttpRequest) {
		xhttp = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xhttp.onreadystatechange = function() 
	{
		if (xhttp.readyState == 4 && xhttp.status == 200) 
		{
			vals = csv2arr( xhttp.responseText );
			document.getElementById("Users").innerHTML = '';
			document.getElementById("Users").innerHTML += '<li class="last"><a href="#" onclick="getNetworks(\'' + xhttp.responseText + '\')">' + xhttp.responseText + '</a></li>';
			document.getElementById("SelectedUser").innerHTML = xhttp.responseText;
		}
	};
	xhttp.open("GET", "builder.php?payload=users", true);
	xhttp.send();
}

function getNetworks( user )
{
	var xhttp;
	
	if (window.XMLHttpRequest) {
		xhttp = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xhttp.onreadystatechange = function() 
	{
		if (xhttp.readyState == 4 && xhttp.status == 200) 
		{
			var vals = csv2arr( xhttp.responseText );
			var len = vals.length;
			var i, network;

			document.getElementById("Networks").innerHTML = '';

			for ( i = 0; i < len; i++ )
			{
				if ( i in vals )
				{
					network = vals[i];
					if ( i == len - 1 )
					{
						document.getElementById("Networks").innerHTML += '<li class="last"><a href="#" onclick="getChannel()">' + network + '</a></li>';
					} else {
						document.getElementById("Networks").innerHTML += '<li><a href="#" onclick="getChannel(\'' + network + '\', ' + document.getElementById("SelectedUser") + \')">' + network + '</a></li>';
					}
					document.getElementById("SelectedNetwork").innerHTML = s;	
				}
			}
		}
	};
	xhttp.open("GET", "builder.php?payload=networks&user=" + user, true);
	xhttp.send();
}


function getChannels( user, network )
{
	var xhttp;
	
	if (window.XMLHttpRequest) {
		xhttp = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xhttp.onreadystatechange = function() 
	{
		if (xhttp.readyState == 4 && xhttp.status == 200) 
		{
			var vals = csv2arr( xhttp.responseText );
			var len = vals.length;
			var i, s;

			document.getElementById("Networks").innerHTML = '';

			for ( i = 0; i < len; i++ )
			{
				if ( i in vals )
				{
					s = vals[i];
					if ( i == len - 1 )
					{
						document.getElementById("Networks").innerHTML += '<li class="last"><a href="#" onclick="getChannel()">' + s + '</a></li>';
					} else {
						document.getElementById("Networks").innerHTML += '<li><a href="#" onclick="getChannel(\'' + s + '\')">' + s + '</a></li>';
					}
					document.getElementById("SelectedNetwork").innerHTML = s;	
				}
			}
		}
	};
	xhttp.open("GET", "builder.php?payload=networks&user=" + user, true);
	xhttp.send();
}

function csv2arr( string )
{
	return string.split(',');
}

loadUsers();
</script>


</body>
</html>
