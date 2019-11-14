package www;

/*
import java.sql.*;
*/
import www.User;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class UserDao {
	private static final String PERSISTENCE_UNIT_NAME = "Login";
	private static EntityManagerFactory factory;
	
	public int registerUser(User user) throws ClassNotFoundException {/*
        String INSERT_USERS_SQL = "INSERT INTO users" + "  (username, password) VALUES " + " (?, ?);";

        int result = 0;

        Class.forName("com.mysql.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","rootgt3655^^");
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());

            System.out.println(preparedStatement);
           
            result = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
        return result;*/
		factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
		EntityManager em = factory.createEntityManager();
		
		int result = 0;
		 Query q = em.createQuery("SELECT u FROM User u");
         @SuppressWarnings("unchecked")
		List<User> userList = q.getResultList();
         for (User temp : userList) {
              if(temp.getUsername().equals(user.getUsername())) {
            	  result++;
            	  return result;
              }
         }
		
		em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();

		return result;
		
    }
}
