<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Donation</title>
        <link rel="shortcut icon" href="resources/assets/images/ico/favicon.ico">
    </head>
    <body>
    <h>${message}</h>
        <jsp:include page="/WEB-INF/jsp/styles/styles.jsp" />
        <!-- CREDIT CARD FORM STARTS HERE -->
        <!-- Stripe payment starts here -->
        <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
        <script type="text/javascript">
            Stripe.setPublishableKey('pk_test_FLxUxePgmE9sInSJEbfVpWBM');
        </script>
        <script>
        function makePayment(){
            var postid = $('#postid').val();
            var amount = $('#amount').val();
            var $form = $('#payment-form');

            Stripe.card.createToken($form, stripeResponseHandler);
            
        }
        $(function() {
            var $form = $('#payment-form');
            $form.submit(function(event) {
                // Disable the submit button to prevent repeated clicks:

                //$form.find('.submit').prop('disabled', true);
                // Request a token from Stripe:
                makePayment();

                // Prevent the form from being submitted:
                return false;
            });
        });
        function stripeResponseHandler(status, response) {
            debugger;
            // Grab the form:
            var $form = $('#payment-form');

            if (response.error) { // Problem!

                // Show the errors on the form:
                alert(response.error.message);
                $form.find('.payment-errors').text(response.error.message);
                $form.find('.submit').prop('disabled', false); // Re-enable submission

            } else { // Token was created!

                // Get the token ID:
                var token = response.id;

                // Insert the token ID into the form so it gets submitted to the server:
                $form.append($('<input type="hidden" name="stripeToken">').val(token));

                // Submit the form:
                $form.get(0).submit();
            }
        };
        </script>
        <!-- Stripe payment sends here -->
        <form action="${pageContext.request.contextPath}/charge.htm" class="form-horizontal" method="POST" id="payment-form" style = "margin-bottom :2%; padding:2%;">    
            <div class="col-xs-12 col-md-6" id="credit_card_view">
                <div class="panel panel-default credit-card-box" style="padding:8px; background-color: gray;" >
                    <div class="panel-heading display-table" >
                        <div class="row display-tr" >
                            <h3 class="panel-title display-td" >Payment Details</h3>
                            <div class="display-td" >                            
                                <img class="img-responsive pull-right" src="http://i76.imgup.net/accepted_c22e0.png">
                            </div>
                        </div>                    
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <span class="payment-errors"></span>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Card Number</label>  
                                <div class="col-sm-6">
                                <input placeholder="XXXX XXXX XXXX XXXX" class="form-control" required="" size="20" data-stripe="number"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Expiration (MM/YY)</label>  
                                <div class="col-sm-6">
                                <div class="form-control">
                                <input class="col-sm-2" placeholder="MM" required="" type="text" size="2" data-stripe="exp_month">
                                <span class="col-sm-1"> / </span>
                                <input class="col-sm-2" placeholder="YY" required="" type="text" size="2" data-stripe="exp_year">
                                </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">CVC</label>  
                                <div class="col-sm-6">
                                <input placeholder="XXX" class="form-control" required="" type="text" size="4" data-stripe="cvc"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="State">Enter your own amount</label>  
                                <div class="col-sm-2">
                                <input id="amount" name="amount" type="text" placeholder="amount" value="" class="form-control " required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="State">First name</label>  
                                <div class="col-sm-6">
                                <input id="fname" name="fname" type="text" placeholder="first name" class="form-control " required="" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="State">Last name</label>  
                                <div class="col-sm-6">
                                <input id="lname" name="lname" type="text" placeholder="last name" class="form-control" required="" value=""> 
                                </div>
                            </div>
                            <br>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="address1">Billing address</label>  
                                <div class="col-sm-6">
                                <input id="address1" name="address1" type="text" placeholder="" class="form-control" value="">
                                <span class="help-block">Street address, P.O. box, company name, c/o</span>  
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="Address2">Address Line2</label>  
                                <div class="col-sm-6">
                                <input id="Address2" name="Address2" type="text" placeholder="" class="form-control" >
                                <span class="help-block">Apartment, suite , unit, building, floor, etc.</span>  
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="city">City/Town</label>  
                                <div class="col-sm-6">
                                <input id="city" name="city" type="text" placeholder="city or town" class="form-control" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="State">State</label>  
                                <div class="col-sm-6">
                                <input id="State" name="State" type="text" placeholder="state" class="form-control" required="">
                                <span class="help-block">Enter Source state</span>  
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="zip">Zip/Postal code</label>  
                                <div class="col-sm-6">
                                <input id="zip" name="zip" type="text" placeholder="zip or postal code" class="form-control" required="" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="Country">Country</label>
                                <div class="col-sm-6">
                                    <select id="Country" name="Country" class="form-control">
                                        <option value="IR">IR Iran</option>
                                        <option value="USA">United States</option>
                                    </select>
                              </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="State">email</label>  
                                <div class="col-sm-6">
                                <input id="email" name="email" type="text" placeholder="email" class="form-control" required="" value=""> 
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-6 center-block">
                                <input type="submit" class="btn btn-primary submit" value="Submit Payment">
                                </div>
                            </div>
                            
                          </div>
                    </div>
                </div>     
            </div>
        </form>
        <!-- CREDIT CARD FORM ENDS HERE -->

    </body>
</html>