/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.entities.paypal;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author DELL
 */
public class PayPalSuccess {
    public PayPalResult getPayPal(HttpServletRequest request){
        PayPalResult ppr= new PayPalResult();
        PayPalConfig pc=new PayPalConfig();
        
        pc=pc.getConfig(request);
        String[] temp =null;
        String res = "";
        try{
            String transId= request.getParameter("tx");
            String authToken = pc.getAuthToken();
            String query = "cmd=_notify-synch&tx="+transId+"&at="+authToken;
            String url=pc.getPosturl();
            URL u= new URL(url);
            HttpURLConnection req=(HttpURLConnection) u.openConnection();
            req.setRequestMethod("POST");
            req.setDoOutput(true);
            req.setDoInput(true);
            req.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            req.setFixedLengthStreamingMode(query.length());
            
            OutputStream outputstream = req.getOutputStream();
            outputstream.write(query.getBytes());
            outputstream.close();
            
            BufferedReader in= new BufferedReader(new InputStreamReader(req.getInputStream()));
            res=in.readLine();
            if(res.equals("SUCCESS")){
                while((res=in.readLine()) != null){
                    temp=res.split("=");
                    if(temp.length==1){
                        continue;
                    }
                    temp[1]=URLDecoder.decode(temp[1], "UTF-8");
                    if(temp[0].equals("mc_gross")){
                        ppr.setMc_gross(temp[1]);
                    }
                    if(temp[0].equals("protection_eligibility")){
                        ppr.setProtection_eligibility(temp[1]);
                    }
                    if(temp[0].equals("address_status")){
                        ppr.setAddress_status(temp[1]);
                    }
                     if(temp[0].equals("first_name")){
                        ppr.setFirst_name(temp[1]);
                    }
                      if(temp[0].equals("last_name")){
                        ppr.setLaste_name(temp[1]);
                    }
                    
                }
                in.close();
            }
        }catch(Exception ex){
            System.out.println(ex.getMessage());
            ppr=null;
        }
        return ppr;
    }
    
}
