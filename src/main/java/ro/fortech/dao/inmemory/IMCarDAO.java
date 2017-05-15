package ro.fortech.dao.inmemory;

import ro.fortech.dao.CarDAO;
import ro.fortech.model.Car;
import ro.fortech.model.EngineType;
import ro.fortech.model.TransmissionType;

import java.util.*;

/**
 * Created by Tamas on 4/30/2017.
 */
//@Component
public class IMCarDAO extends IMBaseDAO<Car> implements CarDAO {
    public IMCarDAO() {
        Car car = new Car();
        car.setManufacturer("Audi");
        car.setSellerId(1);
        car.setType("A5");
        car.setFabricationYear(2005);
        car.setMileAge(12000);
        car.setPrice(5000);
        car.setEngineType(EngineType.DIESEL);
        car.setTransmissionType(TransmissionType.MANUAL);
        car.setColour("Blue");
        car.setExtras("Some extras");
        car.setMatriculated(true);
        car.setImgUrl("1494507751809_audi-a5.jpg");

        Car car2 = new Car();
        car2.setManufacturer("Audi");
        car2.setSellerId(1);
        car2.setType("A4");
        car2.setFabricationYear(2010);
        car2.setMileAge(50000);
        car2.setPrice(6000);
        car2.setEngineType(EngineType.PETROL);
        car2.setTransmissionType(TransmissionType.AUTOMATIC);
        car2.setColour("Blue");
        car2.setExtras("Some more extras");
        car2.setMatriculated(true);
        car2.setImgUrl("1494507766547_audi-a4.jpg");

        Car car3 = new Car();
        car3.setManufacturer("Ferrari");
        car3.setSellerId(2);
        car3.setType("458 Italia");
        car3.setFabricationYear(2007);
        car3.setMileAge(50000);
        car3.setPrice(6000);
        car3.setEngineType(EngineType.PETROL);
        car3.setTransmissionType(TransmissionType.AUTOMATIC);
        car3.setColour("Red");
        car3.setExtras("Some more extras");
        car3.setMatriculated(true);
        car3.setImgUrl("1494507632680_ferrari458.jpg");

        update(car);
        update(car2);
        update(car3);
        System.out.println(car.getId());
        System.out.println(car2.getId());
        System.out.println(car3.getId());
    }

    @Override
    public Collection<Car> getCarListOfSeller(long sellerId) {
        Collection<Car> cars = new LinkedList<>();

        for (Car car : getAll()){
            if (car.getSellerId()== sellerId){
                cars.add(car);
            }
        }
        return cars;
    }

    @Override
    public Map<String, List<String>> getCarManufacturersAndTypes() {
        Map<String,List<String>> cars = new LinkedHashMap<>();

        List<String> audis = new LinkedList<>();
        audis.add("A4");
        audis.add("A5");
        List<String> vw = new LinkedList<>();
        vw.add("Golf");
        vw.add("Polo");

        List<String> ferraris = new LinkedList<>();
        ferraris.add("Laferrari");
        ferraris.add("458 Italia");

        cars.put("Audi",audis);
        cars.put("Vw", vw);
        cars.put("Ferrari", ferraris);

        return cars;
    }

    @Override
    public List<String> getAllColors() {
        List<String> colours = new LinkedList<>();
        colours.add("All");
        colours.add("Blue");
        colours.add("White");
        colours.add("Red");
        colours.add("Grey");
        return colours;
    }
}
