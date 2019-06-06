<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv='X-UA-Compatible' content='IE=edge' />
<meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
<%@ include file="/common/tools.jsp"%>
<%@ include file="/common/ico.jsp"%>
<title>CNPIEC eReading: Introducing CNPIEC eReading</title>

<link href="${ctx}/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/index.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/flexpaper/css/flexpaper.css" rel="stylesheet" type="text/css" />

<%-- jquery.mmenu START --%>
<link href="${ctx }/js/mmenu_plugin/dist/css/demo.css" rel="stylesheet" type="text/css" />
<link href="${ctx }/js/mmenu_plugin/dist/css/jquery.mmenu.all.css" rel="stylesheet" type="text/css" />
<link href="${ctx }/js/mmenu_plugin/dist/css/extensions/jquery.mmenu.positioning.css" type="text/css" rel="stylesheet" />
<%-- jquery.mmenu END   --%>

<%-- 与上common冲突 --%>
<%-- <script type="text/javascript"
	src="${ctx}/flexpaper/flex_js/jquery.min.js"></script> --%>
<%-- <script type="text/javascript" src="${ctx }/flexpaper/jquery-1.11.3.js"></script> --%>
<script type="text/javascript" src="${ctx }/js/jquery-2.1.4.js"></script>

<%-- <script type="text/javascript" src="${ctx}/flexpaper/js/common.js"></script> --%>

<%-- jquery.mmenu --%>
<script type="text/javascript" src="${ctx }/js/mmenu_plugin/dist/js/jquery.mmenu.min.all.js"></script>

<script type="text/javascript" src="${ctx}/flexpaper/flex_js/jquery.extensions.min.js"></script>
<script type="text/javascript" src="${ctx}/flexpaper/flex_js/flexpaper.js"></script>
<script type="text/javascript" src="${ctx}/flexpaper/flex_js/flexpaper_handlers.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery-heartbeat.js"></script>
<%-- <script type="text/javascript" src="${ctx}/flexpaper/flex_js/FlexPaperViewer.js"></script> --%>
<script type="text/javascript" src="${ctx}/js/jquery.cookie.js"></script>
<%--    zclip JS复制功能    Start  --%>
<script type="text/javascript" src="${ctx}/flexpaper/zclip/jquery.zclip.js"></script>
<%--    zclip JS复制功能     End --%>
<%-- 导航栏不随页面滚动plugin  Start --%>
<script type="text/javascript" src="${ctx}/js/posfixed.js"></script>
<%-- 导航栏不随页面滚动plugin  End --%>
<script type="text/javascript">

	$(function(){		
		$("#prePage").click(function(e){
			var curNumber=Number($("#curNumber").text());
			if(curNumber>1)
				aaaa(curNumber-1);
			else
				alert("没有了");
		});
		$("#nextPage").click(function(e){
			var curNumber=Number($("#curNumber").text());
			var allNumber=Number($("#allNumber").text());
			if(curNumber<allNumber)
				aaaa(curNumber+1);
			else
				alert("没有了");
		});
	});
	</script>
<script type="text/javascript">
	//<![data[
	var noteLength_yes = "<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.yes'/>";
	var noteLength_number = "<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.number'/>";
	var noteLength_no = "<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.no'/>";
	var delBut = "<ingenta-tag:LanguageTag sessionKey='lang' key='Global.Button.Delete'/>";
	var ctx = "<c:if test="${ctx!=''}">${ctx}</c:if><c:if test="${ctx==''}">${domain}</c:if>";
	var chapterText = "<ingenta-tag:LanguageTag sessionKey='lang' key='Page.view.Lable.Chapter'/>"; 
	var tryReadingFlag = false ; 
	$(function() { 
		//获取快捷工具
//		getQuickTools();
	 	//获取章节列表
		getTocList();
		$("#content").bind("input propertychange", function() { 
		strLenCalc($(this), 'checklen', 2000);
		}); 
		initMenu();
		// 判断试读标识
		var pageEnableNum = "${form.pageEnableNum}";
		tryReadingFlag = pageEnableNum && 0!=pageEnableNum ? true : false ; 
	});

	//获取章节列表
	 function getTocList(){
		var parObj=$("#chapter_label");
		$.ajax({
			type : "POST",
			async : false,    
	        url: "${ctx}/pages/view/png/form/tocList",
	        data : {
	        	id : '${form.id}',
	        	pageEnableNum : '${form.pageEnableNum }'
	        },
	        success : function(data) { //alert(data);
	        	if(data && $.trim(data)!=''){//alert('a');
	            	$(parObj).html(data);
	            	$(parObj).css("text-align","left");
	            }else{//alert('b');
	            	$(parObj).hide();
	            	$(parObj).prev("h1").hide();
	            	$(parObj).html("");
	            }
	           }, 
	           error : function(data) {
	             	$(parObj).html(data);
	           }  
	     });
	} 
	
  function initMenu() {
  $('#menu ul').hide();
  $('#menu ul:first').show();
  $('#menu li a').click(
    function() {
      var checkElement = $(this).siblings().next();
      if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
        return false;
        }
      if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
        $('#menu ul').slideUp('normal');
        checkElement.slideDown('normal');
        return false;
        }
      }
    );
  }  
//检查笔记长度
function strLenCalc(obj, checklen, maxlen) { 
	var v = obj.val(), charlen = 0, maxlen = !maxlen ? 1000 : maxlen, curlen = maxlen, len = v.length;
	for(var i = 0; i < v.length; i++) {
		if(v.charCodeAt(i) < 0 || v.charCodeAt(i) > 255) { 
			curlen -= 1; 
		} 
	}
	if(curlen >= len) { 
		$("#checks").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.yes'/> <strong>"+Math.floor((curlen-len)/2)+"</strong> <ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.number'/>").css('color', ''); 
	} else { 
		$("#checks").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.no'/> <strong>"+Math.ceil((len-curlen)/2)+"</strong> <ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength.number'/>").css('color', '#FF0000'); 
	} 
}
//删除笔记
function deleteNote(id){
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/deleteNote",
        data: {
        	id:id,
			r_ : new Date().getTime()
         },
         success : function(data) {
           	var s = eval(data);
           	alert(s[0].info);
           	if(s[0].msg=='success'){
           		//删除
           		$("#nodes_"+id).css("display","none");
           		$("#isNote").val('');           	
           	}  
          },  
          error : function(data) {  
    			alert(data,1,'error');
    	  }  
	});
}
//添加笔记
function addNotes(){
	var content = $.trim($('#content').val());
	//alert($("#checks").css("color")=='rgb(255, 0, 0)');
	if(content==''){
		alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteNull'/>");
	}else if($("#checks").css("color")=='rgb(255, 0, 0)'){
		alert("<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Prompt.NoteLength'/>");
	}else{
		$.ajax({
				type : "POST",  
	            url: "${ctx}/pages/view/form/addNote",
	            data: {
	            	pageNum:$FlexPaper('documentViewer').getCurrPage(),
	            	sourceId:'${form.id}',
	            	noteContent:$('#content').val(),
	            	id:$('#isNote').val(),
					r_ : new Date().getTime()
	            },
	            success : function(data) {  
	              var s = eval(data);
	              if(s[0].success!=null&&s[0].success!=undefined){
		              alert(s[0].success);
		              $("#isNote").val(s[0].noteId);  
		              
		              var curNum = $FlexPaper('documentViewer').getCurrPage();
				      //dispaly:inline-block
				   	  var newp='<p id="nodes_'+ s[0].noteId +'"><span>'
				   	  +'<a style=\"margin: 0px;padding: 0px; border-bottom: none;background:none;\" onclick=\"$FlexPaper(\'documentViewer\').gotoPage(\''+ curNum +'\')\" >'+curNum+'__'+content+'</a></span><span>'
			              +'<a onclick=\"deleteNote(\''+ s[0].noteId +'\')" title=\"'+delBut+'\"><img style=\"margin-top: 16px; " src=\"${ctx}/images/cao.gif\"/></a></span></p>'; 
				   			var pArr=$("#noteList").find("p");
				   			if(pArr!=null && pArr.length>0){	   		
					   		for(var i=0;i<pArr.length;i++){
					   			var text=$(pArr[i]).text();
					   			var tArr= text.trim().split('__');
					   			if(curNum<tArr[0]){
					   				$(pArr[i]).before(newp);
					   				flag=1;
					   				break;
					   			}else if(curNum==tArr[0]){
					   				$(pArr[i]).html(newp);
					   				flag=1;
					   				break;
					   			}else if(i==pArr.length-1){
									$(pArr[i]).after(newp);	   			
					   			}	   			
					   		}	   		
					   	}else{
					   		$("#noteList").append(newp);
					   	}					
		          }else{
			          	if(s[0].error!=undefined){
			          		alert(s[0].error);
			          	}
		          }
            },  
            error : function(data) {  
              var s = eval(data);
              alert(s[0].error);
            }  
		});
	}
}
//添加标签
function addLabels(){
	var currPage = $("#curr").val();
	var currPage2=$FlexPaper('documentViewer').getCurrPage();
	if( currPage2!=0){
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/addLable",
        data: {
        	sourceId:$("#pubId11").val(),
        	pageNum:$FlexPaper('documentViewer').getCurrPage(),
			r_ : new Date().getTime()
        },
        success : function(data) {  
        	var s = data.split(":");
        	alert(s[1]);  
        	if(s[0]=="success"){
        		var curNum = $FlexPaper('documentViewer').getCurrPage();
        		$("#label1").bind("click",function(){
        			$FlexPaper('documentViewer').gotoPage(curNum);
				});
        		$("#label1").html("<ingenta-tag:LanguageTag sessionKey="lang" key='Pages.view.lable.lable1'/>："+curNum);
        	}
        },  
        error : function(data) {  
          alert(data);
        }  
	});
	}
}
//搜索 
function aaaa(page){
	
	if($("#searchView").val()!=''){
		var pcont=15;
		page = page || 1;
		$.ajax({
 				type : "POST",  
            url: "${ctx}/pages/view/form/search",
            data: {
            	id:'${form.id}',
            	value:$("#searchView").val(),
            	curpage:page,
            	pageCount:pcont,
				r_ : new Date().getTime()
            },
            success : function(data) {
	            var s = eval(data);
	            var resultHtml ="<ingenta-tag:LanguageTag sessionKey='lang' key='Pages.view.Label.Result'/>：";
	            if(s[0].count==undefined){
	            	resultHtml += "0";
	            }else{
	            	resultHtml += s[0].count;
	            }
	            
	            //搜索到的结果数量
	           var allResultCount = s[0].count?s[0].count:0 ; 
	           	//总分页数
	           var pageCount = s[0].count?Math.ceil(s[0].count / pcont):0 ; 
	         	var trim_search_val = $.trim($("#searchView").val()); 
	         	/** hr.yuan 屏蔽翻页功能   */
	            /** 
	            $("#searchText").html(resultHtml);
	            $("#curNumber").text(s[0].count?page:0);
	            $("#allNumber").text(s[0].count?Math.ceil(s[0].count / pcont):0);
	            $("#search_result").show();*/
	            $('#search_list').show();
	            var ss = s[0].result;
		        page==1 && $("#search_list").html("<b style=\"font-size:10px;\">搜索到&nbsp;"+allResultCount+"&nbsp;记录</b><br>");
		       // ss.length>0 && highlightSearchVal(1,trim_search_val);
		          //搜索到了内容
	            if(ss.length>0){
		            var listHtml = "";
		            $.each(ss,function(i,item ){
		            	if(tryReadingFlag && ss[i].pageNumber > ($('#pageEnableNum').val()-1) ){
		                	listHtml += "<p style=\"line-height:normal;height:auto;margin-bottom:5px;cursor:pointer\" >第<b>"+ss[i].pageNumber+".</b>页&nbsp;</p><p style=\"font-size:12px\">"+ss[i].hlMap[0] + "</p>";
		            	}else{
			            	listHtml += "<a style=\"padding-left:1px;font-size:13px;line-height:normal;height:auto;margin-bottom:5px;cursor:pointer\" onclick=\"highlightSearchVal("+ss[i].pageNumber+",'"+trim_search_val+"');\" >第<b style='color:#258FD4'>"+ss[i].pageNumber+".</b>页&nbsp;</a><p style=\"font-size:12px\">"+ss[i].hlMap[0] + "</p>";
		            	}
					}); 
					$("#search_list").append(listHtml); 
	            	$('#search_list').height("200px");
	            	if(page < pageCount){
	            		aaaa(page+1);
	            	}
	            }else{
	            	$('#search_list').height("25px");
	            }
		    },  
		    error : function(data) {  
		      alert(sdata);
		    }  
		});
	}
}

//跳转页面、搜索内容高亮显示
function highlightSearchVal(pageNum,searchVal){
	var evt = this.event || window.event ; 
	jumpToSearchPage(pageNum,searchVal,evt);
	setTimeout(function(event){
		jumpToSearchPage(pageNum,searchVal,evt);
		if($('.flexpaper_selected').length < 1 ){
			$FlexPaper('documentViewer').gotoPage(pageNum);
		}
			$('input.flexpaper_txtPageNumber').val(pageNum);
	},800);
}

//拷贝
function copy(){
	var currentPage = $FlexPaper('documentViewer').getCurrPage() ; 
	 $.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/png/form/tocCopy",
        data: {
        	pubId:$("#pubId11").val(),
           	pageNum:currentPage,
           	licenseId:$("#licenseId11").val(),
           	count:$("#pageCount11").val(),
           	readCount:$("#readCount11").val(),
        	isCopy:true,
        	readCount:'${form.readCount}',
			r_ : new Date().getTime()
        },
        success : function(data) {  
          var s = eval(data);
          if(s[0].isCopy=='true'){          	
          		//隐藏拷贝按钮
        	  $("#btn_copy").css("display","none");          	
          		//$FlexPaper('documentViewer').switchSelect(true);
          		//开启-关闭页面选中按钮
        	  $('.flexpaper_bttnTextSelect').removeAttr('style');
        	  $('.flexpaper_bttnTextSelect').addClass('flexpaper_tbbutton_pressed');
        	  $('.flexpaper_bttnTextSelect').click();      
        	  
        		//显示copy按钮，复制内容到剪贴板
        	  copyToClip(currentPage);
        	  
          } else{
          	alert(s[0].error);
          } 
          static_count = s[0].copyCount ; 
       	  $("#copyCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.copy.page'/>："+s[0].copyCount);
       		//currPage_num = $FlexPaper('documentViewer').getCurrPage() ; 
        },  
        error : function(data) {  
        	var s = eval(data);
            alert(s[0].error);
        }  
	}); 
}
/* 屏蔽之前的下载功能 hengrun.yuan
//下载
function downloadaaaaa(){
	if(!getToken()){
		return ; 
	}
	var pagenum = $FlexPaper('documentViewer').getCurrPage();
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/ajaxDownload",
        data: {
        	pubId:$("#pubId11").val(),
           	pageNum:pagenum,
           	licenseId:$("#licenseId11").val(),
           	count:$("#pageCount11").val(),
			r_ : new Date().getTime()
        },
        success : function(data) {  
          var s = eval(data);
          if(s[0].isDownload=='true'){
          	window.location.href="${ctx}/pages/view/png/form/download?pubId="+$("#pubId11").val()+"&pageNum="+$FlexPaper('documentViewer').getCurrPage();
          } else{
          	$("#bbbbb").css("display","none");
          	alert(s[0].error);
          } 
       	  $("#downloadCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.download.page'/>："+s[0].downloadCount);
        },  
        error : function(data) {  
          var s = eval(data);
          alert(s[0].error);
        }  
	});	
}
*/
//下载
function downloadaaaaa(){
	if(!getToken()){
		return ; 
	}
	var pagenum = $FlexPaper('documentViewer').getCurrPage();
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/ajaxDownload",
        data: {
        	pubId:$("#pubId11").val(),
           	pageNum:pagenum,
           	licenseId:$("#licenseId11").val(),
           	count:$("#pageCount11").val(),
			r_ : new Date().getTime()
        },
        success : function(data) {  
          var s = eval(data);
          if(s[0].isDownload=='true'){
          	window.location.href="${ctx}/pages/view/form/download?pubId="+$("#pubId11").val()+"&pageNum="+$FlexPaper('documentViewer').getCurrPage();
          } else{
          	$("#bbbbb").css("display","none");
          	alert(s[0].error);
          } 
       	  $("#downloadCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.download.page'/>："+s[0].downloadCount);
        },  
        error : function(data) {  
          var s = eval(data);
          alert(s[0].error);
        }  
	});	
}

// 全文下载
function downloadFullPage(pubId){
	if(pubId){
		window.location.href="${ctx }/pages/view/form/download?pubId="+pubId+"&enableDownloadCount=${form.downloadCount}&isFull=true";
		 $("#downloadCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.download.page'/>：${form.downloadCount }");
	}else{
		return ; 
	}	
}

//Token judge
function getToken(){

	var pathVal = "/" ; 
	var token = $.cookie("token");
	if (token) {
		$.cookie("token",null,{path:pathVal});
		$.cookie("token",token.substr(1),{path:pathVal});
		return true ; 
	}
	return false ; 
	

}

//连续下载 2015-09-24 增加是否连续下载设置 1-允许连续打印 2-不允许连续打印 0-默认值 By ruixue.cheng
function continuousDownload(){
	if(!getToken()){
		return ; 
	}
	var pagenum =  $FlexPaper('documentViewer').getCurrPage();
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/ajaxContinuousDownload",
        data: {
        	pubId:$("#pubId11").val(),
           	pageNum:$("#downloadStr").val(),
           	licenseId:$("#licenseId11").val(),
           	count:$("#pageCount11").val(),
			r_ : new Date().getTime()
        },
        success : function(data) {  
          var s = eval(data);
          if(s[0].isDownload=='true'){
          	window.location.href="${ctx}/pages/view/form/downloadBatch?pubId="+$("#pubId11").val()+"&pageNum="+$("#downloadStr").val()+"&count="+$("#pageCount11").val();
          } else{
          	$("#bbbbb").css("display","none");
          	alert(s[0].error);
          } 
       	  $("#downloadCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.download.page'/>："+s[0].downloadCount);
        },  
        error : function(data) {  
          var s = eval(data);
          alert(s[0].error);
        }  
	});	
}

//打印
function ajaxPrint(){

	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/view/form/ajaxPrint",
        data: {
        	pubId:$("#pubId11").val(),
           	pageNum:$("#printStr").val(),
           	licenseId:$("#licenseId11").val(),
           	count:$("#pageCount11").val(),
			r_ : new Date().getTime()
        },
        success : function(data) {  
          var s = eval(data);
          if(s[0].isPrint=='true'){ 
        	  var print_page_num = s[0].printTask;
        	/*   console.log($FlexPaper('documentViewer')); */
        	  $FlexPaper('documentViewer').printPaper(print_page_num + ",");
        	 /*  $('div#modal-print').hide();
        	  $('input#toolbar_documentViewer_bttnPrintDialog_RangeSpecific').click();
        	  $('input#toolbar_documentViewer_bttnPrintDialogRangeText').val(print_page_num + ",");
        	  $('a#toolbar_documentViewer_bttnPrintdialogPrint').click(); */
          } else{
          	alert(s[0].error);
          } 
       	  $("#printCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.print.page'/>："+s[0].printCount);
        },  
        error : function(data) {  
          var s = eval(data);
          alert(s[0].error);
        }  
	});		
}
function closeReadWindow(){
	var tmp=window.close("about:blank","","fullscreen=1") ;
	//var tmp = window.open('','_self','');
	tmp.close();
    
	$.ajax({
		type : "POST",  
        url: "${ctx}/pages/complication/close",
        data: {
			r_ : new Date().getTime()
        },
        success : function(data) {
        	//history.back();//location.href="${ctx}"==""?"/":"${ctx}";
        	tmp.location=url; 	
        },  
        error : function(data) { 
        	//history.back();//location.href="${ctx}"==""?"/":"${ctx}";
        	tmp.location=url;
        }  
	});	
}
var waitTimes=0;
var tryTimes=0;
function waitReady(){
	var p=getUrlParam("nextPage");
	if(p && p>1){
		if(waitTimes<10){
			try{
				$FlexPaper('documentViewer').gotoPage(p);
				if(tryTimes<3){
					setTimeout(waitReady,500);
					tryTimes++;
				}
			}catch(e){
				waitTimes++;
				setTimeout(waitReady,500);
			}
		}
	}
}
function getUrlParam(name){
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = window.location.search.substr(1).match(reg);  //匹配目标参数
	if (r!=null) 
		return unescape(r[2]); 
	return null; //返回参数值
} 
//]]-->	 
</script>
<script type="text/javascript">
	$(document).ready(function(){
		waitReady();
	});
	
	function addDisplay(){
		
		setTimeout("hiddenSelect_but()",4500);
		
	}
	//显示copy按钮，复制内容到剪贴板
	function copyToClip(pageNum){
		var r = "";
		var r_val = "" ; 
		//鼠标按下，清空 id='selector' 中的内容
		document.getElementById("pageContainer_"+(pageNum-1)+"_documentViewer").onmousedown = function(e){
			$("#selector").val("");
			$("#tooltip").remove();
		}
		
	 	//拷贝功能
		document.getElementById("pageContainer_"+(pageNum-1)+"_documentViewer").onmouseup = function(e){
			var x = 1;
			var y = 10;
	 	 try{
	          r = $("#selector").val();
	  		}catch(e){
	  			console.log(e);
	  		}
	  		if(r && $.trim(r)){
	  			r_val = r ; 
	  		if (r_val && $.trim(r_val)!="") {
	  			var tooltip = '<div id=\"tooltip\" hidden=\"hidden\" class=\"divStyle\">'+
	                      '<input id=\"copyButton\" type=\"button\" value=\"复制\" ></div>';
	  			$("body").append(tooltip);
	  			$("#tooltip").css({
	  				"top": (e.pageY + y) + "px",
	  				"left": (e.pageX + x) + "px",
	  				"position": "absolute"
	  			}).show("fast");
	        setTimeout(function () {
	          $("#copyButton").zclip({
	              path: "${ctx}/flexpaper/zclip/ZeroClipboard.swf",
	              copy: function(){
	                return r_val;
	              },
	               afterCopy:function(){
	                $("#copyButton").zclip('hide');
	                $("#copyButton").zclip('remove');
	                $("#tooltip").remove();
	               }
	          });
	        }, 100);
	      }else{
	    	  $("#tooltip").remove();
	      }
	  	} 
		}
	}
	//隐藏/显示工具栏
	function hideShowTools(){
		if($('#toolsBar').is(':hidden')){
			$('#switchBut').attr({'title':'隐藏快捷工具'});
			$('#toolsBar').show("slow");
		}else{
			$('#switchBut').attr({'title':'显示快捷工具'});
			$('#toolsBar').hide("slow");
		}
	}

	function hiddenSelect_but(){
		
		tryReadingFlag ? $('.flexpaper_bttnTextSelect').css("display","none") : null ; 
		$("#toolbar_documentViewer_barSearchTools:last").hide();
		$('.flexpaper_bttnTextSelect').css("display","none");
		$('#toolbar_documentViewer').append("<img id='switchBut' title='隐藏快捷工具' src='${ctx}/images/black_ico/tool_ico.png' style='margin-top:6px;margin-left:3px;height:16px;' onclick='javascript:hideShowTools();'/>");
		// 禁用拖拽
		 document.ondragstart = function() {
	   		return false;
	 	 }
		// ## 屏蔽右键菜单功能
		$("*.flexCont").bind("contextmenu",function(e){
				return false;
		});
	}

	  $(function() {
		   
		   $('nav#menu').mmenu({
			   	extensions	: ['pageshadow'],
			   	navbar 		: {
					title   : chapterText
				},
			   /* , 默认在左侧显示，打开之后显示在右侧*/
				offCanvas: {
		           zposition : "front"
		      	} 
		   }); 
		   
			// 点击之后关闭章节列表
			var API = $('nav#menu').data( "mmenu" );
			$("#chapter_label ").click(function(){
					API.close();	
			});
		   
	  }); 	
</script>
<c:if test="${beatInterval!=null && beatInterval!='' && beatInterval!='0'}">
	<script type="text/javascript">
$(document).ready(function(){
	$.jheartbeat.set({
		 url: "${ctx}/pages/view/form/beat?l=${form.licenseId }", // The URL that jHeartbeat will retrieve
		 delay: ${fn:trim(beatInterval)}000, // How often jHeartbeat should retrieve the URL
		 div_id: "test_div"}, // Where the data will be appended.
		 function (){
		  
		 });
});
</script>
</c:if>
<style type="text/css">
.search_word ul {
	background: #f8f8f8;
	border-left: 1px solid #bcbcbc;
	border-right: 1px solid #bcbcbc;
	border-bottom: 1px solid #bcbcbc;
	width: 86px;
	display: none;
	position: absolute;
	z-index: 5;
	margin-left: 380px;
	margin-top: 55px;
	margin-left: 380px\9; >
	margin-left /*IE5.5*/: -105px; >
	margin-top /*IE5.5*/: 53px;
}

*+html .search_word ul {
	margin-left: -103px;
	margin-top: 53px;
}

@media screen and (-webkit-min-device-pixel-ratio:0) {
	.search_word ul {
		margin-left: 380px;
	}
}

.search_help ul {
	margin-top: -7px;
	margin-left: 484px;
	margin-left: 484x\9;
	_margin-left: -93px;
	_margin-top: 56px;
}

*+html .search_help ul {
	margin-left: -92px;
	margin-top: 55px;
}

@media screen and (-webkit-min-device-pixel-ratio:0) {
	.search_help ul {
		margin-left: 484px;
	}
}

a {
	cursor: pointer;
}

.readlist {
	background: #fff none repeat scroll 0 0;
	border: 1px solid #ccc;
	border-radius: 8px;
	display: block;
	margin-left: 69%;
	margin-top: 40px;
	padding: 0 10px 10px;
	position: absolute;
	width: 184px;
	z-index: 1001;
}

div.readlist #menu li {
	background: none;
	background-color: white;
}

.write {
	color: #258FD4;
}
</style>
</head>
<body style="overflow: hidden" onload="addDisplay();">
	<c:if test="${webUrl==null||webUrl=='' }">
		<div>
			<!--  目录内容  START-->
			<div class="header">
				<a href="#menu"></a> ${fn:replace(fn:replace(fn:replace(form.publicationsTitle,"&lt;","<"),"&gt;",">"),"&amp;","&")}
			</div>
			<nav id="menu" style="text-align: center; filter:alpha(Opacity=80);-moz-opacity:0.8;opacity: 0.8;">
			<ul class="hierarchy" id="chapter_label" style="text-align: center;">
				<img src="${ctx}/images/loading.gif" />
			</ul>
			</nav>
		</div>
		<!--  目录内容  END -->

		<!--右侧内容开始 <右侧快捷工具栏> -->
		<div class="readlist" id="toolsBar"
			style="width: 184px; margin-left: 69%;  margin-top: 80px; z-index: 1001; position: absolute; display:block;">
			<c:if test="${form.id=='402880f1491210950149127d95020001' }">
				<h1>视频列表</h1>
				<ul class="hierarchy" style="text-align: left;">
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-1.mp4')">视频1： 重建手术1</a></li>
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-2.mp4')">视频2：软骨移植操作</a></li>
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-3.mp4')">视频3：重建手术2</a></li>
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-4.mp4')">视频4：膝盖骨加固操作</a></li>
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-5.mp4')">视频5：自体软骨细胞</a></li>
					<li class="hierarchy_li1"><a href="#login-modal" onclick="showVideo('video-45-6.mp4')">视频6：肌腱切割操作</a></li>
				</ul>
			</c:if>
			<h1>
				<ingenta-tag:LanguageTag sessionKey='lang' key='Page.view.Lable.tools' />
			</h1>
			<ul id="menu">
				<li><a><span class="alph"><img src="${ctx }/images/black_ico/ico_01.png" style="margin-top:13px; margin-left:-18px;" /></span>
						<span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Search" /></span></a>
					<ul class="tag">
						<li>
							<div>
								<p>
									<input class="a_input" type="text" id="searchView" /> <a style="cursor: pointer;" class="a_cxu" onclick="aaaa();"> <ingenta-tag:LanguageTag
											sessionKey="lang" key="Global.Button.Search" />
									</a>
								</p>
								<div></div>
								<br />
								<p id="search_result" class="book_b" style="padding-top: 10px;padding-bottom: 10px;display:none">
									<span id="searchText"></span><br /> <img id="prePage" style="cursor:pointer;float:none" src="${ctx }/images/pre.png" /> <span
										id="curNumber">0</span> / <span id="allNumber"></span>&nbsp;&nbsp;&nbsp; <img id="nextPage" style="cursor:pointer;float:none"
										src="${ctx }/images/next.png" />

								</p>
								<!--  <p id="search_list"></p> -->
								<div style="display:none;overflow-y:auto;height: 200px; border-color: red; border-width: 2px;" id="search_list"></div>
						</li>
					</ul></li>
				<c:if test="${sessionScope.mainUser!=null }">
					<li><a><span class="alph"><img src="${ctx }/images/black_ico/ico_04.png" style="margin-top:13px; margin-left:-18px;" /></span>
							<span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Record" /></span></a>
						<ul class="tag">
							<li>
								<div>
									<p class="book_b">
										<c:if test="${form.record!=null&&form.record.pages.number>0 }">
											<a id="label1" onclick="javascript:$FlexPaper('documentViewer').gotoPage('${form.record.pages.number}');"
												style="margin: 0px;padding: 0px;border-bottom: none;background: none;"> <ingenta-tag:LanguageTag sessionKey="lang"
													key="Pages.view.lable.lable1" />：${form.record.pages.number }
											</a>
										</c:if>
										<c:if test="${form.record==null||form.record.pages.number==null || form.record.pages.number<=0 }">
											<a id="label1" style="margin: 0px;padding: 0px;border-bottom: none;background: none;"> <ingenta-tag:LanguageTag
													sessionKey="lang" key="Pages.view.lable.nolable" />
											</a>
										</c:if>
									</p>
									<p class="book_a">
										<a onclick="addLabels();" class="a_gret"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.lable.button" /></a>
									</p>
								</div>
							</li>
						</ul></li>
					<li><a><span class="alph"> <input type="hidden" id="isNote" value="" /> <img src="${ctx }/images/black_ico/ico_02.png"
								style="margin-top:13px; margin-left:-18px;" />
						</span> <span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Notes" /></span></a>
						<ul class="tag newTag">
							<li>
								<div>
									<div id="noteList">
										<c:forEach items="${form.noteList }" var="nlist" varStatus="index">
											<p id="nodes_${nlist.id }">
												<span> <a style="margin: 0px;padding: 0px; border-bottom: none;background:none;"
													onclick="javascript:$FlexPaper('documentViewer').gotoPage(${nlist.pages.number})"> ${nlist.pages.number }__${nlist.noteContent }
												</a>
												</span> <span> <a onclick="deleteNote('${nlist.id }')"><img style="margin-top: 16px;" src="${ctx}/images/cao.gif" /></a>
												</span>
											</p>
										</c:forEach>
									</div>
									<p class="book_cont" id="checks"></p>
									<p>
										<textarea name="content" id="content"></textarea>
									</p>
									<p class="book_a">
										<a name="save" style="display: inline;" class="a_gret" onclick="addNotes();"><ingenta-tag:LanguageTag sessionKey="lang"
												key="Pages.view.note.button" /></a>
									</p>
								</div>
							</li>
						</ul></li>
				</c:if>
				<c:if test="${form.readCount !=null && form.readCount>0}">
					<li><a><span class="alph"><img src="${ctx }/images/black_ico/ico_03.png" style="margin-top:13px; margin-left:-18px;" /></span>
							<span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Copy" /></span></a>
						<ul class="tag">
							<li>
								<div>
									<p class="book_b">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.copy.Prompt" />
										：${form.readCount }
									</p>
									<p class="book_b" id="copyCount">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Content.View.now.copy.page" />
										：${copyCount}
									</p>
									<p id="copy_but" class="book_a">
										<a id="btn_copy" class="a_gret" onclick="copy()" style="margin-right: 4px;"> <ingenta-tag:LanguageTag sessionKey="lang"
												key="Pages.view.copy.Button" />
										</a>
									</p>
								</div>
							</li>
						</ul></li>
				</c:if>
				<%-- 下载功能 START --%>
				<c:if test="${form.downloadCount !=null && form.downloadCount>0}">
					<li><a><span class="alph"><img src="${ctx }/images/black_ico/ico_05.png" style="margin-top:13px; margin-left:-18px;" /></span>
							<span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Download" /></span></a>
						<ul class="tag">
							<li>
								<div>
									<%-- 屏蔽之前的打印功能 hengrun.yuan --%>
									<%--
											<p class="book_b">
												<ingenta-tag:LanguageTag sessionKey="lang"
													key="Pages.view.download.Prompt" />
												：${form.downloadCount }
											</p>
											<p class="book_b" id="downloadCount">
												<ingenta-tag:LanguageTag sessionKey="lang"
													key="Content.View.now.download.page" />
												：${downloadCount}
											</p>
											 <p id="copy_but" class="book_a">
												<a class="a_gret" onclick="downloadaaaaa()" id="bbbbb">
													<ingenta-tag:LanguageTag sessionKey="lang"
														key="Global.Button.DownLoad" />
												</a>
												<c:if test="${pubType==4 && downloadPrecent==100}">
													<a class="a_gret"
														href="${ctx}/pages/view/png/form/download?pubId=${form.id}&isFull=true"
														id="downFull"> <ingenta-tag:LanguageTag
															sessionKey="lang" key="Pages.View.Button.DownLoad.Full" />
													</a>
												</c:if>
											</p> --%>
									<p class="book_b">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.download.Prompt" />
										：${form.downloadCount}
									</p>
									<p class="book_b" id="downloadCount">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Content.View.now.download.page" />
										：${downloadCount}
									</p>
									<p id="copy_but" class="book_a">
									<!-- 2015-09-24 增加是否连续下载设置 1-允许连续打印 2-不允许连续打印 0-默认值 By ruixue.cheng Start -->
									<c:choose>
										<c:when test="${pubType==4 && downloadPrecent==100 || pubType==7 }">
											<p class="book_b">
													<a class="a_gret" style="color: white;" href="#" onclick="Javascript:downloadFullPage('${form.id }');" id="downFull"> 
														<ingenta-tag:LanguageTag sessionKey="lang" key="Pages.View.Button.DownLoad.Full" />
													</a>
											</p>
										</c:when>
										<c:otherwise>
											<c:if test="${form.continuousPrint==2||form.continuousPrint==0}">
											<a class="a_gret" onclick="downloadaaaaa()" id="bbbbb"> 
												<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.DownLoad" />
											</a>
											</c:if>
											<p>
											<c:if test="${form.continuousPrint==1}">
												<input class="a_input" type="text" id="downloadStr" />
												<a style="cursor: pointer;" class="a_cxu" onclick="continuousDownload()" id="bt_download"> 
													<ingenta-tag:LanguageTag sessionKey="lang" key="Global.Button.DownLoad" />
												</a>
											</c:if>
											</p>
										</c:otherwise>
									</c:choose>										
									<!-- 2015-09-24 增加是否连续下载设置 1-允许连续打印 2-不允许连续打印 0-默认值 By ruixue.cheng End -->
									</p>
								</div>
							</li>
						</ul></li>
				</c:if>
				<%-- 下载功能 END --%>
				<c:if test="${form.printCount !=null && form.printCount>0}">
					<li><a><span class="alph"><img src="${ctx }/images/black_ico/ico_06.png" style="margin-top:13px; margin-left:-18px;" /></span>
							<span class="write"><ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.Label.Print" /></span></a>
						<ul class="tag">
							<li>
								<div>
									<p class="book_b">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Pages.view.print.Prompt" />
										：${form.printCount }
									</p>
									<p class="book_b" id="printCount">
										<ingenta-tag:LanguageTag sessionKey="lang" key="Content.View.now.print.page" />
										：${printCount}
									</p>
									<p>
										<input class="a_input" type="text" id="printStr" /> <a class="a_cxu" onclick="ajaxPrint()" id="bt_print"> <ingenta-tag:LanguageTag
												sessionKey="lang" key="Pages.view.Label.Print" />
										</a>
									</p>
								</div>
							</li>
						</ul></li>
				</c:if>
			</ul>
		</div>


		<!-- 主阅读器 -->
		<div class="flexCont" style="height: 100%;">

			<div id="documentViewer" class="flexpaper_viewer" style="width:100%; height:996px; "></div>

			<!--以下中间内容块开始-->
			<div class="big" style="display: none">
				<script type="text/javascript">

					function getDocumentUrl(document){
						var numPages = ${form.count};
						//当前浏览页码
						var url = "" ; 
						var pageNum = "${form.pageEnableNum}" ; 
						if(pageNum && 0!=pageNum){
							//Probation Model
							url = "${ctx}/pages/view/png/form/page?probation=probation&pubId={doc}&pageNum={page}";
						}else{
							//Common Model
							url = "${ctx}/pages/view/png/form/page?pubId={doc}&pageNum={page}" ; 
						}
						url = url.replace("{doc}",document);
						url = url.replace("{numPages}",numPages);
						
						return url;
					}
					
					//推荐
					function recommend() {
						art.dialog.open("${ctx}/pages/recommend/form/edit?pubid="+$('#pubId11').val(),{title:"<ingenta-tag:LanguageTag key="Page.Pop.Title.Recommend" sessionKey="lang"/>",top: 100,width: 550, height: 450,lock:true});
					} 
					
					function getDocQueryServiceUrl(document){
						return "swfsize.jsp?doc={doc}&page={page}".replace("{doc}",document);
					}
					var startDocument = "";
		
					function append_log(msg){
						$('#txt_eventlog').val(msg+'\n'+$('#txt_eventlog').val());
					}
		
					String.format = function() {
						var s = arguments[0];
						for (var i = 0; i < arguments.length - 1; i++) {
							var reg = new RegExp("\\{" + i + "\\}", "gm");
							s = s.replace(reg, arguments[i + 1]);
						}
						return s;
					};
		
					 var startDocument = "Paper";
					
					jQuery.get(
                            (!window.isTouchScreen) ? '${ctx}/pages/UI_flexpaper_desktop.html'
                                    : '${ctx}/pages/UI_flexpaper_mobile.html',
                            function(toolbarData) {
                                jQuery('#documentViewer')
                                        .FlexPaperViewer(
                                                {
                                                    config : {
                                                        IMGFiles 				: getDocumentUrl('${form.id}'),
                                                       	JSONFile 				: "${ctx}/pages/view/png/form/json?pubId=${form.id}",
                                                        Scale                   : 1.0, 
                                                        ZoomTransition          : 'easeOut',
                                                        ZoomTime                : 0.5,
                                                        ZoomInterval            : 0.2,
                                                        FitPageOnLoad           : false, 
                                                        FitWidthOnLoad          : false, 
                                                        ProgressiveLoading      : false,
                                                        MinZoomSize             : 0.2,
                                                        MaxZoomSize             : 5,
                                                        SearchMatchAll          : false,
                                                        FullScreenAsMaxWindow   : false,

                                                        //Toolbar                 : '',  
                                                        BottomToolbar           : '',
                                                        InitViewMode            : 'Portrait',
                                                        RenderingOrder          : 'html',
                                                        StartAtPage             : '',

                                                        ViewModeToolsVisible    : true,
                                                        ZoomToolsVisible        : true,
                                                        NavToolsVisible         : true,
                                                        CursorToolsVisible      : true,
                                                        SearchToolsVisible      : false,
                                                        EnableSearchAbstracts   : false,
                                                        localeChain             : '${sessionScope.lang}',
                                                        WMode : 'transparent', 
                                                        key : "@4516c44a3b7f5ec2893$cc3be1a9ff661cfdef6"
                                                    }
                                                });
                                
                                
                            }); 
					
						//判断当前的页面是否可以进行拷贝
					  <c:if test="${form.pageEnableNum eq 0}">
						  jQuery('#documentViewer').bind('onCurrentPageChanged',function(e,pagenum){
							  var select_style = $('.flexpaper_bttnTextSelect').css("display")=="none"?true:false;
							  var copy_style = $("#btn_copy").css("display")=="none"?true:false;
							  // 移除复制div按钮
							  $('#tooltip').length > 0 && $('#tooltip').remove();
							  $.ajax({
									type : "POST",  
							        url: "${ctx}/pages/view/png/form/tocCopy",
							        data: {
							        	pubId:$("#pubId11").val(),
							           	pageNum:pagenum ,
							           	licenseId:$("#licenseId11").val(),
							           	count:$("#pageCount11").val(),
							           	readCount:$("#readCount11").val(),
							        	isCopy:true,
							        	readCount:'${form.readCount}',
										r_ : new Date().getTime(),
										tag : "query"
							        },
							        success : function(data) {
							          var s = eval(data);
							          if(s[0].isCopy=='true' && s[0].flag=='true'){   
							          		  $('.flexpaper_bttnTextSelect').removeAttr('style');
								        	  $('.flexpaper_bttnTextSelect').addClass('flexpaper_tbbutton_pressed');
								        	  $('.flexpaper_bttnTextSelect').click();
								        	  $("#btn_copy").css("display","none");
								        	 copyToClip(pagenum);
							          } else{
							        	 // $('.flexpaper_bttnTextSelect').addClass('flexpaper_tbbutton_disabled');
							        	  $('.flexpaper_bttnHand').addClass('flexpaper_tbbutton_pressed');
							        	  $('.flexpaper_bttnTextSelect').removeClass('flexpaper_tbbutton_pressed');
							        	  $FlexPaper('documentViewer').setCurrentCursor("ArrowCursor");
							        	  $('.flexpaper_bttnTextSelect').css("display","none");
							        	  $("#btn_copy").css("display","inline");
							          } 
							       	  $("#copyCount").html("<ingenta-tag:LanguageTag sessionKey='lang' key='Content.View.now.copy.page'/>："+s[0].copyCount);
							        },  
							        error : function(data) {  
							        	
							        }  
								}); 
							  
							
						  });  
					  </c:if>
					  <c:if test="${form.pageEnableNum ne 0}">
						 // 试读最后一页判断
						 jQuery('#documentViewer').bind('onCurrentPageChanged',function(e,pagenum){
							 if(tryReadingFlag && $("#pageEnableNum").val() == pagenum){
							  	  document.getElementById("pageContainer_"+(pagenum-1)+"_documentViewer").onmouseup = function(e){
							  	  	recommend();
							  	  }
							  }
						 });
					  </c:if>
						
				</script>
				<!--右侧内容结束 -->
			</div>
			<!--以上中间内容块结束-->
			<!--以下 提交查询Form 开始-->
			<form:form action="${form.url}" method="post" modelAttribute="form" commandName="form" name="formList" id="formList">
				<form:hidden path="searchsType" id="type1" />
				<form:hidden path="searchValue" id="searchValue1" />
				<form:hidden path="pubType" id="pubType1" />
				<form:hidden path="language" id="language1" />
				<form:hidden path="publisher" id="publisher1" />
				<form:hidden path="pubDate" id="pubDate1" />
				<form:hidden path="taxonomy" id="taxonomy1" />
				<form:hidden path="taxonomyEn" id="taxonomyEn1" />
				<form:hidden path="searchOrder" id="order1" />
				<form:hidden path="lcense" id="lcense1" />

				<form:hidden path="code" id="code1" />
				<form:hidden path="pCode" id="pCode1" />
				<form:hidden path="publisherId" id="publisherId1" />
				<form:hidden path="subParentId" id="subParentId1" />
				<form:hidden path="parentTaxonomy" id="parentTaxonomy1" />
				<form:hidden path="parentTaxonomyEn" id="parentTaxonomyEn1" />
			</form:form>
			<!--以上 提交查询Form 结束-->
			<input type="hidden" id="pubId11" value="${form.id }" /> <input type="hidden" id="licenseId11" value="${form.licenseId }" /> <input
				type="hidden" id="pageCount11" value="${form.count }" /> <input type="hidden" id="readCount11" value="${form.readCount }" /> <input
				type="hidden" id="isCopy11" value="${form.isCopy }" /><input
				type="hidden" id="pageEnableNum" value="${form.pageEnableNum }" />
		</div>

		</div>
	</c:if>
</body>
</html>