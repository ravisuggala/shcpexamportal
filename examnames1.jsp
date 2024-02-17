
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "exdb" scope="session" class="dao.ExternalExamDB" />

<%


	String degree=miscUtil.noNull(request.getParameter("degree"));
	String sem=miscUtil.noNull(request.getParameter("sem"));
	String ay=miscUtil.noNull(request.getParameter("ay"));
	String reg=miscUtil.noNull(request.getParameter("reg"));
	String yoa=miscUtil.noNull(request.getParameter("yoa"));
	String type=miscUtil.noNull(request.getParameter("type"));
	//System.out.println(degree+" "+sem+" "+ay);
	ArrayList examsList=exdb.getExamsList(degree, sem,ay,reg,type,yoa);
	

 
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
							
							
