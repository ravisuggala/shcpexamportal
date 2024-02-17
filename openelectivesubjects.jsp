
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%
String degree=request.getParameter("degree");
String branch=request.getParameter("branch");
String reg=request.getParameter("reg");
HashMap subjectsList = new SubjectDB().getOpenElectiveSubjects(degree,branch,reg);
session.putValue("oesubjects", subjectsList);
Set<String> keySet = subjectsList.keySet();
Iterator it = keySet.iterator();

%>
                          <% 
							out.println("<option value='' selected></option>");
							
							while(it.hasNext())
							{
								Subject sub=(Subject)subjectsList.get(it.next());
							    String code=sub.getCode();
						        String name=sub.getSname();
							    out.println("<option value='"+code+"'>"+name+"</option>");
							    //System.out.println("<option value='"+code+"'>"+name+"</option>");
							}
							
							%>
							
							
