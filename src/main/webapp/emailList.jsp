<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="murach.business.User" %>
<%@page import="murach.data.UserDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Email List - JPA Version</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { margin: 20px 0; }
        input[type=text], input[type=email] { padding: 5px; margin: 5px; width: 200px; }
        input[type=submit] { padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .error { color: red; }
        .success { color: green; }
    </style>
</head>
<body>
    <h1>Email List Application - JPA Version</h1>
    
    <%
        String action = request.getParameter("action");
        String message = "";
        
        if ("add".equals(action)) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            
            if (firstName != null && lastName != null && email != null && 
                !firstName.trim().isEmpty() && !lastName.trim().isEmpty() && !email.trim().isEmpty()) {
                try {
                    User user = new User(firstName.trim(), lastName.trim(), email.trim());
                    UserDB.insert(user);
                    message = "<p class='success'>User added successfully!</p>";
                } catch (Exception e) {
                    message = "<p class='error'>Error adding user: " + e.getMessage() + "</p>";
                }
            } else {
                message = "<p class='error'>Please fill in all fields.</p>";
            }
        }
    %>
    
    <%= message %>
    
    <h2>Add New User</h2>
    <form action="emailList.jsp" method="post">
        <input type="hidden" name="action" value="add">
        <table>
            <tr>
                <td>First Name:</td>
                <td><input type="text" name="firstName" required></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type="text" name="lastName" required></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Add User">
                </td>
            </tr>
        </table>
    </form>
    
    <h2>Current Users</h2>
    <%
        try {
            List<User> users = UserDB.selectUsers();
            
            if (users != null && !users.isEmpty()) {
    %>
                <table>
                    <tr>
                        <th>User ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                    </tr>
    <%
                for (User user : users) {
    %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getEmail() %></td>
                    </tr>
    <%
                }
    %>
                </table>
    <%
            } else {
    %>
                <p>No users found in the database.</p>
    <%
            }
        } catch (Exception e) {
    %>
            <p class="error">Error retrieving users: <%= e.getMessage() %></p>
    <%
        }
    %>
    
    <br>
    <p><a href="sqlGateway">Go to SQL Gateway</a></p>
</body>
</html>