package ro.fortech.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ro.fortech.dao.CarDAO;

import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
/**
 * Created by Tamas on 5/9/2017.
 */

class NumberOfCars {
    private int carsInDb;

    public int getCarsInDb() {
        return carsInDb;
    }

    public void setCarsInDb(int carsInDb) {
        this.carsInDb = carsInDb;
    }

    public NumberOfCars(int carsInDb) {
        this.carsInDb = carsInDb;
    }
}

@RestController
@RequestMapping("/car")
public class WSController {

    @Autowired
    CarDAO carDAO;

    @POST
    @RequestMapping("/numberOfCars")
    @Produces(MediaType.APPLICATION_JSON)
    public NumberOfCars getAvailableCarNumber() {

        NumberOfCars numberOfCars = new NumberOfCars(carDAO.getAll().size());

        return numberOfCars;
    }

}
