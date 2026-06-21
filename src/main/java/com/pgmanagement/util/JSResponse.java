package com.pgmanagement.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;

public class JSResponse {

    /**
     * Shows a standard SweetAlert2 alert and redirects to a page or goes back in history.
     *
     * @param response    The HttpServletResponse object.
     * @param title       Title of the alert.
     * @param message     Message content.
     * @param icon        Icon type ("success", "error", "warning", "info", "question").
     * @param redirectUrl Target redirect URL. If null or empty, goes back to the previous page.
     * @throws IOException If a writer error occurs.
     */
    public static void showSweetAlert(HttpServletResponse response, String title, String message, String icon, String redirectUrl) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>" + title + "</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("<style>");
        out.println("body { font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, sans-serif; background-color: #f8fafc; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script type='text/javascript'>");
        out.println("document.addEventListener('DOMContentLoaded', function() {");
        out.println("  Swal.fire({");
        out.println("    title: '" + escapeJS(title) + "',");
        out.println("    text: '" + escapeJS(message) + "',");
        out.println("    icon: '" + icon + "',");
        out.println("    confirmButtonColor: '#4f46e5',");
        out.println("    confirmButtonText: 'OK'");
        out.println("  }).then((result) => {");
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            out.println("    window.location.href = '" + escapeJS(redirectUrl) + "';");
        } else {
            out.println("    window.history.back();");
        }
        out.println("  });");
        out.println("});");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

    /**
     * Shows a SweetAlert2 confirmation dialog with two buttons and paths.
     */
    public static void showSweetAlertConfirm(HttpServletResponse response, String title, String message, String icon, String confirmUrl, String cancelUrl, String confirmText, String cancelText) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>" + title + "</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("<style>");
        out.println("body { font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, sans-serif; background-color: #f8fafc; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script type='text/javascript'>");
        out.println("document.addEventListener('DOMContentLoaded', function() {");
        out.println("  Swal.fire({");
        out.println("    title: '" + escapeJS(title) + "',");
        out.println("    text: '" + escapeJS(message) + "',");
        out.println("    icon: '" + icon + "',");
        out.println("    showCancelButton: true,");
        out.println("    confirmButtonColor: '#4f46e5',");
        out.println("    cancelButtonColor: '#64748b',");
        out.println("    confirmButtonText: '" + escapeJS(confirmText) + "',");
        out.println("    cancelButtonText: '" + escapeJS(cancelText) + "'");
        out.println("  }).then((result) => {");
        out.println("    if (result.isConfirmed) {");
        out.println("      window.location.href = '" + escapeJS(confirmUrl) + "';");
        out.println("    } else {");
        out.println("      window.location.href = '" + escapeJS(cancelUrl) + "';");
        out.println("    }");
        out.println("  });");
        out.println("});");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

    /**
     * Shows a SweetAlert2 alert with custom HTML content (useful for registration URLs).
     */
    public static void showSweetAlertHtml(HttpServletResponse response, String title, String htmlContent, String icon) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>" + title + "</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("<style>");
        out.println("body { font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, sans-serif; background-color: #f8fafc; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }");
        out.println("a { color: #4f46e5; font-weight: 600; text-decoration: none; }");
        out.println("a:hover { text-decoration: underline; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script type='text/javascript'>");
        out.println("document.addEventListener('DOMContentLoaded', function() {");
        out.println("  Swal.fire({");
        out.println("    title: '" + escapeJS(title) + "',");
        out.println("    html: '" + escapeJS(htmlContent) + "',");
        out.println("    icon: '" + icon + "',");
        out.println("    confirmButtonColor: '#4f46e5',");
        out.println("    confirmButtonText: 'Great!'");
        out.println("  });");
        out.println("});");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

    private static String escapeJS(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("'", "\\'")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r");
    }
}
