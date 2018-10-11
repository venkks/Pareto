package it.upspring.laabam.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by sourabhrohilla on 6/17/16.
 */
public class ReportController {

    @RequestMapping(value="/ReportsList", method = RequestMethod.GET)
    public String getReportList(){
        return "reportList";
    }
}
