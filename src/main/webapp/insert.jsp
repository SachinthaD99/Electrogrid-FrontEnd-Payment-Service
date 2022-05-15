<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">

<style>
.row{
margin-top: 2em;
}
.heading{
margin-top: 0.5em;
}



h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}


.button2 {
padding: 11px 115px;
background-color: #0d6efd;
margin-left: 37%;
margin-top: 5%;
color: white;
}

div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}



.button3 {
padding: 11px 104px;
background-color: #4caf50;
margin-left: 8%;
margin-top: 5%;
color: white;
}

a {
color: #ffffff;
text-decoration: underline;
}

</style>

<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <h1>Payment Portal</h1>
	                        <form id="payment">
	                            <div>
	                                <label>Account Number</label>
	                                <div>
	                                    <input type="text" id="account_number" class="form-control" name="account_number">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill ID</label>
	                                <div>
	                                    <input type="text" id="b_id" class="form-control" name="b_id">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill Amount</label>
	                                <div>
	                                    <input type="number" id="b_amount" class="form-control" name="b_amount">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Customer Name</label>
	                                <div>
	                                    <input type="text" id="c_name" class="form-control" name="c_name">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Mobile Number</label>
	                                <div>
	                                    <input type="text" id="mobile" class="form-control" name="mobile">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>E-mail</label>
	                                <div>
	                                    <input type="email" id="email" class="form-control" name="email">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Payment Method</label>
	                                <div>
	                                    <select name="p_method" class="form-control" id="p_method">
	                                		<option value="">Select</option>
	                                		<option value="Master">Master</option>
	                                		<option value="Visa">Visa</option>
	                                	</select>
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Card Number</label>
	                                <div>
	                                    <input type="text" id="card_number" class="form-control" name="card_number">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>NIC</label>
	                                <div>
	                                    <input type="text" id="nic" class="form-control" name="nic">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Date</label>
	                                <div>
	                                    <input type="date" id="date" class="form-control" name="date">
	                                </div>
	                            </div>
	                            
	                            <div>
				                        <button class="button3" type="submit" class="btn btn-success">
										Submit
										</button >
										<button class="button2" >
										<a href="edit_n_delete.jsp" >
										Payment List
										</a>
										</button>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#payment").validate({
        rules: {
        	account_number: "required",
        	b_id: "required",
        	b_amount: "required",
        	c_name: "required",
        	mobile: "required",
        	email: {
                email: true,
                required: true
            },
            p_method: "required",
            card_number: "required",
            nic: "required",
            date: "required"
        },
        messages: {
        	account_number: "Account Number Required!",
        	b_id: "Bill ID Required!",
            b_amount: "Bill Amount Required!",
            c_name: "Customer Name Required!",
            mobile: "Mobile Number Required!",
        	email: {
                email: "format",
                required: " Email required"
            },
            p_method: "Payment Method Required!",
            card_number: "Card Number Required!",
            nic: "NIC Required!",
            date: "Date Required!"
        },
        submitHandler: function () {
        	var fromData = JSON.stringify({
                "account_number" : $('#account_number').val(),
                "b_id" : $('#b_id').val(),
                "b_amount" : $('#b_amount').val(),
                "c_name" : $('#c_name').val(),
                "mobile" : $('#mobile').val(),
                "email" : $('#email').val(),
                "p_method" : $('#p_method').val(),
                "card_number" : $('#card_number').val(),
                "nic" : $('#nic').val(),
                "date" : $('#date').val()
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'rest_api/payment',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="Done"){
                		alert("Added Successfull!");
                		top.location.href="edit_n_delete.jsp";//rederecting
                        $("#payment")[0].reset();
					}else{
						alert("Unsuccessfull!");
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#payment").submit(function(e) {
        e.preventDefault();
    });

});

</script>