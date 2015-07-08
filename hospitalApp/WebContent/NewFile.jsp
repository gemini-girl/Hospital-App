<!doctype html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script>
$(document).ready(function(){
$( "#hello" ).dialog({ autoOpen: false });
$( "#say_it" ).click(function() {
$( "#hello" ).dialog( "open" );
});
});

function yes(){
	$( "#hello" ).dialog( "close" );
	x = "Yes";
        var pop = document.getElementById('demo');
        pop.value=x;
    } 
function no(){
	$( "#hello" ).dialog( "close" );
	  x = "No";
      var pop = document.getElementById('demo');
      pop.value=x;
  }
</script>
</head>
<body>
<button id="say_it">Say "Hello!"</button>
<div id="hello" title="Alert"><p><font face="Georgia" size="3">
Are you sure you want to delete?<br><br> 
<input style = "margin-left:70px" type = "submit" value = "Yes"  onclick="yes()">
<input style = "margin-left:20px" type = "submit" value = "No "  onclick="no()"></font></p></div>
<input type="text" name="demo" id="demo" readonly="true"/>             

</body>
</html>