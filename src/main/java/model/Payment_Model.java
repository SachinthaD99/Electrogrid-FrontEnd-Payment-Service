package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import db_connection.DB;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class Payment_Model {

	private String res;
	
	public String getRes() {
		return res;
	}

	public void setRes(String res) {
		this.res = res;
	}

	public String getPayment() {
		PreparedStatement ps;
		String data="";
		
		try {
			
			Connection conn = DB.getConn();
			ps = conn.prepareStatement("SELECT * FROM payment");
			
			ResultSet res_Set = ps.executeQuery();
			
			data = "<table>"
		            +"<tr>"
		            +"<th style='border-style: dotted;'>ID</th>"
	                +"<th style='border-style: dotted;'>Account Number</th>"
	                +"<th style='border-style: dotted;'>Bill ID</th>"
	                +"<th style='border-style: dotted;'>Bill Payment Amount</th>"
	                +"<th style='border-style: dotted;'>Customer Name</th>"
	                +"<th style='border-style: dotted;'>Mobile Number</th>"
	                +"<th style='border-style: dotted;'>Email</th>"
	                +"<th style='border-style: dotted;'>Payment Method</th>"
	                +"<th style='border-style: dotted;'>Card Number</th>"
	                +"<th style='border-style: dotted;'>NIC</th>"
	                +"<th style='border-style: dotted;'>Date</th>"
	                +"<th style='border-style: dotted;'>Edit/Delete</th>"
	                +"</tr>";
			
			while (res_Set.next()) {
				
				String button = "<button onclick='edit("+res_Set.getString(1)+")'>Edit</button><button onclick='deletes("+res_Set.getString(1)+")'>Delete</button>";
				
				data = data+"<tr><td style='border-style: dotted;'>"+res_Set.getString(1)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(2)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(3)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(4)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(5)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(6)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(7)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(8)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(9)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(10)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(11)+"</td>"
						+ "<td style='border-style: dotted;'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			ps.close();
			conn.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return data+"</table>";
	}
	
	public void addPayment(String account_number,String b_id,double b_amount,String c_name,String mobile,String email,String p_method,String card_number,String nic,String date) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("insert into payment (account_number,b_id,b_amount,c_name,mobile,email,p_method,card_number,nic,date) values (?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, account_number);
			ps.setString(2, b_id);
			ps.setDouble(3, b_amount);
			ps.setString(4, c_name);
			ps.setString(5, mobile);
			ps.setString(6, email);
			ps.setString(7, p_method);
			ps.setString(8, card_number);
			ps.setString(9, nic);
			ps.setString(10, date);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void editPayment(int id,String account_number,String b_id,double b_amount,String c_name,String mobile,String email,String p_method,String card_number,String nic,String date) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
				ps = conn.prepareStatement("UPDATE payment SET account_number=?,b_id=?,b_amount=?,c_name=?,mobile=?,email=?,p_method=?,card_number=?,nic=?,date=? where id=?");
				ps.setString(1, account_number);
				ps.setString(2, b_id);
				ps.setDouble(3, b_amount);
				ps.setString(4, c_name);
				ps.setString(5, mobile);
				ps.setString(6, email);
				ps.setString(7, p_method);
				ps.setString(8, card_number);
				ps.setString(9, nic);
				ps.setString(10, date);
				ps.setInt(11,id);
				ps.execute();
				ps.close();
				conn.close();
				setRes("Done");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void deletePayment(int id) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("DELETE FROM payment WHERE id=?");
			ps.setInt(1, id);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject getOnePayment(int id){
			
			PreparedStatement preparedStatement;
			JSONObject json = new JSONObject();
			
			try {
				Connection conn = DB.getConn();
				
				preparedStatement = conn.prepareStatement("SELECT * FROM payment where id=?");
				preparedStatement.setInt(1, id);
				ResultSet rs = preparedStatement.executeQuery();
	
				while(rs.next())
				{
					json.put("id", rs.getInt(1));
					json.put("account_number", rs.getString(2));
					json.put("b_id", rs.getString(3));
					json.put("b_amount", rs.getDouble(4));
					json.put("c_name", rs.getString(5));
					json.put("mobile", rs.getString(6));
					json.put("email", rs.getString(7));
					json.put("p_method", rs.getString(8));
					json.put("card_number", rs.getString(9));
					json.put("nic", rs.getString(10));
					json.put("date", rs.getString(11));
				}
				
			}catch (ClassNotFoundException | SQLException  e) {
				setRes("Error");
			}
			return json;
		}
	
}
