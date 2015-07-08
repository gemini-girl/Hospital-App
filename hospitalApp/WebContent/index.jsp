<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function validation() {
    var x = document.forms["myform"]["user"].value;
    if (x == null || x == "")  {
        document.getElementById('fError').innerHTML="Username you entered is incorrect or empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
    var y = document.forms["myform"]["pwd"].value;
    if (y == null || y == "") {
        document.getElementById('pError').innerHTML="Password you entered is incorrect or empty";
        return false;
    }else{
        document.getElementById('pError').innerHTML="";
    }
}
</script>
<title>Hospital Database</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="Enlighten.css" type="text/css" />
</head>
<body>
<div id="wrap">
  <div id="header">
    <div id="logo-box">
      <h1 id="logo">Hospital Database</h1>
    </div>
    <div class="headerphoto"></div>
  </div>
  <div id="content-wrap">
    <div id="content">
      <div id="main">
        <div class="post"> <a name="TemplateInfo"></a>
          <p><center>      
              <h1>LOGIN</h1><br>
          		<form action = "login.jsp" name = "myform" onsubmit="return validation();" method = "post"> 
   				<p><label>Username:</label><input type="text" id="user" name="user" ></p>
       			<p><b><div style="color:red" id ="fError"> </div></b></p>
    			<p><label>Password:</label><input type="password" id="pwd" name="pwd" ></p>
        		<p><b><div style="color:red" id ="pError"> </div></b></p>
    			<p><input type="submit" value="Login"/></p>
			  </form>
			</center>
          </p>
        </div>
       <br />
      </div>
    </div>
  </div>
  <div id="footer">
    <p> &copy; 2015 <strong>Sneha</strong></p>
  </div>
</div>
</body>
</html>
