<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String itemName = request.getParameter("item_name");
		String itemType = request.getParameter("item_type");
		String closing_time = request.getParameter("closing_time");
		// getDate
		LocalDate closing_date = LocalDate.parse(request.getParameter("closing_date"));
		java.sql.Date c_date = java.sql.Date.valueOf(closing_date);
		
		double initial_price = Double.valueOf(request.getParameter("initial_price"));
		double increment = Double.valueOf(request.getParameter("increment"));
		double reserve_price = Double.valueOf(request.getParameter("min_price"));
		String user_email = session.getAttribute("user_email").toString();
		String str = "SELECT MAX(aID) as max FROM auction_posts";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		result.first();
		int aID = result.getInt("max") + 1;
		//Make an insert statement for the auction_posts table:
		String insert = "INSERT INTO auction_posts(aID,close_time,close_date,increment,initial_price,current_price,seller_email)"
				+ "VALUES (?,?,?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, aID);
		ps.setString(2, closing_time);
		ps.setDate(3, c_date);
		ps.setDouble(4,increment);
		ps.setDouble(5,initial_price);
		ps.setDouble(6,initial_price);
		ps.setString(7,user_email);
		
		ps.executeUpdate();

		
		//Make an insert statement for the Sells table:
		/* insert = "INSERT INTO beers(name)"
				+ "VALUES (?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself		
		ps.setString(1, newBeer);
		ps.executeUpdate();

		
		//Make an insert statement for the Sells table:
		insert = "INSERT INTO sells(bar, beer, price)"
				+ "VALUES (?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newBar);
		ps.setString(2, newBeer);
		ps.setFloat(3, price);
		//Run the query against the DB
		ps.executeUpdate();
		//Run the query against the DB
		*/
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
</body>
</html>