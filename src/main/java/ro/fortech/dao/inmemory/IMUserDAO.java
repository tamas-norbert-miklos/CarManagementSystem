package ro.fortech.dao.inmemory;

import ro.fortech.dao.UserDAO;
import ro.fortech.model.User;

/**
 * Created by Tamas on 5/11/2017.
 */

public class IMUserDAO extends IMBaseDAO<User> implements UserDAO {
    @Override
    public User findByUserName(String username) {
        return null;
    }
}
