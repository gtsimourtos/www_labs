<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@page import="test.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<!DOCTYPE html>
<html>
<head>

<title>StudentsBase - Find Team</title>
<style> body{margin:0;height:100%;font-size:120%;
background-image: url("sea1.jpg");font-family:courier;<!-- -->
background-position: center; <!-- Center the image -->
  background-repeat: no-repeat;
  background-size: cover; <!-- Resize the background image to cover the entire container -->
  background-color: rgba(255,255,255,0.5);background-blend-mode: lighten;}
li {
  border-right: 1px solid #bbb;
  float:left;
}


li:last-child {
  border-right: none;
}
ul {
display:block;
  list-style-type: none;
  margin: 0;
  padding: 20px;
  overflow: hidden;
  background-color: #333;
  position: fixed;
  position:sticky;
  top: 0;
  width: 100%;
}

li a {
  color: white;
  text-align: center;
  padding:  40px 56px;
  text-decoration: none;
}
.active {
  background-color: #4CAF50;
}

.tweet-body {
  width: 100%;
  text-align: center;
}

.tweet-body textarea {
  overflow: hidden;
  resize: none;
  font-size: 14px;
}
#link_bar a { padding:15px; font-weight:bold;  }
#link_bar a:link { color:white; background-color:#333; }
#link_bar a:visited { color:#c0c0c0; background-color:#333; }
#link_bar a:hover { color:#ffffff; background-color:#000060; }
#link_bar a:active { color:#f0f0f0; background-color:#00ff00; }
</style>
</head>
<body>
<%
//allow access only if session exists
String user = null;
int counter = 1;
if(session.getAttribute("username") == null){
  response.sendRedirect("land.html");
}else user = (String) session.getAttribute("username");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
  if(cookie.getValue().equals(user)) userName = cookie.getValue();
  if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
String subject = request.getParameter("subject");
%>
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>



<div style = "width: auto;
  border: 2px solid black;
  padding: 20px;
  margin: 80px;color:black; background-color:#4CAF50" align = "center"> 
  <h1><%=subject %> - Find Team</h1>
</div>

<hr>
<hr>
<hr>
<h1 style = "text-align:center">Posts</h1>

<br><br>
<%
try {
/* Create string of connection url within specified format with machine
name, port number and database name. Here machine name id localhost and 
database name is student. */
String connectionURL = "jdbc:mysql://localhost:3306/db?serverTimezone=UTC";
// declare a connection by using Connection interface
Connection connection = null;
/* declare object of Statement interface that is used for executing sql 
statements. */
Statement statement = null,statement2 = null;
// declare a resultset that uses as a table for output data from tha table.
ResultSet rs = null,rs2=null;
// Load JBBC driver "com.mysql.jdbc.Driver"
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
/* Create a connection by using getConnection() method that takes parameters 
of string type connection url, user name and password to connect to database.*/
connection = DriverManager.getConnection(connectionURL, "root", "rootgt3655^^");
/* createStatement() is used for create statement object that is used for 
sending sql statements to the specified database. */
statement = connection.createStatement();
// sql query to retrieve values from the secified table.
String QueryString = "SELECT * from discussions WHERE is_question = 0 AND FK1_name ='"+subject+"'";
rs = statement.executeQuery(QueryString);
statement2 = connection.createStatement();
//sql query to retrieve values from the secified table.

%>

<TABLE cellpadding="15" border="1" style="background-color: #ffffcc;" align="center">
<TR>
<TD><b>USERNAME</b></TD>
<TD><b>TITLE</b></TD>
<TD><b>REQUEST</b></TD>
<TD><b>CONTACT</b></TD>
</TR>
<%
while (rs.next()) {
%>
<TR>
<TD><a href="user_test.jsp?username=<%=rs.getString(6)%>"><%=rs.getString(6)%></a></TD>
<TD><%=rs.getString(2)%></TD>
<TD>
User <%=rs.getString(6)%> <%=rs.getString(4)%></TD>
<%
QueryString = "SELECT email from users WHERE username ='"+rs.getString(6)+"'";
rs2 = statement2.executeQuery(QueryString);
rs2.next();
%>
<TD>
<a href="mailto:<%=rs2.getString(1)%>">Mail <%=rs.getString(6)%></a>
</TD>
<%if(userName.equals(rs.getString(6))) {
	%><TD><a href="del_entry.jsp?username=<%=rs.getString(6)%>&subject=<%=rs.getString(5)%>&title=<%=rs.getString(2)%>&is_question=<%=rs.getString(3)%>">DELETE</a></TD>
<%	
}
%>

</TR>
<% } %>


<%
// close all the connections.
rs.close();
rs2.close();
statement.close();
statement2.close();
connection.close();
} catch (Exception ex) {
  //out.println("Unable to connect to database.");
  }
%>
</TABLE>

<BR><br>

<div id = "link_bar">
<li> <a href="team_create.jsp?counter=<%=counter%>&subject=<%=subject%>">+Request your own team</a></li>
</div>

</body>
</html>
