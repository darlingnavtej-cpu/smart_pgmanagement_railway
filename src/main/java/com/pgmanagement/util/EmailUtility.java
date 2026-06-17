package com.pgmanagement.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtility {

	public static void sendEmail(String toEmail, String subject, String body) {

		// 1. If Brevo API Key is present, use HTTP API (port 443, never blocked)
		final String brevoApiKey = System.getenv("BREVO_API_KEY");
		if (brevoApiKey != null && !brevoApiKey.trim().isEmpty()) {
			sendEmailViaBrevo(brevoApiKey, toEmail, subject, body);
			return;
		}

		// 2. Fallback to standard SMTP with short timeouts (fail fast instead of hanging thread)
		final String envEmail = System.getenv("SMTP_EMAIL");
		final String envPassword = System.getenv("SMTP_PASSWORD");

		final String fromEmail = (envEmail != null && !envEmail.trim().isEmpty()) ? envEmail : "smartpgmanage@gmail.com";
		final String appPassword = (envPassword != null && !envPassword.trim().isEmpty()) ? envPassword : "tjwfbjowdcskqdqu";

		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
		properties.put("mail.smtp.connectiontimeout", "5000"); // 5 seconds connection timeout
		properties.put("mail.smtp.timeout", "5000"); // 5 seconds read timeout

		Session session = Session.getInstance(properties,
				new Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(fromEmail, appPassword);
					}
				});
		session.setDebug(true);

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromEmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject(subject);
			message.setText(body);
			Transport.send(message);
			System.out.println("Email Sent Successfully via SMTP!");
		}
		catch (Exception e) {
			System.err.println("SMTP Email Sending Failed (Railway free tier blocks outgoing SMTP ports 587/465 by default):");
			e.printStackTrace();
		}
	}

	private static void sendEmailViaBrevo(String apiKey, String toEmail, String subject, String body) {
		try {
			System.out.println("Attempting to send email via Brevo API...");
			java.net.URL url = new java.net.URL("https://api.brevo.com/v3/smtp/email");
			java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("api-key", apiKey);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true);
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(5000);

			// Escape JSON payload simple logic
			String escapedBody = body.replace("\\", "\\\\")
			                         .replace("\"", "\\\"")
			                         .replace("\n", "\\n")
			                         .replace("\r", "");
			
			String jsonPayload = "{"
				+ "\"sender\":{\"name\":\"Smart PG Management\",\"email\":\"smartpgmanage@gmail.com\"},"
				+ "\"to\":[{\"email\":\"" + toEmail + "\"}],"
				+ "\"subject\":\"" + subject + "\","
				+ "\"textContent\":\"" + escapedBody + "\""
				+ "}";

			try (java.io.OutputStream os = conn.getOutputStream()) {
				byte[] input = jsonPayload.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			int code = conn.getResponseCode();
			if (code >= 200 && code < 300) {
				System.out.println("Email Sent successfully via Brevo API!");
			} else {
				System.err.println("Failed to send email via Brevo API. Response code: " + code);
				try (java.io.BufferedReader br = new java.io.BufferedReader(
						new java.io.InputStreamReader(conn.getErrorStream(), "utf-8"))) {
					StringBuilder response = new StringBuilder();
					String responseLine;
					while ((responseLine = br.readLine()) != null) {
						response.append(responseLine.trim());
					}
					System.err.println("Brevo Error Response: " + response.toString());
				}
			}
		} catch (Exception e) {
			System.err.println("Error sending email via Brevo API: " + e.getMessage());
			e.printStackTrace();
		}
	}
}