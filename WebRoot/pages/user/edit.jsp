<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<%@ include file="/common/taglibs.jsp"%>
<head>
<daxtech-tag:CssTag/>
<daxtech-tag:JsTag/>
<base target="_self"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">if(/*@cc_on @_jscript_version+@*/0==10){document.write("<meta http-equiv='X-UA-Compatible' content='IE=edge'/>");}</script>
<script type="text/javascript" src="${ctx }/js/jquery-1.8.2.js"></script>
<script language="javaScript" src="<%=request.getContextPath()%>/script/EmailUtil.js"></script>
<title><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Edit.Title"/></title>
<script type="text/javascript" src="${ctx }/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${ctx }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.flexselect.custom.js"></script>
<script type="text/javascript" src="${ctx }/js/liquidmetal.js"></script>
<script type="text/javascript" src="${ctx}/js/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx}/js/iframeTools.js"></script>
<link href="${ctx}/css/flexselect.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var ue ;
 $(document).ready(function() {
 	$("select[class*=flexselect]").flexselect(); 
 });
function apply(){
	if(document.getElementById("isbn").value==""||document.getElementById("isbn").value.indexOf(' ')!=-1){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.isbn/issn'/>");
		document.getElementById("isbn").focus();
		return;
	}
	else{
		if(document.getElementById("isbn").value.length!=13){
			art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.isbn.issn.length'/>");
			document.getElementById("isbn").focus();
			return;
     	}
     	
	}
	if(document.getElementById("sourceId").value==""){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.sourceCode'/>");
		document.getElementById("sourceId").focus();
		return;
	}
	/**
	if(document.getElementById("salePrice").value==""){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.salePrice'/>");
		document.getElementById("salePrice").focus();
		return;
	}else{
		if(isNaN(document.getElementById("salePrice").value)){
			art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.salePrice.isNaN'/>");
			document.getElementById("salePrice").focus();
			return;
		}
	}
	if(document.getElementById("saleCurr").value==""){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.saleCurr'/>");
		document.getElementById("saleCurr").focus();
		return;
	}
	**/
	/* var oEditor = FCKeditorAPI.GetInstance('content');  
	var content =  oEditor.GetXHTML(); 
	if(content.length==0){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.Active.Too.Short'/>");
		$("#content").focus();
		return;
	}
	if(content.length>1024){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.Active.Too.Long'/>");
		$("#content").focus();
		return;
	} */
	var content =  ue.getContent(); 
	/* if(content.length==0){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.Active.Too.Short'/>");
		$("#content").focus();
		return;
	} */
	if(content.length>1024){
		art.dialog.alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.Content.Edit.Check.Active.Too.Long'/>");
		$("#content").focus();
		return;
	}
	$("#saveid").attr("disabled","disabled");
	document.getElementById("form").submit();
}
</script>
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/ui.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/pub.css" rel="stylesheet" type="text/css" />
</head>
<body>
<c:if test="${form.msg!=null&&form.msg != ''}">
	<script language="javascript">
		art.dialog.alert('${form.msg}');
		<c:if test="${form.isSuccess!=null&&form.isSuccess != ''&&form.isSuccess==true}">
			<c:if test="${form.id==null||form.id=='0'||form.id==''}">
				window.returnValue='${form.isbnsn}';
			</c:if>
			window.close();
		</c:if>
</script>
</c:if>
<form:form id="form" commandName="form" action="editSubmit">
<div class="bodyDiv" >
    <div class="bodyBg">
    <c:if test="${form.id==null||form.id=='0'||form.id==''}">
    	<h3><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Edit.New"/></h3>
    </c:if>
    <c:if test="${form.id!=null&&form.id!='0'&&form.id!=''}">
    	<h3><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Edit.Modify"/></h3>
    </c:if>
    <div>
    <p style="margin-left:0px;"><span class="red">*</span><ingenta-tag:LanguageTag sessionKey="lang" key="Global.Prompt.Must"/></p>
    <div class="book-module">
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="tab02">
      <tr>
        <th width="5%"><span class="red">*</span><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.ISBN/ISSN"/>：</th>
        <td width="50%" align="left">
        	<c:if test="${form.id==null||form.id=='0'||form.id==''}">
		    	<form:input path="sbn" id="isbn" cssStyle="width:100%"/>
		    </c:if>
		    <c:if test="${form.id!=null&&form.id!='0'&&form.id!=''}">
		    	<form:hidden path="sbn" id="isbn"/>
		    	${form.sbn}
		    </c:if>
        </td>
      </tr>
       <tr>
        <th width="5%"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.ChineseTitle"/>：</th>
        <td width="50%" align="left">
		    <form:input path="obj.chineseTitle" id="chineseTitle" cssStyle="width:100%"/>
        </td>
      </tr>
      <tr>
        <th width=5%"><span class="red">*</span><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.SourceCode"/>：</th>
        <td width="50%" align="left">
        	<c:if test="${form.id==null||form.id=='0'||form.id==''}">
	        	<form:select path="obj.source.id" id="sourceId" cssStyle="width:100%" class="flexselect">
	        		<form:option value=""></form:option>
	        		<c:forEach items="${form.sourceList}" var="s">
						<form:option value="${s.id}">${s.name}</form:option>
					</c:forEach>
	        	</form:select>
        	</c:if>
        	<c:if test="${form.id!=null&&form.id!='0'&&form.id!=''}">
		    	<form:select path="obj.source.id" id="sourceId" disabled="true" cssStyle="width:100%" class="flexselect">	        		
	        		
	        		<c:forEach items="${form.sourceList}" var="s">
						<form:option value="${s.id}">${s.name}</form:option>
					</c:forEach>
					<!-- <form:hidden path="obj.source.id"/> -->
	        	</form:select>
		    </c:if>
        </td>
      </tr>
      <!-- 
      <tr>
        <th width="15%"><span class="red">*</span><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.SalePrice"/>：</th>
        <td width="85%" align="left">
        	<form:input path="obj.salePrice" id="salePrice" cssStyle="width:100%"/>
        </td>
      </tr>
      <tr>
        <th width="15%"><span class="red">*</span><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.SaleCurr"/>：</th>
        <td width="85%" align="left">
        	<form:select path="obj.saleCurr" cssStyle="width:100%" id="saleCurr">
				<form:option value=""><ingenta-tag:LanguageTag sessionKey="lang" key="Global.Prompt.Select"/></form:option>
				<c:forEach items="${form.currlist}" var="c">
					<form:option value="${c.code}">${c.code}</form:option>
				</c:forEach>
			</form:select>
        </td>
      </tr>
      -->
      <tr>
       <th width="5%"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.Available"/>：</th>
        <td align="left">
			<form:select path="obj.available" id="available" style="width:100%">
        		<option value="0"><ingenta-tag:LanguageTag sessionKey="lang" key="Global.Prompt.Select"/></option>
        		<c:forEach items="${form.availableMap}" var="c">
        			<c:if test="${form.id==null||form.id=='0'||form.id==''}">
        				<option value="${c.key}" <c:if test="${1==c.key}"> selected</c:if>>${c.value}</option>
				    </c:if>
				    <c:if test="${form.id!=null&&form.id!='0'&&form.id!=''}">
				    	<option value="${c.key}" <c:if test="${form.obj.available==c.key}"> selected</c:if>>${c.value}</option>
				    </c:if>
				</c:forEach>
       		</form:select>
		</td>
      </tr>
      <tr style="display:none">
       <th width="5%"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.Type"/>：</th>
        <td align="left">
        	<input type="hidden" name="obj.type" value="1"/>
			<%-- <select name="obj.type" style="width:100%">
        		<option value="0"><ingenta-tag:LanguageTag sessionKey="lang" key="Global.Prompt.Select"/></option>
        		<c:forEach items="${form.typeMap}" var="c">
        			<option value="${c.key}" <c:if test="${form.obj.type==c.key}"> selected</c:if>>${c.value}</option>
				</c:forEach>
       		</select> --%>
		</td>
      </tr>
      <tr>
        <th width="10%"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.Content.Table.Lable.Activity"/>：</th>
        <td width="85%" align="left">
			 <script name="obj.activity" id="content" type="text/plain" style="width:300%;height:300px">${form.content}</script>
			 <script type="text/javascript">
				//实例化编辑器
			    ue = UE.getEditor('content',{
			    	//关闭字数统计
		            wordCount:false,
		            //关闭elementPath
		            elementPathEnabled:false
			    });
			</script>
		</td>
	  </tr>
    </table>
    </div>
    <div align="center" class="mtp10">
    	<input type="button"  id="saveid" name="save" value="<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.Save"/>" class="devil_button" onclick="apply()"/>
    	<input type="button" name="close" value="<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.Close"/>" class="devil_button" onclick="art.dialog.close();"/>
	</div>
    <div class="mtp10"></div>
    </div>
  </div>    
</div>
	<form:hidden path="id"/>
	<form:hidden path="obj.local"/>
</form:form>
</body>
</html>
