/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.entities.paypal;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author DELL
 */
public class PayPalConfig {
    
    private String authToken;
    private String posturl;
    private String business;
    private String returnurl;
    private String cancelurl;
    private String cmd;

    public String getAuthToken() {
        return authToken;
    }

    public String getPosturl() {
        return posturl;
    }

    public String getBusiness() {
        return business;
    }

    public String getReturnurl() {
        return returnurl;
    }

    public String getCancelurl() {
        return cancelurl;
    }

    public String getCmd() {
        return cmd;
    }
    
    public PayPalConfig getConfig(HttpServletRequest request){
        PayPalConfig pc=new PayPalConfig();
        try{
            pc.authToken=request.getServletContext().getInitParameter("authtoken");
            pc.posturl=request.getServletContext().getInitParameter("posturl");
            pc.business=request.getServletContext().getInitParameter("business");
            pc.returnurl=request.getServletContext().getInitParameter("returnurl");            
        }catch(Exception ex){
            pc=null;
        }
        return pc; 
    }
    
    
}
