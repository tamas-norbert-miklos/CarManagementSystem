package ro.fortech.dao;

import ro.fortech.model.User;

/**
 * Created by Tamas on 5/11/2017.
 */
public interface UserDAO extends BaseDAO<User> {
    User findByUserName(String username);
}
