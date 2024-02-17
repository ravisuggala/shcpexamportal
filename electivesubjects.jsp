
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%

HashMap subjectsList = (HashMap)session.getAttribute("electives");
String selele=new String();
	selele=request.getParameter("selele");

	

 
//System.out.println(selele);
//System.out.println(subjectsList);
ArrayList slist=(ArrayList)subjectsList.get(selele);

%>
                          <% 
							out.println("<option value='' selected></option>");
							
							for(int i=0;i<slist.size();i++)
							{
								Subject sub=(Subject)slist.get(i);
								
						   String code=sub.getCode();
						   String name=sub.getSname();
							out.println("<option value='"+code+"'>"+name+"</option>");
								
								
							
							}
							
							%>
							
							
