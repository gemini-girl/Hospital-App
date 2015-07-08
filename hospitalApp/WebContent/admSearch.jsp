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
	          r = s.executeQuery("select * from doctor order by DID");
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
			String search = request.getParameter("search");
			System.out.println(list +" "+search );%>
			<% if ((list != null) && (!list.isEmpty()) && ((search != null) && (!search.isEmpty()))){
				if(list.equals("ADDRESS")){
					r = s.executeQuery("select * from doctor where Address like '%"+ search +"%' order by DID");%>
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
				               <td><center><%= r.getString("Address")%></center></td>
				            </tr>
					
			<%}}else{
            r = s.executeQuery("select * from doctor where "+ list +"='"+ search +"' order by DID");%>
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
		               <td><center><%= r.getString("Address")%></center></td>
		            </tr>
			<% }}}else if ((search != null) && (!search.isEmpty())){
				if(search.equals("all")){
	             r = s.executeQuery("select * from doctor order by DID");%>
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
		               <td><center><%= r.getString("Address")%></center></td>
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
