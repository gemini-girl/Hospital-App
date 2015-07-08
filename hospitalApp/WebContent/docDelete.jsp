<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, hospitalApp.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function listval() {
	if( document.form.list.value == "" ){
        document.getElementById('Error').innerHTML="Select a ID";
        return false;
    }else {
        document.getElementById('Error').innerHTML="";
    }
}
function popup(){
    var x;
    if (confirm("Are you sure you want to Delete?") == true) {
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
       <li><a href="dochome.jsp" id="current">Home</a></li>
      <li><a href="docSearch.jsp">Search a Patient</a></li>
      <li><a href="docInsert.jsp">Insert a Patient</a></li>
      <li><a href="docUpdate.jsp">Update a Patient</a></li>
      <li><a href="docDelete.jsp">Delete a Patient</a></li>     </ul>
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
              r = s.executeQuery("Select PID from patient");
              %>
              <form name = "form" onsubmit="return listval();">
              	Select a Patient ID from the list to Update:<select name = "list">
              	    <option value = "">Select a ID</option>
              	    <%while(r.next()){ %>
              		<option value = <%= r.getString("PID") %>><%= r.getString("PID") %></option>
              		<%} %>
              	</select>
              	<input style= "margin-left:30px" value = "Submit" type = "submit"></input>
              	<p><b><div style="color:red; font-size:80%" id ="Error"> </div></b></p><br>
              </form>
              <% String list = request.getParameter("list");
              if (list!= null && !list.isEmpty()){
                 r = s.executeQuery("select d.dname, p.pname, a.description, p.fees, p.address from doctor d, patient p, appointment a where d.DID = a.DID and p.PID= a.PID and p.PID = '" + list + "'");
                 while(r.next()){ %>
             <form name = "myform" action = "docDel.jsp">
             <p>Doctor Name: <%= r.getString("dname")%>
             <p>Patient Name:<%= r.getString("pname")%>
  			 <p>Medical Description:<%= r.getString("description")%> 	
  			 <p>Fees:<%= r.getString("fees")%>
  			 <p>Address :<%= r.getString("address")%>
  			  <input name = "list" type = "text" value = "<%= list %>" hidden/>  			 
  			  <p><input value = " Delete " type = "submit" onclick="popup()" ></input>
  			 <p><b><div style="color:red; font-size:80%" id ="fError"> </div></b></p><br>
  			 <input type="hidden" name="demo" id="demo" readonly="true"/>
  			 </form>
  			 <%String pop = request.getParameter("demo");
                System.out.println(pop);%>
   			 <%}}%>                
   			</center>
           </p>
         </div>
        <br/>
       </div>
     </div>
   </div>
  <div id="footer">
 <p> &copy; 2015 <strong>Sneha</strong></p>
  </div>
 </div>
 </body>
 </html>