<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import= "javax.servlet.RequestDispatcher, java.sql.*, hospitalApp.*" %>
 
 <%!
 	String user, pwd;
	RequestDispatcher rd = null;
	Connection c = null;
	Statement s;
	ResultSet r;
	String pass;
 %>
 <% 
    Class.forName("oracle.jdbc.driver.OracleDriver");
    c=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "one", "two");
    s = c.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

    try{
	user = request.getParameter("user");
	pwd = request.getParameter("pwd");
	session.setAttribute("user", user);
	
	if(user.equals("admin") && pwd.equals("admin")){
		rd = request.getRequestDispatcher("admhome.jsp");
		rd.forward(request, response);
	}else if(user.equals("doctor") && pwd.equals("doctor")){
		rd = request.getRequestDispatcher("dochome.jsp");
		rd.forward(request, response);
	}else {
		r = s.executeQuery("select pname from patient where pname ='" +user+"'");
	    r.absolute(1);
	    String pname = r.getString("pname");
	    if(user.equals(pname) && pwd.equals(pname)){
		rd = request.getRequestDispatcher("pathome.jsp");
		rd.forward(request, response);
	}}
	}catch(Exception e){
		System.out.print(e.getMessage());
		e.printStackTrace();
	}
%>