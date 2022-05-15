<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}


h2{
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}




input[type=text], select {
width: 100%;
padding: 12px 20px;
margin: 8px 0;
display: inline-block;
border: 1px solid #ccc;
border-radius: 4px;
box-sizing: border-box;
}



input[type=submit] {
width: 100%;
background-color: #4CAF50;
color: white;
padding: 14px 20px;
margin: 8px 0;
border: none;
border-radius: 4px;
cursor: pointer;
}



input[type=submit]:hover {
background-color: #45a049;
}



div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}


</style>

<head>
	<meta charset="UTF-8">
	<title>title</title>
	
    
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>
	                    <h1>Payment List</h1>
	                    <div>
	                        <div id="paymentDiv">
	                    	
	            			</div>
	                    </div>
	                    
	                   
<div id="hideDiv" style="display: none">
	<h2>Payment List</h2>
    <form id="payment">
    <input type="hidden" id="edit_id" name="edit_id">
          <div>
              <label>Account Number</label>
              <div>
                  <input type="text" id="account_number" class="form-control" name="account_number">
              </div>
          </div>
          
          <div>
              <label>Bill ID</label>
              <div>
                  <input type="number" id="b_id" class="form-control" name="b_id">
              </div>
          </div>
          
          <div>
              <label>Bill Amount</label>
              <div>
                  <input type="text" id="b_amount" class="form-control" name="b_amount">
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
              <input type="submit" value="Edit">
          </div>
  	</form>
</div> 
	                    
</div>
	
</body>
</html>

<script>

    function deletes(id) {
    	
    	if (confirm("Do you want to delete ?") == true) {
        	$.ajax({
                type: "DELETE",
                url: "rest_api/payment",
                data: JSON.stringify({ 'id' : id}),
                dataType: "json",
    			contentType : 'application/json',
                success: function(data){
                	if(data['success']=="Done"){
                		alert("Delete Successfull!");
    					reload();
    				}else if(data['success']=="0"){
    					alert("Delete Unsuccessful!");
    				}
                },
                failure: function(errMsg) {
                    alert('Error');
                }
            });
    	}
    }

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
            		"id" : $('#edit_id').val(),
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
                    type: "PUT",
                    url: 'rest_api/payment',
                    dataType : 'json',
    				contentType : 'application/json',
    				data: fromData,
                    success: function(data){
                    	if(data['success']=="Done"){
                    		alert("Edit Successfull!");
                        	document.getElementById("hideDiv").style.display = "none";
                            $("#payment")[0].reset();
    						reload();
    					}else{
    						alert("Unsuccessful!");
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

    function reload(){
    	$.ajax({
            type: "GET",
            url: "rest_api/payment",
            success: function(data){
            	$("#paymentDiv").html(data);
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });
    }

    reload();
    
    function edit(id) {
    	document.getElementById("hideDiv").style.display = "block";
    	$.ajax({
            type: "POST",
            url: "rest_api/payment/get",
            data: JSON.stringify({ 'id' : id}),
            dataType: "json",
			contentType : 'application/json',
            success: function(data){
            	console.log(data),
                $('#edit_id').val(data['id']),
                $('#account_number').val(data['account_number']),
                $('#b_id').val(data['b_id']),
                $('#b_amount').val(data['b_amount']),
                $('#c_name').val(data['c_name']),
                $('#mobile').val(data['mobile']),
                $('#email').val(data['email']),
                $('#p_method').val(data['p_method']),
                $('#card_number').val(data['card_number']),
                $('#nic').val(data['nic']),
                $('#date').val(data['date'])
            },
            failure: function(errMsg) {
                alert('Error');
            }
        });

        
    }
    
    
</script>