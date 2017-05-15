package ro.fortech.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import ro.fortech.dao.UserDAO;
import ro.fortech.model.User;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Tamas on 5/11/2017.
 */
@Service
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public Collection<User> listAll() {
        return userDAO.getAll();
    }

    public User searchByUsername(String username) {
        return userDAO.findByUserName(username);
    }

    public boolean delete(Long id) {
        User user = userDAO.findById(id);
        if (user != null) {
            userDAO.delete(user);

            return true;
        }
        return false;
    }

    public User get(Long id) {
        return userDAO.findById(id);

    }

    public void save(User user) throws ValidationException {
        validate(user);

        userDAO.update(user);
    }

    private void validate(User user) throws ValidationException {

        List<String> errors = new LinkedList<String>();
        if (StringUtils.isEmpty(user.getFirstName())) {
            errors.add("First Name is Empty");
        }

        if (StringUtils.isEmpty(user.getLastName())) {
            errors.add("Last Name is Empty");
        }

        if (StringUtils.isEmpty(user.getPhoneNumber())) {
            errors.add("Phone Number is Empty");
        }

        if (StringUtils.isEmpty(user.getEmail())) {
            errors.add("Email is Empty");
        }

        if (StringUtils.isEmpty(user.getPassword())) {
            errors.add("Password is Empty");
        }

        if (!errors.isEmpty()) {
            throw new ValidationException(errors.toArray(new String[] {}));
        }
    }

}
