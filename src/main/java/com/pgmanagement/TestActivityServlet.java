package com.pgmanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/test-activity")
public class TestActivityServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)

			throws ServletException, IOException {

		ActivityUtility.addActivity(

				"🟢 Admin logged into Smart PG System");

		resp.getWriter().println(

				"Activity Added Successfully!");

	}

}