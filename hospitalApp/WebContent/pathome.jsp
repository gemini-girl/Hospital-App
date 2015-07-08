<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
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
  </div>
  <div id="menu">
    <ul>
      <li><a href="pathome.jsp" >Home</a></li>
      <li><a href="profile.jsp">Profile</a></li>
      <li><a href="bills.jsp">Bills</a></li>
      <li><a href="patDocSearch.jsp">Search a Doctor</a></li>  
    </ul>
  </div>
  <div id="content-wrap">
    <div id="content">
      <div id="main">
        <div class="post"> <a name="TemplateInfo"></a>
          <p><center>      
              <h2>Welcome <%= (String)session.getAttribute("user")%></h2>
              
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
