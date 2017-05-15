package ro.fortech.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import ro.fortech.model.Car;
import ro.fortech.model.User;
import ro.fortech.service.CarService;
import ro.fortech.service.UserService;
import ro.fortech.service.ValidationException;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Tamas
 */
@Controller
@RequestMapping("/car")
public class CarController {

    private User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName(); //get logged in username
        User currentUser = userService.searchByUsername(name);
        return currentUser;
    }

    @Value("${local.files.dir}")
    private String localFilesDir;

    @Autowired
    private CarService carService;

    @Autowired
    private UserService userService;

    private final Map<Long, String> carToLastImgURL = new HashMap<>();

    @RequestMapping("/add")
    public ModelAndView add() {
        User currentUser = getCurrentUser();

        ModelAndView modelAndView = new ModelAndView("car/add");
        modelAndView.addObject("car", new Car());

        Map<String,List<String>> map = carService.getManufacturersAndTypes();
        modelAndView.addObject("map", map);
        modelAndView.addObject("colours", carService.getAllColors());
        modelAndView.addObject("user", currentUser);
        return modelAndView;
    }

    @RequestMapping("/delete")
    public String delete(long id) {
        carService.delete(id);
        return "redirect:/car/list";
    }

    @RequestMapping("/list")
    public ModelAndView listCars() {
        ModelAndView modelAndView = new ModelAndView("car/list");
        User currentUser = getCurrentUser();
        Collection<Car> cars = carService.getDao().getCarListOfSeller(currentUser.getId());

        modelAndView.addObject("cars", cars);
        modelAndView.addObject("user", currentUser);
        return modelAndView;
    }

    @RequestMapping("/view")
    public ModelAndView viewCar(long id) {
        ModelAndView modelAndView = new ModelAndView("car/view");

        User currentUser = getCurrentUser();

        Car car = carService.getById(id);
        User seller = userService.get(car.getSellerId());

        modelAndView.addObject("car", car);
        modelAndView.addObject("seller", seller);
        modelAndView.addObject("user", currentUser);

        return modelAndView;
    }

    @RequestMapping("/edit")
    public ModelAndView edit(long id) {
        User currentUser = getCurrentUser();

        Car car = carService.getById(id);
        Map<String,List<String>> map = carService.getManufacturersAndTypes();
        ModelAndView modelAndView = new ModelAndView("car/add");
        modelAndView.addObject("map", map);
        modelAndView.addObject("colours", carService.getAllColors());
        modelAndView.addObject("car", car);
        modelAndView.addObject("user", currentUser);
        return modelAndView;
    }

    @RequestMapping("/save")
    public ModelAndView save(@Valid  Car car,
                             BindingResult bindingResult,
                             MultipartFile file) {
                            //BindingResult fileBindingResult

        User currentUser = getCurrentUser();
        ModelAndView modelAndView = new ModelAndView();

        boolean hasErrors = false;

        if (!bindingResult.hasErrors()) {
                try {
                    car.setSellerId(currentUser.getId());
                    //saving the file and setting the cars imgUrl field
                    long id = car.getId();
                    String imgUrl = null;
                    if(file != null && !file.getOriginalFilename().isEmpty()) {
                        File localFile = new File(localFilesDir, System.currentTimeMillis() +"_" + file.getOriginalFilename());
                        file.transferTo(localFile);
                        imgUrl = localFile.getName();
                        car.setImgUrl(imgUrl);

                    } else if (carToLastImgURL.containsKey(id)){

                        car.setImgUrl(carToLastImgURL.get(id));
                    }

                    car = carService.save(car);
                    if (id == 0) {
                        carToLastImgURL.put(car.getId(),imgUrl);
                    }

                    RedirectView redirectView = new RedirectView("list");
                    modelAndView.setView(redirectView);
                } catch (ValidationException ex) {
                    for (String msg : ex.getCauses()) {
                        bindingResult.addError(new ObjectError("userLogin", msg));
                    }
                    hasErrors = true;
                } catch (IOException e) {
                    bindingResult.addError(new ObjectError("fileUpload", e.getMessage()));
                }
        } else {
            hasErrors = true;
        }

        if (hasErrors){
            modelAndView = new ModelAndView("car/add");
            modelAndView.addObject("errors", bindingResult.getAllErrors());
            modelAndView.addObject("car", car);
        }

        System.out.println(car);

        return modelAndView;
    }
}
