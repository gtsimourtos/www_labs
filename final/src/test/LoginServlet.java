package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;



/**
 *james
 */

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1;
    //private LoginDao loginDao;

    /*public void init() {
        loginDao = new LoginDao();
    }*/

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginBean loginBean = new LoginBean();
        loginBean.setUserName(username);
        loginBean.setPassword(password);

        try {
            if (loginBean.validate() == "success") {
                HttpSession session = request.getSession();
                session.setAttribute("username",username);
            	Cookie loginCookie = new Cookie("username",username);
    			//setting cookie to expiry in 60 mins
    			loginCookie.setMaxAge(60*60);
    			response.addCookie(loginCookie);
                response.sendRedirect("loginsuccess.jsp");
            } else {
                //HttpSession session = request.getSession();
                //session.setAttribute("user", username);
                response.sendRedirect("login.jsp?fail=yes");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

