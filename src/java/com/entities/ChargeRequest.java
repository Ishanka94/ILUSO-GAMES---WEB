package com.entities;

public class ChargeRequest {

    public enum Currency {
        EUR, USD;
    }
    private String description;
    private int amount;
    private Currency currency;
    private String stripeEmail;
    private String stripeToken;

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }
    
    public void setAmount(int amount) {
        this.amount = amount;
    }
    
    public void setStripeTocken(String stripeTocken) {
        this.stripeToken = stripeTocken;
    }
    
    public void setStripeEmail(String stripeEmail) {
        this.stripeEmail = stripeEmail;
    }
    
    public int getAmount() {
        return amount;
    }

    public Currency getCurrency() {
        return currency;
    }

    public String getDescription() {
        return description;
    }

    public String getStripeToken() {
        return stripeToken;
    }
    
    public String getStripeEmail() {
        return stripeEmail;
    }
}
