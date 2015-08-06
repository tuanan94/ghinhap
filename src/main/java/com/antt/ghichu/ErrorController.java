package com.antt.ghichu;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Error Controller. handles the calls for 404, 500 and 401 HTTP Status codes.
 */
@Controller
@RequestMapping(value = ErrorController.ERROR_URL, produces = "text/plain;charset=UTF-8")
public class ErrorController {


    /**
     * The constant ERROR_URL.
     */
    public static final String ERROR_URL = "/error";


    /**
     * The constant TILE_ERROR.
     */
    public static final String TILE_ERROR = "error.page";


    /**
     * Page Not Found.
     *
     * @return Home Page
     */
    @RequestMapping(value = "/404", produces = "text/plain;charset=UTF-8")
    public ModelAndView notFound(HttpServletRequest request) {

        ModelAndView model = new ModelAndView(TILE_ERROR);
        model.addObject("message", "The page you requested could not be found. This location may not be current.");
        
        String URL = request.getRequestURL().toString();
        String restOfTheUrl = (String) request.getAttribute(
    	        HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        
        System.out.println("Current URL: " + restOfTheUrl);
        
        
        
        return model;
    }

    /**
     * Error page.
     *
     * @return the model and view
     */
    @RequestMapping(value = "/500", produces = "text/plain;charset=UTF-8")
    public ModelAndView errorPage() {
        ModelAndView model = new ModelAndView(TILE_ERROR);
        model.addObject("message", "The page you requested could not be found. This location may not be current, due to the recent site redesign.");

        return model;
    }
}