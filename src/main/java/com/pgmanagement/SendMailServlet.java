package com.pgmanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.pgmanagement.util.EmailUtility;
import com.pgmanagement.util.JSResponse;

@WebServlet("/send-mail")
public class SendMailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Protect resource: Verify admin session
        if (req.getSession().getAttribute("adminUsername") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String tenantIdStr = req.getParameter("id");
        String tenantName = req.getParameter("name");
        String tenantEmail = req.getParameter("email");
        String subject = req.getParameter("subject");
        String month = req.getParameter("emailMonth");
        String dateTime = req.getParameter("dateTime");
        String content = req.getParameter("content");

        if (tenantEmail == null || tenantEmail.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            content == null || content.trim().isEmpty()) {
            JSResponse.showSweetAlert(resp, "Validation Error", "All fields are required!", "warning", null);
            return;
        }

        // Format date and time output
        String formattedDateTime = dateTime != null ? dateTime.replace("T", " ") : "";

        // Construct standard professional email body
        String emailBody = "Dear " + tenantName + ",\n\n"
                + "This is a direct notification from your PG Management regarding " + month + ".\n\n"
                + "Notification Details:\n"
                + "--------------------------------------------------\n"
                + "Date/Time: " + formattedDateTime + "\n"
                + "Month Context: " + month + "\n"
                + "--------------------------------------------------\n\n"
                + "Message:\n" + content + "\n\n"
                + "Please contact PG Management if you have any questions.\n\n"
                + "Best Regards,\n"
                + "Smart PG Management System";

        try {
            System.out.println("Triggering direct email to tenant: " + tenantName + " (" + tenantEmail + ")");
            EmailUtility.sendEmail(tenantEmail, subject, emailBody);
            JSResponse.showSweetAlert(resp, "Email Sent", "Message successfully sent to " + tenantName + " (" + tenantEmail + ")", "success", "fetch-tenants");
        } catch (Exception e) {
            e.printStackTrace();
            JSResponse.showSweetAlert(resp, "System Error", "Failed to send email: " + e.getMessage(), "error", null);
        }
    }
}
