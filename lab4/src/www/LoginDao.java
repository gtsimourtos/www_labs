package www;

/*
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
*/
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import www.Login;

public class LoginDao {
	
	private static final String PERSISTENCE_UNIT_NAME = "Login";
	private static EntityManagerFactory factory;
	public boolean validate(Login login) throws ClassNotFoundException {/*
	        boolean status = false;

	        Class.forName("com.mysql.jdbc.Driver");

	        try (Connection connection = DriverManager
	            .getConnection("jdbc:mysql://localhost:3306/mydb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","rootgt3655^^");

	            PreparedStatement preparedStatement = connection
	            .prepareStatement("select * from users where username = ? and password = ? ")) {
	            preparedStatement.setString(1, login.getUsername());
	            preparedStatement.setString(2, login.getPassword());

	            System.out.println(preparedStatement);
	            ResultSet rs = preparedStatement.executeQuery();
	            status = rs.next();

	        } catch (SQLException e) {
	            printSQLException(e);
	        }
	        return status;*/
	boolean flag= false;
	factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	EntityManager em = factory.createEntityManager();
	Query q = em.createQuery("SELECT u FROM Login u WHERE u.username = :login AND u.password = :pass");
	q.setParameter("login", login.getUsername());
	q.setParameter("pass", login.getPassword());
	try{
		Login login2 = (Login) q.getSingleResult();
		if (login.getUsername().equalsIgnoreCase(login2.getUsername())&&login.getPassword().equals(login2.getPassword())) {
			flag=true;
		}
	}catch(Exception e){      
		return false;
	}

	return flag;
	}
}
