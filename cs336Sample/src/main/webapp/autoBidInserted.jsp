<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Bid Placed!</title>
	</head>
	
	<body>
<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		double starting_bid = Double.valueOf(request.getParameter("autobid_start"));
		int aID = Integer.valueOf(request.getParameter("aID"));
		double maximum_bid = Double.valueOf(request.getParameter("autobid_maximum"));
		double increment = Double.valueOf(request.getParameter("autobid_increment"));
		
	

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO bid(email, aID, bidID, maximum_bid, current_bid, starting_bid, increment, is_autobid)"
				+ "VALUES (?,?,?,?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, session.getAttribute("user_email").toString());
		ps.setInt(2, aID);
		ps.setInt(3, (int)Math.floor(Math.random() * 100000));
		ps.setDouble(4, maximum_bid);
		ps.setDouble(5, starting_bid);
		ps.setDouble(6, starting_bid);
		ps.setDouble(7, increment);
		ps.setDouble(8, 1);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
</body>
</html>