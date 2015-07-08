<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
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
              <h2>Welcome <%= (String)session.getAttribute("user")%></h2><br>
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
              <%
                String list = request.getParameter("list");
                String pop = request.getParameter("demo");
                System.out.print(list +" "+pop);
                if(pop.equals("Yes")){
                  s.execute("delete from admin where DID = '" + list + "'");
                  s.execute("delete from doctor where DID = '" + list + "'");
		    	  r = s.executeQuery("select * from doctor order by DID");
		    	}else {
			      r = s.executeQuery("select * from doctor order by DID");
		    	}
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
		<% }%>
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