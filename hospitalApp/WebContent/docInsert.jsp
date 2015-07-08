<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, hospitalApp.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function validation() {
	if( document.myform.list.value == "" ){
        document.getElementById('fError').innerHTML="Select a doctor";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.pname.value == "" ){
        document.getElementById('fError').innerHTML="Patient Name field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.description.value == "" ){
        document.getElementById('fError').innerHTML="Description field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
	if( document.myform.fees.value == "" ){
        document.getElementById('fError').innerHTML="Fees field is empty";
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
       <li><a href="dochome.jsp" id="current">Home</a></li>
      <li><a href="docSearch.jsp">Search a Patient</a></li>
      <li><a href="docInsert.jsp">Insert a Patient</a></li>
      <li><a href="docUpdate.jsp">Update a Patient</a></li>
      <li><a href="docDelete.sjp">Delete a Patient</a></li>     </ul>
  </div>
 <div id="content-wrap">
    <div id="content">
      <div id="main">
        <div class="post"> <a name="TemplateInfo"></a>
          <p><center>      
              <h2></>Welcome <%= (String)session.getAttribute("user")%></h2>
              <%! Connection c;
              Statement s;
              PreparedStatement p;
              ResultSet r;
              ResultSetMetaData md;
              int count;%>
              <% Class.forName("oracle.jdbc.driver.OracleDriver");
              c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
              s = c.createStatement();
              r = s.executeQuery("Select * from doctor");
              %>
             <form name = "myform" onsubmit="return validation();">
             <p></>Select a Doctor:<select name = "list">
  			  	<option value = "">Select a Doctor</option>
  			  	  <% while(r.next()){ %>
  			  		<option value =<%= r.getString("dname")%>><%= r.getString("dname") %> (<%= r.getString("speciality") %>)</option>
  			  	  <% } %>
  			  	</select></p>
  			 <p>Patient Name:<input style="margin-right:30px;margin-left:30px" name = "pname" id = "pname" type = "text"></input>
  			 <p>Medical Description: <input style="margin-right:30px;margin-left:30px" name = "description" id = "description" type = "text"></input> 	
  			 <p>Fees:<input style="margin-right:30px;margin-left:30px" name = "fees" id = "fees" type = "text"></input>
  			 <p>Address :<input style="margin-right:30px;margin-left:30px" name = "address" id = "address" type = "text"></input>
  			 <p><input value = " Insert " type = "submit"></input>
  			 <p><b><div style="color:red; font-size:80%" id ="fError"> </div></b></p><br>
  			 </form>
  			 <% String dname = request.getParameter("list");  			 
  			    String pname = request.getParameter("pname");
  			    String description = request.getParameter("description");
     			String fees = request.getParameter("fees");
     			String address = request.getParameter("address");
  			    System.out.print( dname +" "+pname +" "+ description +" "+ fees +" "+ address);
  			 if((dname!= null && !dname.isEmpty()) && (pname!= null && !pname.isEmpty()) && (description!= null && !description.isEmpty()) && 
  					 (fees!= null && !fees.isEmpty() ) && (address!= null && !address.isEmpty() )){
			    	p = c.prepareStatement("insert into patient(pname, address, fees) values (?,?,?)");
			    	p.setString(1, pname);
			    	p.setString(2, address);
			    	p.setString(3, fees);
				    p.executeUpdate();
			    	p = c.prepareStatement("insert into appointment (DID, PID, description) values ((select DID from doctor where dname = ?), (select PID from patient where pname = ? and fees = ?), ?)");
			    	p.setString(1, dname);
			    	p.setString(2, pname);
			    	p.setString(3, fees);
			    	p.setString(4, description);
			    	p.executeUpdate();
				    c.commit();
		            r = s.executeQuery("SELECT d.dname, p.pname, a.description, p.address, p.fees FROM patient p INNER JOIN appointment a on p.PID = a.PID INNER JOIN doctor d on d.DID = a.DID order by p.PID");
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
			        <tr><td><center><%= r.getString("dname")%></center></td>
		               <td><center><%= r.getString("pname")%></center></td>
		               <td><center><%= r.getString("description")%></center></td>
		               <td><center><%= r.getString("address")%></center></td>
		               <td><center><%= r.getString("fees")%></center></td>
		            </tr>
			<%}}%>
			</table>
  			</center>
          </p>
        </div>
       <br />
      </div>
  </div>
  <div id="footer">
    <p> &copy; 2015 <strong>Sneha</strong></p>
  </div>
</div>
</body>
</html>
