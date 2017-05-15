package ro.fortech.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import ro.fortech.dao.CarDAO;
import ro.fortech.model.Car;
import ro.fortech.model.EngineType;
import ro.fortech.model.SearchModel;
import ro.fortech.model.TransmissionType;

import java.util.*;

/**
 * Created by Tamas on 4/22/2017.
 */
@Service
public class CarService {

    @Autowired
    private CarDAO dao;

    public Collection<Car> listAll() {
        return dao.getAll();
    }

    public boolean delete(Long id) {
        Car car = dao.findById(id);
        if (car != null) {
            dao.delete(car);
            return true;
        }

        return false;
    }
    public Collection<Car> search(SearchModel searchModel) {
        String manufacturer = searchModel.getManufacturer();
        String type = searchModel.getType();
        int fromYear = searchModel.getFabricationYear();
        int mileAge = searchModel.getMileAge();
        int price = searchModel.getPrice();
        List<EngineType> engineTypes = searchModel.getEngineType();
        List<TransmissionType> transmissionTypes = searchModel.getTransmissionType();
        String color = searchModel.getColour();
        Collection<Car> cars = search(manufacturer, type, fromYear,
                                    mileAge, price, engineTypes, transmissionTypes, color);
        return cars;

    }

    public Collection<Car> search(String manufacturer, String type, int fromYear,
                                  int mileAge, int price, List<EngineType> engineTypes,
                                  List<TransmissionType> transmissionTypes, String colour) {

        Collection<Car> allCars = new LinkedList<>(dao.getAll());

        if (manufacturer != null) {
            allCars = filterByManufacturer(manufacturer, allCars);
        }
        if (type != null) {
            allCars = filterByType(type, allCars);
        }
        if (fromYear != 0) {
            allCars = filterByFabricationYear(fromYear, allCars);
        }
        if (mileAge != 0) {
            allCars = filterByMileAge(mileAge, allCars);
        }
        if (price != 0) {
            allCars = filterByPrice(price, allCars);
        }
        if (EngineType.values().length != engineTypes.size()) {
            allCars = filterByEngineType(engineTypes, allCars);
        }
        if (TransmissionType.values().length != transmissionTypes.size()) {
            allCars = filterByTransmissionType(transmissionTypes, allCars);
        }
        if (colour != null) {
            allCars = filterByColour(colour, allCars);
        }

        return allCars;
    }

    private Collection<Car> filterByManufacturer(String manufacturer, Collection<Car> cars) {
        if(!manufacturer.equalsIgnoreCase("All")) {
            cars.removeIf((Car car) -> !car.getManufacturer().equalsIgnoreCase(manufacturer));
        }
        return cars;
    }

    private Collection<Car> filterByType(String type, Collection<Car> cars) {
        if(!type.equalsIgnoreCase("All")) {
            cars.removeIf((Car car) -> !car.getType().equalsIgnoreCase(type));
        }
        return cars;
    }

    private Collection<Car> filterByFabricationYear(int fromYear, Collection<Car> cars) {
        cars.removeIf((Car car) -> car.getFabricationYear() < fromYear);

        return cars;
    }

    private Collection<Car> filterByMileAge(int maxMileAge, Collection<Car> cars) {
        cars.removeIf((Car car) -> car.getMileAge() > maxMileAge);

        return cars;
    }

    private Collection<Car> filterByPrice(int price, Collection<Car> cars) {
        cars.removeIf((Car car) -> car.getPrice() > price);

        return cars;
    }

    private Collection<Car> filterByEngineType(List<EngineType> engineTypes, Collection<Car> cars) {

        cars.removeIf((Car car) -> !engineTypes.contains(car.getEngineType()));

        return cars;
    }

    private Collection<Car> filterByTransmissionType(List<TransmissionType> transmissionTypes, Collection<Car> cars) {

        cars.removeIf((Car car) -> !transmissionTypes.contains(car.getTransmissionType()));

        return cars;
    }

    private Collection<Car> filterByColour(String colour, Collection<Car> cars) {
        if(!colour.equalsIgnoreCase("all")) {
            cars.removeIf((Car car) -> !car.getColour().equalsIgnoreCase(colour));
        }
        return cars;
    }


    public Car save(Car car) throws ValidationException {
        validate(car);
        return dao.update(car);
    }

    private void validate(Car car) throws ValidationException {
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        List<String> errors = new LinkedList<String>();
        if (StringUtils.isEmpty(car.getManufacturer())) {
            errors.add("Car Manufacturer is Empty");
        }

        if (StringUtils.isEmpty(car.getType())) {
            errors.add("Car Type is Empty");
        }

        if(car.getFabricationYear() == 0) {
            errors.add("Fabrication Year is Empty");
        } else {
            if(car.getFabricationYear() > currentYear) {
                errors.add("Car fabrication date in future");
            }

            if (car.getFabricationYear() < 1950) {
                errors.add("Car is too old");
            }
        }

        if (car.getMileAge() < 0) {
            errors.add("The cars mileage cannot be a negative value.");
        }

        if (car.getPrice() < 0) {
            errors.add("The cars price cannot be a negative value.");
        }

        if (!Arrays.asList(EngineType.values()).contains(car.getEngineType())) {
            errors.add("Invalid engine type");
        }

        if (!Arrays.asList(TransmissionType.values()).contains(car.getTransmissionType())) {
            errors.add("Invalid transmission type");
        }

        if(car.getExtras() == null) {
            errors.add("Description is missing");
        }

        if (!errors.isEmpty()) {
            throw new ValidationException(errors.toArray(new String[] {}));
        }
    }

    public CarDAO getDao() {
        return dao;
    }

    public void setDao(CarDAO dao) {
        this.dao = dao;
    }

    public Map<String, List<String>> getManufacturersAndTypes() {
        return dao.getCarManufacturersAndTypes();
    }

    public List<String> getAllColors() {
         return dao.getAllColors();
    }

    public Car getById(long id) {
        return dao.findById(id);
    }

}
