
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%


	String degree=miscUtil.noNull(request.getParameter("course"));
	String sem=miscUtil.noNull(request.getParameter("sem"));
	String ay=miscUtil.noNull(request.getParameter("ay"));
	String reg=miscUtil.noNull(request.getParameter("reg"));
	//String yoa=miscUtil.noNull(request.getParameter("yoa"));
	String type=miscUtil.noNull(request.getParameter("type"));
	String period=miscUtil.noNull(request.getParameter("period"));
	//System.out.println(degree+" "+sem+" "+ay);
	session.putValue("type", type);
	ArrayList examsList=exdb.getSemesterExamsList(degree, sem,ay,reg,type,period);
	

 
//System.out.println(selele);
//System.out.println(subjectsList);


%>
                          <% 
							out.println("<option value='' selected></option>");
							
                          for(int i=0;i<examsList.size();i++)
							{
								ExternalExam sub=(ExternalExam)examsList.get(i);
								
						   String code=sub.getCode();
						   String name=sub.getDescription();
							out.println("<option value='"+code+"'>"+name+"</option>");
								
								
							
							}
							
							%>
							
							
