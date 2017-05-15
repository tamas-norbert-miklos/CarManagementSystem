package ro.fortech.dao;

import ro.fortech.model.Car;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Created by Tamas on 4/20/2017.
 */
public interface CarDAO extends BaseDAO<Car>{

    Map<String, List<String>> getCarManufacturersAndTypes();

    List<String> getAllColors();

    Collection<Car> getCarListOfSeller(long sellerId);

}

