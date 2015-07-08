<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, hospitalApp.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<script>
function validation() {
	if( document.myform.search.value == "" ){
        document.getElementById('fError').innerHTML="Search field is empty";
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
              <%!
                Statement s;
                ResultSet r;
                Connection c;
              	ResultSetMetaData md;
          	  	int count;
              %>
              <% 
              Class.forName("oracle.jdbc.driver.OracleDriver");
          	  c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
          	  s = c.createStatement();
	          r = s.executeQuery("select d.dname, p.pname, a.description, p.address, p.fees from patient p, appointment a, doctor d");
              md = r.getMetaData();
  			  count = md.getColumnCount();
  			  %>
  			  <br>
  			  <form name = "myform" onsubmit="return validation();">
  			  	<select name = "list">
  			  	<option value = "">Search by</option>
  			  	  <% for (int i=1; i<=count; i++) { %>
  			  		<option value =<%= md.getColumnLabel(i) %>><%= md.getColumnLabel(i) %></option>
  			  	  <% } %>
  			  	</select>
  			 <input style="margin-right:30px;margin-left:30px" name = "search" id = "search" type = "text"></input>
  			 <input value = "Search" type = "submit"></input>
  			 <p><b><div style="color:red; font-size:80%" id ="fError"> </div></b></p><br>
  			 </form>
  			 <% String list = request.getParameter("list");
			String search = request.getParameter("search");%>
			<% if ((list != null) && (!list.isEmpty()) && ((search != null) && (!search.isEmpty()))){
            r = s.executeQuery("SELECT d.dname, p.pname, a.description, p.address, p.fees FROM patient p INNER JOIN appointment a on p.PID = a.PID INNER JOIN doctor d on d.DID = a.DID and "+ list +"='"+ search +"' order by p.PID");%>
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
			<% }}else if ((search != null) && (!search.isEmpty())){
				if(search.equals("all")){
		         r = s.executeQuery("SELECT d.dname, p.pname, a.description, p.address, p.fees FROM patient p INNER JOIN appointment a on p.PID = a.PID INNER JOIN doctor d on d.DID = a.DID order by p.PID");%>
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
			<% }}}%>
			</table>
			
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
