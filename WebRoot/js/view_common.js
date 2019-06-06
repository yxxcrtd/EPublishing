var view_flag = null ; 
var viewerObj_str = null ;
$(function(){
    view_flag = $('#viewFlag').val() == "png" ? "png" : "swf" ; 
    viewerObj_str = view_flag == "png"  ? "$FlexPaper('documentViewer')." :  "getDocViewer()." ; 
});

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
	            	pageNum:eval(viewerObj_str + "getCurrPage()"),
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
				   	  +'<a style=\"margin: 0px;padding: 0px; border-bottom: none;background:none;\" onclick=\"'+viewerObj_str+'gotoPage(\''+ curNum +'\')\" >'+curNum+'__'+content+'</a></span><span>'
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