function toggle(source,destination) {
	  checkboxes = document.getElementsByName(destination);
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}


function deSelectAll(source,destination) {
	checkboxes = document.getElementsByName(source);
	allcheckbox = document.getElementById(destination);

	for(var i=0, n=checkboxes.length;i<n;i++) {

		if(checkboxes[i].checked==false)
			{
				allcheckbox.checked=false;
				return;
			}
	}
	allcheckbox.checked=true;
	}

function move(tbFrom, tbTo) 
{
 var arrFrom = new Array(); var arrTo = new Array(); 
 var arrLU = new Array();
 var i;
 for (i = 0; i < tbTo.options.length; i++) 
 {
  arrLU[tbTo.options[i].text] = tbTo.options[i].value;
  arrTo[i] = tbTo.options[i].text;
 }
 var fLength = 0;
 var tLength = arrTo.length;
 for(i = 0; i < tbFrom.options.length; i++) 
 {
  arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
  if (tbFrom.options[i].selected && tbFrom.options[i].value != "") 
  {
   arrTo[tLength] = tbFrom.options[i].text;
   tLength++;
  }
  else 
  {
   arrFrom[fLength] = tbFrom.options[i].text;
   fLength++;
  }
}

tbFrom.length = 0;
tbTo.length = 0;
var ii;

for(ii = 0; ii < arrFrom.length; ii++) 
{
  var no = new Option();
  no.value = arrLU[arrFrom[ii]];
  no.text = arrFrom[ii];
  tbFrom[ii] = no;
}

for(ii = 0; ii < arrTo.length; ii++) 
{
 var no = new Option();
 no.value = arrLU[arrTo[ii]];
 no.text = arrTo[ii];
 tbTo[ii] = no;
}
}

function selectAllitems()
{
	var select=document.getElementById("ToLB");
	for(var i=0; i<select.options.length  ;i++)
	{
	
	select.options[i].selected=true;
	}


}
function selectAlloptions(id)
{
	var select=document.getElementById(id);
	var ckbox=document.getElementById("selall");
	if(ckbox.checked==true)
	{
		for(var i=0; i<select.options.length  ;i++)
		{
			select.options[i].selected=true;
		}
	}
	else
		{
		for(var i=0; i<select.options.length  ;i++)
		{
			select.options[i].selected=false;
		}
		}
	

}

function selectOption(opt)
{
	document.forms[0].option.value=opt;
	document.forms[0].submit();
	
}

function printtable()
{
	var printContent = document.getElementById("centre");

	var windowUrl = 'about:blank';
	var num;

	var uniqueName = new Date(); 
	var windowName = 'Print' + uniqueName.getTime();
	var printWindow = window.open(num, windowName, 'left=50,top=50,width=800,height=900');

	printWindow.document.write(printContent.innerHTML);

	printWindow.document.close();

	printWindow.focus();

	printWindow.print();

	

	 
}

function verifypass()
{
 var newpass=document.passwordform.npass.value;
 var cpass=	document.passwordform.cpass.value;
 if(newpass==cpass)
 {
	 document.passwordform.option.value="changepwd";
	 
	 return true;
 }
 else
 {
	 alert("New and Confirm Passwords are not matched");
	 document.passwordform.reset();
	 return false;
 }
 
}
