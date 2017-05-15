package ro.fortech.dao.jdbcTemplate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import ro.fortech.dao.UserDAO;
import ro.fortech.model.*;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by Tamas on 5/12/2017.
 */
@Component
public class JdbcTemplateUserDAO implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    private String userDetailsForQuery = "Select u.id, " +
            "u.first_name, " +
            "u.last_name, " +
            "u.email, " +
            "u.password, " +
            "u.phone_number, " +
            "r.role_name " +

            "from users u join user_role_relation ur on u.id = ur.user_id "+
            "join roles r on ur.role_id = r.id ";

    public JdbcTemplateUserDAO(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public Collection<User> getAll() {
        String query = userDetailsForQuery;

        return jdbcTemplate.query(query, new UserResultSetExtractor());
    }

    @Override
    public User findById(Long id) {
        String query = userDetailsForQuery +
                " where u.id = ?";
        Collection<User> users =  jdbcTemplate.query(query, new UserResultSetExtractor(), id);
        User result;
        if (users.size() != 1) {
            result = null;
        } else {
            result = users.iterator().next();
        }
        return result;
    }

    @Override
    public User update(User model) {
        String sql = "";
        Long newId = null;
        if (model.getId() > 0) {
            sql = "update users set first_name = ?," +
                    " last_name = ?," +
                    " email = ?," +
                    " password = ?," +
                    " phone_number = ? "
                    + "where id = ? returning id";
            newId = jdbcTemplate.queryForObject(sql, new Object[]{
                    model.getFirstName(),
                    model.getLastName(),
                    model.getEmail(),
                    model.getPassword(),
                    model.getPhoneNumber(),

                    model.getId()

            }, new RowMapper<Long>() {
                public Long mapRow(ResultSet rs, int arg1) throws SQLException {
                    return rs.getLong(1);
                }
            });

        } else {
            sql = "insert into users (first_name, last_name, email, password, phone_number, enabled) "
                    + "values(?," +
                            " ?," +
                            " ?," +
                            " ?," +
                            " ?," +
                            " true" +
                            ") returning id";

            newId = jdbcTemplate.queryForObject(sql, new Object[]{
                    model.getFirstName(),
                    model.getLastName(),
                    model.getEmail(),
                    bCryptPasswordEncoder.encode(model.getPassword()),
                    model.getPhoneNumber(),

            }, new RowMapper<Long>() {
                public Long mapRow(ResultSet rs, int arg1) throws SQLException {
                    return rs.getLong(1);
                }
            });

            for(Role role : model.getRoles()) {
                jdbcTemplate.update("INSERT INTO user_role_relation(role_id, user_id) VALUES("
                                            + "(SELECT id from roles WHERE role_name=?), "
                                            + "(SELECT id from users WHERE email=?) )",
                                           role.name(), model.getEmail());
            }
        }
        model.setId(newId);

        return model;
    }

    @Override
    public User findByUserName(String username) {
        String query = userDetailsForQuery + "WHERE email= ?";
        Collection<User> users = jdbcTemplate.query(query,new UserResultSetExtractor(),username);
        User user;
        if (users.size()!=1){
            user=null;
        }else {

            user = users.iterator().next();
        }
        return user;
    }

    @Override
    public boolean delete(User model) {
        boolean flag1 = jdbcTemplate.update("DELETE from user_role_relation WHERE user_id=?", model.getId()) > 0;
        boolean flag2 = jdbcTemplate.update("delete from users where id=?", model.getId()) > 0;
        if(flag1 && flag2) {
            return true;
        } else {
            return false;
        }
    }

    private static class UserResultSetExtractor implements ResultSetExtractor<Collection<User>> {
        @Override
        public Collection<User> extractData(ResultSet rs) throws SQLException, DataAccessException {
            Map<Long,User> users = new HashMap<>();
            while (rs.next()) {
                long id = rs.getLong("id");
                if(users.keySet().contains(id)) {
                    users.get(id).getRoles().add(Role.valueOf(rs.getString("role_name")));
                } else {
                    User user = new User();
                    user.setId(id);
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhoneNumber(rs.getString("phone_number"));
                    user.getRoles().add(Role.valueOf(rs.getString("role_name")));

                    users.put(id, user);
                }
            }
            return users.values();
        }
    }
}
