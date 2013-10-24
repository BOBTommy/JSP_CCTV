<%	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	StringBuffer sb = null;
	try{
		int id = 0; //0 - Search, 1 - init , 2 - insert , 3 - modify
		String command = request.getParameter("command");
		String query = ""; String addr = ""; String adminName = ""; String adminPhone = "";
		int num =0; int coverage = 0; int markerX = 0; int markerY = 0; int PK = 0;
		command = new String(command.getBytes("8859_1"),"UTF-8");
		if(command.compareToIgnoreCase("init") == 0){
			id = 1;
		}else if(command.compareToIgnoreCase("insert") == 0){
			id = 2;
		}else if(command.compareToIgnoreCase("modify") == 0){
			id = 3;
		}
		if(id == 0){
			query = request.getParameter("query");
			query = new String(query.getBytes("8859_1"), "UTF-8");
		}else if ( (id == 3) || (id == 2)){
			query = request.getParameter("num"); num = Integer.parseInt(new String(query.getBytes("8859_1"), "UTF-8"));
			query = request.getParameter("addr"); addr = new String(query.getBytes("8859_1"), "UTF-8");
			query = request.getParameter("markerX"); markerX = Integer.parseInt(new String(query.getBytes("8859_1"), "UTF-8"));
			query = request.getParameter("markerY"); markerY = Integer.parseInt(new String(query.getBytes("8859_1"), "UTF-8"));
			query = request.getParameter("adminName"); adminName = new String(query.getBytes("8859_1"), "UTF-8");
			query = request.getParameter("adminPhone"); adminPhone = new String(query.getBytes("8859_1"), "UTF-8");
			query = request.getParameter("coverage"); coverage = Integer.parseInt(new String(query.getBytes("8859_1"), "UTF-8"));
			query = request.getParameter("PK"); PK = Integer.parseInt(new String(query.getBytes("8859_1"), "UTF-8"));
		}
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cctv","root","5357");
		Statement stmt = conn.createStatement();
		ResultSet rs = null;
		if(id == 0){
			rs = stmt.executeQuery("SELECT * FROM cctv where addr like '%"+query+"%'");
		}else if(id == 1){
			rs = stmt.executeQuery("SELECT * FROM cctv");
		}
		JSONObject output = new JSONObject();
		if((id == 0 || id == 1) && !rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("num",-1);
			output.put("-1",obj);
			out.print(output);
			out.flush();
			conn.close();
			return;
		}
		if(id == 0){
			rs = stmt.executeQuery("SELECT * FROM cctv where addr like '%"+query+"%'");
		}else if(id == 1){
			rs = stmt.executeQuery("SELECT * FROM cctv");
		}else if(id == 3){
			int index = stmt.executeUpdate("UPDATE cctv set num='"+num+"', addr='"+addr+"',markerX='"+markerX+"',markerY='"+markerY+"',adminName='"+adminName+"',adminPhone='"+adminPhone+"',coverage='"+coverage+"' where PK="+PK);
			out.println("####LOG####");
			out.print("Result Code : " + index);
			out.print(" PK : " + PK);
			conn.close();
			return;
		}else if(id == 2){
			int index = stmt.executeUpdate("INSERT INTO cctv (num, addr, markerX, markerY, adminName, adminPhone, coverage)"
										+"VALUES("+num+",'"+addr+"',"+markerX+","+markerY+",'"+adminName+"','"+adminPhone+"',"+coverage+")" );
			out.println("####LOG####");
			out.print("Result Code : " + index);
			out.print(" PK : " + PK);
			conn.close();
			return;
		}
		while(rs.next()){
			JSONObject obj = new JSONObject();
			obj.put("num",rs.getInt("num"));
			obj.put("addr",rs.getString("addr"));
			obj.put("markerX",rs.getInt("markerX"));
			obj.put("markerY",rs.getInt("markerY"));
			obj.put("adminName",rs.getString("adminName"));
			obj.put("adminPhone",rs.getString("adminPhone"));
			obj.put("coverage",rs.getInt("coverage"));
			obj.put("PK",rs.getInt("PK"));
			output.put("\""+rs.getInt("num")+"\"",obj);
		}//end while
		rs.close();
		stmt.close();
		conn.close();
		out.print(output);
		out.flush();
	}catch(Exception e){
		;}
%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.JSONObject"%>