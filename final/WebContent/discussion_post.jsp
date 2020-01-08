<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 

<!DOCTYPE html>
<html>

<%
//allow access only if session exists
String disc_id = request.getParameter("discussion");
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

<title>StudentsBase - Discussion post</title>
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
<ul>
    <li><a href= user_test.jsp >My Profile</a></li>
    <li><a href="users_list.jsp">Users</a></li>
    <li><a class = "active" href="subjects.jsp">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
    <li style = "float:right"> <a href="logout.jsp">Logout</a></li>
</ul>

  <h1 style = "text-align:center;color:black">Post in discussion </h1>
  <h2 style = "text-align:center">
    <div align = "center">
    <form method="post"  action="discussion_post.jsp?discussion=<%=disc_id%>" >
      <textarea class="status" name="status" placeholder="Insert text" rows="5" cols="60"></textarea><br>
      <input type="submit" value="Submit" />
      <br>
    
<%    
    String connectionURL = "jdbc:mysql://localhost:3306/db?serverTimezone=UTC";
Connection connection = null;
PreparedStatement pstatement = null;
int updateQuery = 0;
String status = request.getParameter("status");
if(status != null)	{

try {
	
Class.forName("com.mysql.cj.jdbc.Driver").getConstructor().newInstance();
connection = DriverManager.getConnection(connectionURL,"root","rootgt3655^^");
String queryString = "insert into posts(FK2_disc_id,FK1_username, answer) values(?,?,?)";
pstatement = connection.prepareStatement(queryString);
pstatement.setString(1, disc_id);
pstatement.setString(2, userName);
pstatement.setString(3, status);
updateQuery = pstatement.executeUpdate();
if (updateQuery != 0) {%>
<br>
<TABLE style="background-color: #E3E4FA;" border="1">
<tr><th>Data is inserted successfully in database.</th></tr>
<% response.sendRedirect("discussions_form.jsp?discussion="+disc_id);%>
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
}
%>
</form> 
</div>   
  
</h2>


</body>
</html>