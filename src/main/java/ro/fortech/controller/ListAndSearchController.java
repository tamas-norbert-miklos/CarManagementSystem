package ro.fortech.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import ro.fortech.model.*;
import ro.fortech.service.CarService;
import ro.fortech.service.UserService;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Created by Tamas on 4/24/2017.
 */
@Controller
@RequestMapping("")
public class ListAndSearchController {

    @Autowired
    private UserService userService;

    @Autowired
    private CarService carService;

    private User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName(); //get logged in username
        User currentUser = userService.searchByUsername(name);
        return currentUser;
    }

    @RequestMapping("/search")
    public ModelAndView showSearch(SearchModel searchModel, BindingResult bindingResult) {
        ModelAndView modelAndView = new ModelAndView("search");

        User currentUser = getCurrentUser();
        modelAndView.addObject("user", currentUser);

        Map<String,List<String>> map = carService.getManufacturersAndTypes();

        if (searchModel.getManufacturer() == null) {
            searchModel.setManufacturer("All");
        }
        if (searchModel.getColour() == null) {
            searchModel.setColour("All");
        }
        if (searchModel.getType() == null) {
            searchModel.setType("All");
        }
        if (searchModel.getTransmissionType().size() == 0) {
            searchModel.getTransmissionType().add(TransmissionType.MANUAL);
            searchModel.getTransmissionType().add(TransmissionType.AUTOMATIC);
        }
        if (searchModel.getEngineType().size() == 0) {
            searchModel.getEngineType().add(EngineType.PETROL);
            searchModel.getEngineType().add(EngineType.DIESEL);
        }

        Collection<Car> results = carService.search(searchModel);

        modelAndView.addObject("map", map);
        modelAndView.addObject("colours", carService.getAllColors());
        modelAndView.addObject("results", results);
        modelAndView.addObject("searchModel", searchModel);

        return modelAndView;
    }

}
