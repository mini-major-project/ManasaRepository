<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h2>
		Vaccination Information of
		<%
		out.println(request.getParameter("childName"));
	%>:
	</h2>
	<%
	ArrayList<String> childNames =  (ArrayList<String>) session.getAttribute("childNames");
	ArrayList<Integer> childIds = (ArrayList<Integer>)  session.getAttribute("childIds");
		try {
			java.sql.Connection con;
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/poshanabhiyaan?autoReconnect=true&useSSL=false", "root", "root");
			String childName = request.getParameter("childName");
			System.out.println("childname curr: "+childName);
			System.out.println("childnames ALL curr: "+childNames);
			System.out.println("childids all curr: "+childIds);
			
			int childId = 0;
			for (int i = 0; i < childNames.size(); i++) {
				String name = childNames.get(i);
				if (name.equals(childName)) {
					childId = childIds.get(i);
				}
			}

			ArrayList<String> dates = new ArrayList<>();
			ArrayList<String> vaccinations = new ArrayList<>();

			PreparedStatement pstmt = con.prepareStatement("select * from user where userId=?");
			pstmt.setInt(1, childId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				dates.add(rs.getString("day0"));
				dates.add(rs.getString("day42"));
				dates.add(rs.getString("day71"));
				dates.add(rs.getString("day99"));
				dates.add(rs.getString("day472"));
				dates.add(rs.getString("day1780"));
				dates.add(rs.getString("day3560"));
				dates.add(rs.getString("day4300"));
			}
System.out.println(dates);
			PreparedStatement pstmt2 = con.prepareStatement("select * from childvaccinations;");
			ResultSet rs2 = pstmt2.executeQuery();
			 do{
				vaccinations.add(rs2.getString("day0"));
				vaccinations.add(rs2.getString("day42"));
				vaccinations.add(rs2.getString("day71"));
				vaccinations.add(rs2.getString("day99"));
				vaccinations.add(rs2.getString("day472"));
				vaccinations.add(rs2.getString("day1780"));
				vaccinations.add(rs2.getString("day3560"));
				vaccinations.add(rs2.getString("day4300"));
			}while (rs2.next());
			 System.out.println(vaccinations);
			 
			for(int i=0;i<dates.size();i++){
				%>
				Date: <%dates.get(i); %>
				Vaccinations: <%vaccinations.get(i); %>
				<%
			}
		} catch (SQLException e) {
			out.println("SQLException caught: " + e.getMessage());
		}
	%>
</body>
</html>