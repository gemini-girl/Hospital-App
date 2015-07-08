<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script>
function listval(){
	if( document.form.list.value == "" ){
        document.getElementById('Error').innerHTML="Please select a ID from the list";
        return false;
    }else {
        document.getElementById('Error').innerHTML="";
     }}
function popup(){
        var x;
        if (confirm("Are you sure you want to delete?") == true) {
            x = "Yes";
            var pop = document.getElementById('demo');
            pop.value=x;
        } else {
            x = "No";
            var pop = document.getElementById('demo');
            pop.value=x;
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
        <div class="post"> 
          <p><center>      
              <h2></>Welcome <%= (String)session.getAttribute("user")%></h2><br>
              <%! RequestDispatcher rd;
              Connection c;
              Statement s;
              PreparedStatement p;
              ResultSet r;
              ResultSetMetaData md;
              int count;%>
              <% Class.forName("oracle.jdbc.driver.OracleDriver");
              c = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
              s = c.createStatement();
			  r = s.executeQuery("select * from doctor order by DID");
              %>
              <form name = "form" onsubmit="return listval();">
              	Select a ID from the list to Delete:<select name = "list">
              	    <option value = "">Select a ID</option>
              	    <%while(r.next()){ %>
              		<option value = <%= r.getString("DID") %>><%= r.getString("DID") %></option>
              		<%} %>
              	</select>
              	<input style= "margin-left:30px" value = "Submit" type = "submit"></input>
              	<p><b><div style="color:red; font-size:80%" id ="Error"> </div></b></p><br>
              </form>
                <% String list = request.getParameter("list");
              if (list!= null && !list.isEmpty()){
            	  r = s.executeQuery("select * from doctor where DID = '" + list + "'");
                  while(r.next()){
               %>
              <form name = "myform" action = "admDel.jsp">
   			 <p><strong>Doctor Name: </strong><%= r.getString("dname") %></p>
   			 <p><strong>Speciality: </strong><%= r.getString("speciality") %><p> 	
   			 <p><strong>Room Number: </strong><%= r.getString("roomNo") %><p>
   			 <p><strong>Address: </strong><%= r.getString("address") %></p>
   			 <input name = "list" type = "text" value = "<%= list %>" hidden/> 
   			 <input type="submit" onclick="popup()" value="Delete" /> 			 
   			 <input type="hidden" name="demo" id="demo" readonly="true"/>             
   			 </form>
			  <%String pop = request.getParameter("demo");
                System.out.println(pop);%>
   			 <%}}%>   
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

                 