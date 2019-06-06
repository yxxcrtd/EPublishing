<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<%@ include file="/common/taglibs.jsp"%>
<head>
<daxtech-tag:CssTag/>
<daxtech-tag:JsTag/>
<%@ include file="/common/tools.jsp"%>
<script type="text/javascript" src="${ctx }/js/jquery-1.8.2.js"></script>
<script language="javaScript" src="<%=request.getContextPath()%>/script/EmailUtil.js"></script>
<title><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Edit.Title"/></title>
<script type="text/javascript" src="${ctx }/js/liquidmetal.js"></script>
<script type="text/javascript" src="${ctx}/js/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx}/js/iframeTools.js"></script>
<link href="${ctx}/css/flexselect.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function apply(){
var email = document.getElementById("emails").value;
	if(email.replace(/\s+/g,"")==""){
		$("#tips4").show().html("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.User.Registration.Prompt.email'/>");
		document.getElementById("emails").focus();
		return;
	}
	$.ajax({
 			type : "POST",  
 			url: "${ctx}/pages/expertUser/form/exportSubmitt",
 			data:  $("#form").serialize(),
		success: function(data) { 
		    var s = data.split("::");
		    if(s[0]=="success"){
		    	/* art.dialog.tips(s[1],1,'success',60); */
		    	 alert(s[1]);
		    	 art.dialog.close();
		    	location="${ctx}/pages/expertUser/form/expertManage";
		    }else if(s[0]=="error"){
		    	$("#tips4").show().html(s[1],1,'error');
		    }			    
		},
		error : function(data) { 
			var s = data.split("::");	
		    if(s[0]=="success"){
		    	art.dialog.tips(s[1],1,'success',20);
		    	/* location="${ctx}/"; */
		    }else if(s[0]=="error"){
		    	 $("#tips4").show().html(s[1],1,'error');
		    }	
		}  
	});
}
</script>
</head>
<body>
<form:form id="form" commandName="form1" >
				<h1>
				   	<!-- <p class="newLogin"><ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Publications.user.zhuang'/></p>  -->                         
				   <p style="font-size:18px; font-weight:bold;padding-left:10px;padding-top:12px"><ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Publications.user.zhuang'/></p>                          
				</h1>
                 <table>
                   <p style="margin-top: 10px;"><div id="tips4" style="width: 500px;"></div></P>
                         <tr>
<!-- 				         <td width="120" align="right"><ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Publications.user'/>：&nbsp;</td> -->
				          <p style="font-size:12px; padding-left:120px;"><ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Publications.user.zhuan'/></p>
				     </tr>
		              <tr style="vertical-align:top;">
		                 <td width="120" align="right"><span style="color:red;font-size:12px;">*</span><span style="font-size:12px;"><ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Publications.email'/></span>:&nbsp;</td>
				         <td><textarea rows="5" cols="30" name="emails" id="emails" style="width:600px; margin: 0px; height: 150px;"></textarea></td>
				     </tr>
				</table>
				&nbsp;&nbsp;&nbsp;
		<div align="center" class="mtp10">
    	<input type="button"  id="saveid" name="save" value="<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.Save1"/>"  class="orgingB" onclick="apply();"/>
    	&nbsp;&nbsp;
    	<input type="button" name="close" value="<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.Close"/>"  class="orgingB"onclick="art.dialog.close();"/>
	</div>
</form:form>
</body>
</html>
