<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function validation() {
	if( document.myform.dname.value == "" ){
        document.getElementById('fError').innerHTML="Doctor Name field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.speciality.value == "" ){
        document.getElementById('fError').innerHTML="Speciality field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.roomno.value == "" ){
        document.getElementById('fError').innerHTML="Room Number field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.address.value == "" ){
        document.getElementById('fError').innerHTML="Address field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
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
  </div>
  <div id="menu">
    <ul>
      <li><a href="admhome.jsp">Home</a></li>
      <li><a href="admSearch.jsp">Search a Doctor</a></li>
      <li><a href="admInsert.jsp">Insert a Doctor</a></li>
      <li><a href="admUpdate.jsp">Update a Doctor</a></li>
      <li><a href="admDelete.jsp">Delete a Doctor</a></li>
    </ul>
  </div>
  
  <div id="content-wrap">
    <div id="content">
      <div id="main">
        <div class="post"> <a name="TemplateInfo"></a>
          <p><center>      
              <h2></>Welcome <%= (String)session.getAttribute("user")%></h2><br>
              <%! Connection c;
              Statement s;
              PreparedStatement p;
              ResultSet r;
              ResultSetMetaData md;
              int count;%>
              <% Class.forName("oracle.jdbc.driver.OracleDriver");
              c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
              s = c.createStatement();
              %>
             <form name = "myform" onsubmit="return validation();">
  			 <p>Doctor Name:<input style="margin-right:30px;margin-left:30px" name = "dname" id = "dname" type = "text"></input>
  			 <p>Speciality: <input style="margin-right:30px;margin-left:30px" name = "speciality" id = "speciality" type = "text"></input> 	
  			 <p>Room Number:<input style="margin-right:30px;margin-left:30px" name = "roomno" id = "roomno" type = "text"></input>
  			 <p>Address :<input style="margin-right:30px;margin-left:30px" name = "address" id = "address" type = "text"></input>
  			 <p><input value = " Insert " type = "submit"></input>
  			 <p><b><div style="color:red; font-size:80%" id ="fError"> </div></b></p><br>
  			 </form>
  			 <% String dname = request.getParameter("dname");
  			    String speciality = request.getParameter("speciality");
     			String roomno = request.getParameter("roomno");
     			String address = request.getParameter("address");
  			    System.out.print(dname +" "+ speciality +" "+ roomno +" "+ address);
  			    if((dname!= null && !dname.isEmpty()) && (speciality!= null && !speciality.isEmpty()) && (roomno!= null && !roomno.isEmpty() )&& (address!= null && !address.isEmpty() )){
			    	p = c.prepareStatement("insert into doctor(dname, speciality, roomNo, address) values (?,?,?, ?)");
			    	p.setString(1, dname);
			    	p.setString(2, speciality);
			    	p.setString(3, roomno);
			    	p.setString(4, address);
				    p.executeUpdate();
			    	p = c.prepareStatement("insert into admin (DID) values ((select DID from doctor where dname = ?))");
			    	p.setString(1, dname);
			    	p.executeUpdate();
				    c.commit();
					r = s.executeQuery("select * from doctor order by DID");
		            md = r.getMetaData();
		            count = md.getColumnCount();  
			    %>
			    <table border=1 CELLPADDING=0 CELLSPACING=0 WIDTH=90%>
			 <tr>
			 <%  for (int i=1; i<=count; i++) {%>
			    <th>
			    <%= md.getColumnLabel(i)%>
			    <% } %>
		    </th></tr>
			<h3>Results</h3>
			<% while(r.next()){ %>
			        <tr><td><center><%= r.getString("DID")%></center></td>
		               <td><center><%= r.getString("dname")%></center></td>
		               <td><center><%= r.getString("speciality")%></center></td>
		               <td><center><%= r.getString("roomNo")%></center></td>
		               <td><center><%= r.getString("address")%></center></td>
		            </tr>
			<% }
				c.commit();} %>
			</table>
  			</center><br>
          </p>
        </div>
      </div>
    </div>
  </div>
  <div id="footer">
    <p> &copy; 2015 <strong>Sneha</strong></p>
  </div>
</div>
</body>
</html>
