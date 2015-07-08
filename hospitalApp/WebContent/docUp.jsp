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
      <li><a href="dochome.jsp">Home</a></li>
      <li><a href="docSearch.jsp">Search a Doctor</a></li>
      <li><a href="docInsert.jsp">Insert a Doctor</a></li>
      <li><a href="docUpdate.jsp">Update a Doctor</a></li>
      <li><a href="docDelete.jsp">Delete a Doctor</a></li>
    </ul>
  </div>
  
  <div id="content-wrap">
    <div id="content">
      <div id="main">
        <div class="post"> <a name="TemplateInfo"></a>
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
             <% String list = request.getParameter("list");
                String pname = request.getParameter("pname");
  			    String description = request.getParameter("description");
     			String fees = request.getParameter("fees");
     			String address = request.getParameter("address");
                String pop = request.getParameter("demo");
  			    System.out.print(pop +" "+list +" "+ pname +" "+ description +" "+ fees +" "+ address);
  			 if((list!= null && !list.isEmpty()) && (pname!= null && !pname.isEmpty()) && (description!= null && !description.isEmpty()) && 
  					 (fees!= null && !fees.isEmpty() ) && (address!= null && !address.isEmpty() )){
  				if(pop.equals("Yes"))
		    	{
			    	p = c.prepareStatement("update patient set pname = ?, address =? , fees = ? where PID = '"+ list +"'");
			    	p.setString(1, pname);
			    	p.setString(2, address);
			    	p.setString(3, fees);
				    p.executeUpdate();
			    	p = c.prepareStatement("update appointment set description = ? where PID = '"+ list +"'");
			    	p.setString(1, description);
			    	p.executeUpdate();
				    c.commit();
		            r = s.executeQuery("SELECT d.dname, p.pname, a.description, p.address, p.fees FROM patient p INNER JOIN appointment a on p.PID = a.PID INNER JOIN doctor d on d.DID = a.DID order by p.PID");
		    	}else{
  					System.out.print("in no");
		            r = s.executeQuery("SELECT d.dname, p.pname, a.description, p.address, p.fees FROM patient p INNER JOIN appointment a on p.PID = a.PID INNER JOIN doctor d on d.DID = a.DID order by p.PID");
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
			        <tr><td><center><%= r.getString("dname")%></center></td>
		               <td><center><%= r.getString("pname")%></center></td>
		               <td><center><%= r.getString("description")%></center></td>
		               <td><center><%= r.getString("address")%></center></td>
		               <td><center><%= r.getString("fees")%></center></td>
		            </tr>
			<%}}%>
			</table>	
        </center>
      <br>
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