
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%@ page import = "dao.User" %>
<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
if(ur==null)
{
%>
<jsp:forward page="./index.jsp"></jsp:forward>
<%}
if(ur.getStatus().equals("admin"))
	header="./adminheader.jsp";
else if(ur.getStatus().equals("clerk"))
	header="./mainmenuheader.jsp";
else if(ur.getStatus().equals("ACE"))
	header="./aceheader.jsp";

%>

<jsp:include page='<%= header %>' flush="true" />
<%

String ftype="";
String fname="";
String desig="";
String address="";
String vtype=session.getValue("valtype").toString();
String ie="";
String tada="";
String valdesc="";
ftype=miscUtil.noNull(request.getParameter("ftype"));

if(vtype.equals("elabtheory"))
	valdesc="External Lab & Theory";
else if(vtype.equals("theory"))
	valdesc="Theory ";
else if(vtype.equals("ilabmcq"))
	valdesc="Internal Lab & MCQs correction ";
else if(vtype.equals("ilab"))
	valdesc="Internal Lab";
else if(vtype.equals("mcq"))
	valdesc="MCQs Correction";
else if(vtype.equals("scrutinizing"))
	valdesc="Scrutinizing";
else if(vtype.equals("thesis"))
	valdesc="Thesis";

if(vtype.charAt(0)=='i')
	ie="Internal";
else if(vtype.charAt(0)=='e')
	ie="External";

if(ftype.equals("external"))
{
	tada=miscUtil.noNull(request.getParameter("tada"));
	fname=miscUtil.noNull(request.getParameter("efname"));
	desig=miscUtil.noNull(request.getParameter("edesig"));
	address=miscUtil.noNull(request.getParameter("eaddress"));
}
else if(ftype.equals("internal"))
{
	fname=miscUtil.noNull(request.getParameter("fname"));
	desig=miscUtil.noNull(request.getParameter("desig"));
	address=miscUtil.noNull(request.getParameter("address"));
	fname=new FacultyDB().getFacultyName(fname);
}


session.putValue("fname", fname);
session.putValue("desig", desig);
session.putValue("address", address);
session.putValue("tada", tada);
session.putValue("ftype", ftype);
session.putValue("valdesc", valdesc);
ArrayList list=new ArrayList();
	int index=0;
%>


<html>
	<head>
		<title>SVCP--Examination Portal - Mid Examinations</title>
<script type="text/javascript">  
    var calc_image = './imgs/calc.gif';  
      
    var calc_start_num = false;  
    var calc_cur_oper = '';  
    var calc_acc = 0;  
    var calc_prev_oper = 0;  
    var calc_prev_entry = 0;  
      
    var calc_field;  
      
    function calc_num_value()  
    {  
        if (calc_field.value == '0.')  
            return calc_field.value;  
        else if (isNaN(calc_field.value))  
            return 0;  
        else  
            return parseFloat(calc_field.value);  
    }  
      
    function calc_perform_oper(oper, val1, val2)  
    {  
        switch(oper)  
        {  
        case '*':  
            return val1 * val2;  
        case '/':  
            return val1 / val2;  
        case '+':  
            return Math.round(  
                    val1 * 10000000000000 +  
                    val2 * 10000000000000) /  
                   10000000000000;  
        case '-':  
            return Math.round(  
                    val1 * 10000000000000 -  
                    val2 * 10000000000000) /  
                   10000000000000;  
        default:  
            return val2;  
        }  
    }  
      
    function calc_press(button)  
    {  
        switch (button)  
        {  
        case 'CE':  
            calc_start_num = true;  
            calc_field.value = "0";  
            return;  
      
        case 'C':  
            calc_acc = 0;  
            calc_prev_entry = 0;  
            calc_cur_oper = "";  
            calc_prev_oper = "";  
            calc_start_num = true;  
            calc_field.value = "0";  
            return;  
      
        case '+/-':  
            calc_field.value = calc_num_value() * -1;  
            return;  
      
        case ',':  
        case '.':  
            if (calc_start_num || isNaN(calc_field.value))  
            {  
                calc_field.value = "0.";  
                calc_start_num = false;  
            }  
            else  
            {  
                if (calc_field.value.indexOf(".") == -1)  
                    calc_field.value += ".";  
            }  
            return;  
      
        case '+':  
        case '-':  
        case '/':  
        case '*':  
            calc_prev_oper = button;  
      
            if (calc_start_num)  
            {  
                calc_cur_oper = button;  
                return;  
            }  
      
            // No break here.  
      
        case '=':  
            calc_start_num = true;  
      
            if (button == '=' && calc_cur_oper != '=')  
            {  
                calc_prev_entry = calc_num_value();  
            }  
      
            if (button == '=' && calc_cur_oper == '=')  
            {  
                calc_acc = calc_perform_oper(  
                    calc_prev_oper, calc_acc, calc_prev_entry)  
            }  
            else  
                calc_acc = calc_perform_oper(  
                    calc_cur_oper, calc_acc, calc_num_value());  
      
            calc_field.value = calc_acc;  
            calc_cur_oper = button;  
      
            return;  
        }  
      
        if (calc_start_num)  
        {  
            calc_field.value  = button;  
            calc_start_num = false;  
        }  
        else  
        {  
            if (calc_num_value() == "0")  
                calc_field.value = button;  
            else  
                calc_field.value += button;  
        }  
    }  
      
    function calc_setup(frm, inp)  
    {  
        if (!document.getElementById)  
            return;  
      
        document.write(  
            '<a href="javascript:void(0);" ' +  
            'onclick="calc_show_hide(\'' +  
            frm + '\', \'' + inp +  
            '\')"><img  style="border:none" ' +  
            'src="' + calc_image +  
            '"><' + '/a>');  
    }  
      
    function move_box(an, box)  
    {  
        var cleft = 0;  
        var ctop = 0;  
        var obj = an;  
      
        while (obj.offsetParent)  
        {  
            cleft += obj.offsetLeft;  
            ctop += obj.offsetTop;  
            obj = obj.offsetParent;  
        }  
      
        box.style.left = cleft + 'px';  
      
        ctop += an.offsetHeight + 2;  
      
        // Handle Internet Explorer body margins,  
        // which affect normal document, but not  
        // absolute-positioned stuff.  
        if (document.body.currentStyle &&  
            document.body.currentStyle['marginTop'])  
        {  
            ctop += parseInt(  
                document.body.currentStyle['marginTop']);  
        }  
      
        box.style.top = ctop + 'px';  
    }  
      
    function calc_show_hide(frm, inp)  
    {  
        var boxcalc = document.getElementById('attach_calc_div');  
        var to_obj = document.forms[frm].elements[inp];  
      
        if (boxcalc == null)  
            return;  
      
        if (to_obj != calc_field ||  
            boxcalc.style.display=='none')  
        {  
            // Show and move calculator.  
      
            boxcalc.style.position='absolute';  
            move_box(to_obj, boxcalc);  
            calc_field = to_obj;  
            boxcalc.style.display='block';  
        }  
        else  
            // Hide currently shown calculator.  
            boxcalc.style.display='none';  
        return false;  
    }  
      
    function calc_hide()  
    {  
        document.getElementById('attach_calc_div')  
            .style.display = 'none';  
    }  
      
    //--></script>  

	</head>
	<body>
		  <div id="centre">

					    
					    <CENTER>
					    	
							<FORM NAME = REGISTER METHOD = POST ACTION = "./remunerationBill.jsp" target="_blank">
							
							   <h3><b> Remuneration Calculation</b></h3>
							
							
							<%
							if(vtype.contains("lab")){
								list.add(index++,ie+" Lab");
							%>
							<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							  <TR>
							    <TD COLSPAN="2" ALIGN="center"><h6><b><%=ie %> Lab</b></h6></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Scripts:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="labscripts"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Rate:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="labrate"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Amount:</TD>
								<TD  WIDTH="10%" align="left" nowrap><input type=text name="labamount">
								<script type="text/javascript"><!--  
										calc_setup('REGISTER', 'labamount');  
								//--></script>
								
								</TD>
							</TR>
							</TABLE>
							
							<%}  if(vtype.contains("theory")){
								list.add(index++,"Paper Valuation Theory");
								%>
							
							<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							  <TR>
							    <TD COLSPAN="2" ALIGN="center"><h6><b>Theory</b></h6></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Scripts:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="theoryscripts"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Rate:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="theoryrate"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Amount:</TD>
								<TD  WIDTH="10%" align="left" nowrap><input type=text name="theoryamount">
								<script type="text/javascript"><!--  
										calc_setup('REGISTER', 'theoryamount');  
								//--></script>
								
								</TD>
							</TR>
							</TABLE>
							
							<%} if(vtype.contains("mcq")){ 
							list.add(index++,"MCQs Correction");
							%>
							<TABLE BORDER="1" CELLPADDING="2" CELLSPACING="2" WIDTH="290">
							  <TR>
							    <TD COLSPAN="2" ALIGN="center"><h6><b>MCQs</b></h6></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Scripts:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="mcqscripts"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right">Rate:</TD>
								<TD  WIDTH="10%" align="left"><input type=text name="mcqrate"></TD>
							</TR>
							<TR>
								<TD  WIDTH="20%" ALIGN="right" nowrap>Total Amount:</TD>
								<TD  WIDTH="10%" align="left" nowrap><input type=text name="mcqamount">
								
								<script type="text/javascript"><!--  
										calc_setup('REGISTER', 'mcqamount');  
								//--></script>
								
								</TD>
							</TR>
							</TABLE>
							<%}  
							session.putValue("valuations", list);
							%>
							
							<br>
						<center>								
							    <INPUT TYPE="SUBMIT" NAME="Next" VALUE="..Next-->"></INPUT>
						</center>		
							
							</FORM>
						
					    </CENTER>			  
  		  </div>
		<div id="pied"></div>
	</div>
	<br></br>
	<br></br>
	<br></br>
	
	
	
	          
    <div id="attach_calc_div" style=  
     "background:white;border:1px solid #2266AA;display:none">  
    <form name="attach_calc_form" action=""  
     style="margin-bottom:0px;margin-top:0px;padding:2px">  
      
    <table style="border:none;padding:0px;border-spacing:0px">  
      
    <tbody>  
      
    <tr>
    <td colspan=4><center>Instant Calculator</center></td> 
    <td align="center" style="background:#17202a ;"><a style="font-size:15px;color:#2266AA;"  
     href="javascript:void(0);" onmouseup="calc_hide()">Close</a></td>  
    </tr>  
      
    <tr>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn7"  
     type="button" value="7" onmouseup="calc_press(7)"></td>  
    <td style="background: #1b2631 ;"><input style="width:40px" name="cbtn8"  
     type="button" value="8" onmouseup="calc_press(8)"></td>  
    <td style="background: #1b2631 ;"><input style="width:40px" name="cbtn9"  
     type="button" value="9" onmouseup="calc_press(9)"></td>  
    <td style="background: #1b2631 ;"><input style="width:40px" name="cbtnp"  
     type="button" value="+" onmouseup="calc_press('+')"></td>  
    <td style="background: #1b2631 ;"><input style="width:40px" name="cbtnm"  
     type="button" value="-" onmouseup="calc_press('-')"></td>  
    </tr>  
      
    <tr>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn4"  
     type="button" value="4" onmouseup="calc_press(4)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn5"  
     type="button" value="5" onmouseup="calc_press(5)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn6"  
     type="button" value="6" onmouseup="calc_press(6)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtnm"  
     type="button" value="*" onmouseup="calc_press('*')"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtnd"  
     type="button" value="/" onmouseup="calc_press('/')"></td>  
    </tr>  
      
    <tr>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn1"  
     type="button" value="1" onmouseup="calc_press(1)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn2"  
     type="button" value="2" onmouseup="calc_press(2)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn3"  
     type="button" value="3" onmouseup="calc_press(3)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtnc"  
     type="button" value="C" onmouseup="calc_press('C')"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtne"  
     type="button" value="CE" onmouseup="calc_press('CE')"></td>  
    </tr>  
      
    <tr>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtn0"  
     type="button" value="0" onmouseup="calc_press(0)"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtnd"  
     type="button" value="." onmouseup="calc_press('.')"></td>  
    <td style="background:#1b2631 ;"><input style="width:40px" name="cbtnn"  
     type="button" value="+/-" onmouseup="calc_press('+/-')"></td>  
    <td style="background:#1b2631 ;" colspan=2><input style="width:84px" name="cbtnq"  
     type="Button" value="=" onmouseup="calc_press('=')"></td>  
    </tr>  
      
    </table>  
    </form>  
    </div>  
	</body>
</html>
