
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />


<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%


	ArrayList examsList=new ArrayList();
	String degree=miscUtil.noNull(request.getParameter("course"));
    String sem=miscUtil.noNull(request.getParameter("sem"));
	String ay=miscUtil.noNull(request.getParameter("ay"));
	String reg=miscUtil.noNull(request.getParameter("reg"));
	String yoa=miscUtil.noNull(request.getParameter("yoa"));
	examsList=exdb.getExamsList(degree, sem,ay,reg,"supply",yoa);
	// System.out.println(examsList.size());
	 
	session.putValue("degree",degree);
	session.putValue("sem",sem);
	session.putValue("ay",ay);
	session.putValue("reg", reg);
	session.putValue("yoa", yoa);
	session.putValue("examslist", examsList);
%>

								<option value=""></option>
								
									<%
										for(int i=0;i<examsList.size();i++)
										{
											ExternalExam sub=(ExternalExam)examsList.get(i);
											
											%>
											<option value='<%=sub.getCode() %>'><%=sub.getDescription() %></option>
											<%
											
										}
									%>
									
