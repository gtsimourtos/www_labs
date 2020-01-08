<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deleting...</title>
</head>
<body>

<%
String username = request.getParameter("username");
String title = request.getParameter("title");
String subject = request.getParameter("subject");
String flag = request.getParameter("is_question");
String connectionURL = "jdbc:mysql://localhost:3306/db?serverTimezone=UTC";
Connection connection = null;
PreparedStatement pstatement = null;
int updateQuery = 0;
try {
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
connection = DriverManager.getConnection(connectionURL,"root","rootgt3655^^");
String queryString = "delete from discussions where FK2_username = '"+username+"' and FK1_name = '"+subject+"' and is_question = "+flag +" and title = '"+title+"'";
pstatement = connection.prepareStatement(queryString);
updateQuery = pstatement.executeUpdate();
if (updateQuery != 0) {%>
<br>
<TABLE style="background-color: #E3E4FA;" border="1">
<tr><th>Data is inserted successfully in database.</th></tr>
<% 
if(flag.equals("1"))	
	response.sendRedirect("discussions.jsp?subject="+subject);
else
	response.sendRedirect("find_team.jsp?subject="+subject);
	%>
</table>

<%
}
} 
catch (Exception ex){
out.println("\nUnable to connect to database. " + ex);
ex.printStackTrace();
}finally {
// close all the connections.
pstatement.close();
connection.close();
}

%>

</body>
</html>