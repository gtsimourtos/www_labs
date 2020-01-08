<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<%  
String disc_id = request.getParameter("discussion");
%>

<!DOCTYPE html>
<html>
<%
//allow access only if session exists
String user = null;
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
%>
<head>

<title>StudentsBase - Discussions</title>
<style> body{margin:0;height:100%;font-size:120%;
background-image: url("sea1.jpg");font-family:courier;
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
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>


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
PreparedStatement pstatement = null, pstatement2 = null;
// declare a resultset that uses as a table for output data from tha table.
ResultSet rs = null, rs2 = null;
// Load JBBC driver "com.mysql.jdbc.Driver"
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
/* Create a connection by using getConnection() method that takes parameters 
of string type connection url, user name and password to connect to database.*/
connection = DriverManager.getConnection(connectionURL, "root", "rootgt3655^^");
/* createStatement() is used for create statement object that is used for 
sending sql statements to the specified database. */
// sql query to retrieve values from the secified table.
String queryString = "SELECT question,FK2_username,title from discussions where disc_id = ?";
pstatement = connection.prepareStatement(queryString);
pstatement.setString(1, disc_id);
rs = pstatement.executeQuery();
rs.next();
%>




<div style = "width: auto;
  border: 2px solid black;
  padding: 10px;
  margin: 50px;color:black; background-color:#4CAF50" align = "center"> 
  <h1><%=rs.getString(3)%></h1>
<h3 style = "text-align: left"><a href=""><%=rs.getString(2)%>:<br></a><%=rs.getString(1)%></h3><br>
<div id = "link_bar">
<a href="discussion_post.jsp?discussion=<%=disc_id%>">+Answer</a>
</div>
</div>

<hr>
<hr>
<hr>
<h1 style = "text-align:center">User posts</h1>

<%
queryString = "SELECT FK1_username,answer from posts where FK2_disc_id = ?";
pstatement2 = connection.prepareStatement(queryString);
pstatement2.setString(1, disc_id);
rs2 = pstatement2.executeQuery();
while (rs2.next()) {
%>

<div style = "width: auto;
  border: 2px solid black;
  padding: 10px;
  margin: 50px;color:black; background-color:white;font-size:100%;">
<h3><a href="user_test.jsp?username=<%=rs2.getString(1)%>"><%=rs2.getString(1)%>:</a></h3>
<p><%=rs2.getString(2)%></p>
</div>

<%
}
pstatement.close();
pstatement2.close();
connection.close();
rs.close();
rs2.close();
} 
catch (Exception ex){
out.println("\nUnable to connect to database. " + ex);
ex.printStackTrace();
}
%>

</body>
</html>
