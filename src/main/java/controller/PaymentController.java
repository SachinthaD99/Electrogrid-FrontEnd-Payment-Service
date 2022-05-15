package controller;


import org.apache.tomcat.util.json.JSONParser;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.nodes.Document;
import java.util.ArrayList;

import com.google.gson.*;
import org.json.simple.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import model.*;

@Path("/payment")
public class PaymentController {

	Payment_Model payments =new Payment_Model();
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String add(String json_data)
	{
		JsonObject json_parser = new JsonParser().parse(json_data).getAsJsonObject();

		if(json_parser.get("account_number").getAsString()!=""&&json_parser.get("b_id").getAsString()!=""&&json_parser.get("b_amount").getAsString()!=""&&json_parser.get("c_name").getAsString()!=""&&json_parser.get("mobile").getAsString()!=""&&json_parser.get("email").getAsString()!=""&&json_parser.get("p_method").getAsString()!=""&&json_parser.get("card_number").getAsString()!=""&&json_parser.get("nic").getAsString()!=""&&json_parser.get("date").getAsString()!="") {

			payments.addPayment(json_parser.get("account_number").getAsString(),json_parser.get("b_id").getAsString(),Double.parseDouble(json_parser.get("b_amount").getAsString()),json_parser.get("c_name").getAsString(),json_parser.get("mobile").getAsString(),json_parser.get("email").getAsString(),json_parser.get("p_method").getAsString(),json_parser.get("card_number").getAsString(),json_parser.get("nic").getAsString(),json_parser.get("date").getAsString());
			
			JSONObject output = new JSONObject();
			output.put("success", payments.getRes());
			
			return output.toString();
			
		}else {
			
			JSONObject output = new JSONObject();
			output.put("success", "required");
			
			return output.toString();
			
		}
			
		
	}
	
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String edit(String json_data)
	{
		JsonObject json_parser = new JsonParser().parse(json_data).getAsJsonObject();

		if(json_parser.get("id").getAsString()!=""&&json_parser.get("account_number").getAsString()!=""&&json_parser.get("b_id").getAsString()!=""
				&&json_parser.get("b_amount").getAsString()!=""&&json_parser.get("c_name").getAsString()!=""&&json_parser.get("mobile").getAsString()!=""
				&&json_parser.get("email").getAsString()!=""&&json_parser.get("p_method").getAsString()!=""&&json_parser.get("card_number").getAsString()!=""
				&&json_parser.get("nic").getAsString()!=""&&json_parser.get("date").getAsString()!="") {
			payments.editPayment(Integer.parseInt(json_parser.get("id").getAsString()),json_parser.get("account_number").getAsString(),json_parser.get("b_id").getAsString(),Double.parseDouble(json_parser.get("b_amount").getAsString()),json_parser.get("c_name").getAsString(),json_parser.get("mobile").getAsString(),json_parser.get("email").getAsString(),json_parser.get("p_method").getAsString(),json_parser.get("card_number").getAsString(),json_parser.get("nic").getAsString(),json_parser.get("date").getAsString());
			
			JSONObject output = new JSONObject();
			output.put("success", payments.getRes());
	
			return output.toString();
			
		}else {
			
			JSONObject output = new JSONObject();
			output.put("success", "required");
			
			return output.toString();
			
		}
			
	}
	
	@DELETE
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String delete(String json_data)
	{
		JsonObject json_parser = new JsonParser().parse(json_data).getAsJsonObject();
		if(json_parser.get("id").getAsString()!="") {
			payments.deletePayment(Integer.parseInt(json_parser.get("id").getAsString()));
			
			JSONObject output = new JSONObject();
			output.put("success", payments.getRes());
			System.out.println("vhcvhgfhh");
			return output.toString();
			
		}else {
			
			JSONObject output = new JSONObject();
			output.put("success", "required");
			
			return output.toString();
			
		}
		
	}

	@GET
	@Produces(MediaType.TEXT_HTML)
	public String view(String json_data)
	{
		return payments.getPayment();
	}
	
	@POST
	@Path("/get")
	@Produces(MediaType.TEXT_HTML)
	public String viewOne(String app_text)
	{
		JsonObject app = new JsonParser().parse(app_text).getAsJsonObject();
		
		return payments.getOnePayment(Integer.parseInt(app.get("id").getAsString())).toString();
	}
	
}
