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

		final String fromEmail = "smartpgmanage@gmail.com";

		final String appPassword = "tjwfbjowdcskqdqu";

		Properties properties = new Properties();

		properties.put("mail.smtp.host", "smtp.gmail.com");

		properties.put("mail.smtp.port", "587");

		properties.put("mail.smtp.auth", "true");

		properties.put("mail.smtp.starttls.enable", "true");

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

			message.setRecipients(Message.RecipientType.TO,

					InternetAddress.parse(toEmail));

			message.setSubject(subject);

			message.setText(body);

			Transport.send(message);
			

			System.out.println("Email Sent Successfully!");

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}