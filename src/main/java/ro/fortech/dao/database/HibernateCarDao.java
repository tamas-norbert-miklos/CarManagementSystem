package ro.fortech.dao.database;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import ro.fortech.dao.CarDAO;
import ro.fortech.model.Car;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Created by Tamas on 5/9/2017.
 */

public class HibernateCarDao implements CarDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Collection<Car> getAll() {
        return null;
    }

    @Override
    public Car findById(Long id) {
        return null;
    }

    @Override
    public Car update(Car model) {
        return null;
    }

    @Override
    public boolean delete(Car model) {
        return false;
    }

    @Override
    public Map<String, List<String>> getCarManufacturersAndTypes() {
        return null;
    }

    @Override
    public List<String> getAllColors() {
        return null;
    }

    @Override
    public Collection<Car> getCarListOfSeller(long sellerId) {
        return null;
    }
}
