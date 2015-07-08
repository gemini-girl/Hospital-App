<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function listval(){
	if( document.form.list.value == "" ){
        document.getElementById('Error').innerHTML="Please select a ID from the list";
        return false;
    }else {
        document.getElementById('Error').innerHTML="";
    }
}
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
        document.getElementById('fError').innerHTML="Addres field is empty";
        return false;
    }else {
        document.getElementById('fError').innerHTML="";
    }
}
function popup(){
    var x;
    if (confirm("Are you sure you want to update?") == true) {
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
        <div class="post"> <a name="TemplateInfo"></a>
          <p><center>      
              <h2>Welcome <%= (String)session.getAttribute("user")%></h2><br>
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
              	Select a ID from the list to Update:<select name = "list">
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
             <form name = "myform" onsubmit="return validation();" action= "admUp.jsp">
  			 <p>Doctor Name:<input style="margin-right:30px;margin-left:30px" name = "dname" type = "text" value = "<%= r.getString("dname") %>" />
  			 <p>Speciality: <input style="margin-right:30px;margin-left:30px" name = "speciality" type = "text" value = "<%= r.getString("speciality") %>"/> 	
  			 <p>Room Number:<input style="margin-right:30px;margin-left:30px" name = "roomno" type = "text" value = "<%= r.getString("roomNo") %>"/>
  			 <p>Address:<input style="margin-right:30px;margin-left:30px" name = "address" type = "text" value = "<%= r.getString("address") %>"/>
  			 <input name = "list" type = "text" value = "<%= list %>" hidden/>  			 
  			 <p><input value = " Update " type = "submit" onclick="popup()" ></input>
  			 <p><b><div style="color:red; font-size:80%" id ="fError"> </div></b></p><br>
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
