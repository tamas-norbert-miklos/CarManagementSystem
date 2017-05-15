package ro.fortech.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import ro.fortech.model.User;
import ro.fortech.service.SecurityService;
import ro.fortech.service.UserService;
import ro.fortech.service.ValidationException;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Tamas on 5/12/2017.
 */
@Controller
public class UserController {

    @Autowired
    SecurityService securityService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        ModelAndView modelAndView = new ModelAndView("login");

        return modelAndView;
    }

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public ModelAndView signUp() {
        ModelAndView modelAndView = new ModelAndView("signup");
        modelAndView.addObject("user", new User());

        return modelAndView;
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public ModelAndView registration(User user, BindingResult bindingResult) {

        ModelAndView modelAndView = new ModelAndView();

        if (!bindingResult.hasErrors()) {
            try {

                userService.save(user);
                securityService.autologin(user.getEmail(), user.getPassword());

                RedirectView redirectView = new RedirectView("car/list");
                modelAndView.setView(redirectView);
            } catch (ValidationException ex) {
                List<String> errors = new LinkedList<>();
                errors.add(ex.getMessage());
                modelAndView = new ModelAndView("signup");
                modelAndView.addObject("errors", errors);
                modelAndView.addObject("user", user);
            }
        } else {
            List<String> errors = new LinkedList<>();

            for (FieldError error:
                    bindingResult.getFieldErrors()) {
                errors.add(error.getField() + ":" + error.getCode());
            }

            modelAndView = new ModelAndView("signup");
            modelAndView.addObject("errors", errors);
            modelAndView.addObject("user", user);
        }

        return modelAndView;
    }

    @RequestMapping("/logout")
    public String onLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "/";
    }

}
