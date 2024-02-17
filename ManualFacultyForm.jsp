<br></br>
<br></br>
<form name="Faculty" action="./ActionServlet" method="post">
<input type="hidden" name="option" value="ftmanualentry"></input>
<center>
<table align="center" border="0">
 
  <tr>
    <td align=left>Faculty ID :</td>
    <td> 
 <input maxlength="10" name="fid" style="text-transform: uppercase;"></td></tr>
  <tr>
    <td align=left>Faculty name :</td>
    <td align=left> 
    <input maxlength="30" name="fname" style="text-transform: uppercase;"></td></tr>
  <tr>
    <td align=left>Department :&nbsp;</td>
    <td align=left> 
  <select size=1 name=dept>
  <option value=""></option>
  <option value="Pharmaceutics" >Pharmaceutics</option> 
  <option value="Pharmacology">Pharmacology</option>
   <option value="Pharmaceutical Chemistry">Pharmaceutical Chemistry</option> 
   <option  value="Pharmaceutical Analysis">Pharmaceutical Analysis</option>
    <option value="Pharmacy Practice">Pharmacy Practice</option> 
    <option value="Others">Others</option> 
  </select></td></tr>
  <tr>
    <td align=left><input type="submit" value="Submit" name="submit"></td>
    <td align=left><input type="reset" value="Reset" name="reset"></td></tr></table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
</center>
