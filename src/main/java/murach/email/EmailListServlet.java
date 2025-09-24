package murach.email;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import murach.business.User;
import murach.data.UserDB;

@WebServlet("/emailList")
public class EmailListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Email List Application</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 40px; }");
            out.println("table { border-collapse: collapse; width: 100%; }");
            out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
            out.println("th { background-color: #f2f2f2; }");
            out.println("form { margin: 20px 0; }");
            out.println("input[type=text], input[type=email] { padding: 5px; margin: 5px; }");
            out.println("input[type=submit] { padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Email List Application - JPA Version</h1>");
            
            // Form to add new user
            out.println("<h2>Add New User</h2>");
            out.println("<form action='emailList' method='post'>");
            out.println("First Name: <input type='text' name='firstName' required><br>");
            out.println("Last Name: <input type='text' name='lastName' required><br>");
            out.println("Email: <input type='email' name='email' required><br>");
            out.println("<input type='submit' value='Add User'>");
            out.println("</form>");
            
            // Display all users
            out.println("<h2>Current Users</h2>");
            List<User> users = UserDB.selectUsers();
            
            if (users != null && !users.isEmpty()) {
                out.println("<table>");
                out.println("<tr><th>User ID</th><th>First Name</th><th>Last Name</th><th>Email</th></tr>");
                
                for (User user : users) {
                    out.println("<tr>");
                    out.println("<td>" + user.getUserId() + "</td>");
                    out.println("<td>" + user.getFirstName() + "</td>");
                    out.println("<td>" + user.getLastName() + "</td>");
                    out.println("<td>" + user.getEmail() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } else {
                out.println("<p>No users found in the database.</p>");
            }
            
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        
        if (firstName != null && lastName != null && email != null) {
            User user = new User(firstName, lastName, email);
            UserDB.insert(user);
        }
        
        // Redirect to GET method to display updated list
        response.sendRedirect("emailList");
    }
}