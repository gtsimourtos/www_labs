<!DOCTYPE html>
<html>
<head>

<title>StudentsBase - Welcome</title>
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

.tweet-body {
  width: 100%;
  text-align: center;
}

.tweet-body textarea {
  overflow: hidden;
  resize: none;
  font-size: 14px;
}

.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
}

.title {
  color: grey;
  font-size: 18px;
}

button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
}

a {
  text-decoration: none;
  color: black;
}

button:hover, a:hover {
  opacity: 0.7;

</style>
</head>


<body style="background-image: url(sea1.jpg)">
<ul>
    <li><a class = "active" href="land.html">Home</a></li>
    <li><a href="users_list.html">Users</a></li>
  <li><a href="subjects.html">Subjects</a></li>
    <li style = "float:right"> <a href="https://github.com/gtsimourtos/www_labs/raw/master/final/ECE_426_Final_Project_manual.pdf">Readme</a></li>
  </ul>
<br><br><br>
 <h1 style = "text-align:center;color:black">User successfully registered!</h1>

 <h2 style = "text-align:center;color:black">Welcome to StudentsBase.</h2>

<div class="card"><p><a href="login.jsp"><button>Login</button></a></p></div>
<div class="card"><p><a href="register.jsp"><button>Register</button></a></p></div>

</body>
</html>