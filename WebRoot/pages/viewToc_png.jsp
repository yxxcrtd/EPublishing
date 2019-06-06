<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:if test="${tocList!=null }">
	<c:forEach items="${tocList }" var="p" varStatus="index">
		<c:if test="${pubFileType==null || pubFileType!=2 }">
		<%-- <li><a href="${ctx }/pages/view/form/view?id=${publicationsId}&curpage=${p.pubPageStartString }" title="${p.pubTitle }">${p.pubTitle }</a></li> --%>
		<c:if test="${p.startPage>0}">
			<c:choose>
			 	<c:when test="${not empty pageEnableNum && p.startPage > pageEnableNum }">
					<li class=" ${p.fullText}" style="margin-left:${p.browsePrecent}px;"><span >${p.title }</span></li>
			 	</c:when>
			 	<c:otherwise>
					<li class=" ${p.fullText}" style="margin-left:${p.browsePrecent}px;color:#258FD4;"><a href="javascript:void(0)" onclick="$FlexPaper('documentViewer').gotoPage(${p.startPage==null?1:p.startPage})" title="${p.title }">${p.title }</a></li>
			 	</c:otherwise>			 
			 </c:choose>
		</c:if>
		<c:if test="${p.startPage<=0}">
			<li class=" ${p.fullText}" style="margin-left:${p.browsePrecent}px"><a style="margin-left:${p.browsePrecent}px;color: #000000;" class="${p.fullText}" href="javascript:void(0)" title="${p.title }">${p.title }</a></li>
		</c:if>
		</c:if>
		<c:if test="${pubFileType==2 }">
		 <li style="margin-left:${p.browsePrecent}px" class=" ${p.fullText}" ><a href="javascript:void(0)" onclick="turning(${p.startPage==null?1:p.startPage})" title="${p.title }">${p.title }</a></li>
		</c:if>
	</c:forEach>
</c:if>
