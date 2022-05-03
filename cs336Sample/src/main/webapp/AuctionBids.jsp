<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bid History for Auction <%= request.getParameter("aID") %></title>
</head>
<body>
<h1>Bid History for Auction <%= request.getParameter("aID") %></h1>
<table>
		<tr>    
			<td>Bidder Email</td>
			<td>Bidder's Max Bid</td>
		</tr>
<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			int aID = Integer.parseInt(request.getParameter("aID"));

			
			ArrayList<Item> item_list = new ArrayList<Item>();

			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM bid WHERE aID=" + aID;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
			
				String email = result.getString("email");
				int bidID = result.getInt("bidID");
				int maxBid = result.getInt("max_bid");
				
				%>
				
				<tr>
					<td><%= email %></td>
					<td><%= maxBid %></td>
				</tr>
				
				<% 
				
				
			}
		%>
			
			<% 
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>