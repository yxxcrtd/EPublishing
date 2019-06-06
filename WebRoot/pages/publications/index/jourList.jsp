<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/tools.jsp"%>
<div class="oh h490">
	<h1 class="h1Tit borBot">
		<a class="ico1"><ingenta-tag:LanguageTag sessionKey="lang" key="Global.Label.New_Resources" /></a>
	</h1>
	<div class="featureContainer">
		<div class="feature">
			<div class="black h450">
				<div id="botton-scroll2">
					<ul class=featureUL>
		                    <c:forEach items="${list}" var="p" varStatus="index">
		                    <c:if test="${index.index % 8==0}"><li class=featureBox><div class="oh"></c:if>
			                     <div class="bookBlock" style="height:200px;">
			                     	<c:if test="${p.cover!=null&&p.cover!='' }">
				                     	<a href="${ctx}/pages/publications/form/article/${p.id}">
											<img src="${ctx}/pages/publications/form/cover?t=1&id=${p.id}" width="95" height="130"/>
										</a>
			                     	</c:if>
			                     	<c:if test="${p.cover==null||p.cover=='' }">
			                     		<a href="${ctx}/pages/publications/form/article/${p.id}">
			                     		<div class="imgMoren">
			                     			<p>
			                     			<c:choose>
			                     				<c:when test="${fn:length(p.title)>9}">
			                     					${fn:substring(p.title,0,9)}...
			                     				</c:when>
			                     				<c:otherwise>
			                     					${p.title}
			                     				</c:otherwise>
			                     			</c:choose>
											</p>
										</div>
										</a>
			                     	</c:if>
									<p class="bookTit">
										<a class="a_title" title="${(p.title)}" href="${ctx}/pages/publications/form/article/${p.id}">
											<c:choose>
			                     				<c:when test="${fn:length(p.title)>9}">
			                     					${fn:substring(p.title,0,9)}...
			                     				</c:when>
			                     				<c:otherwise>
			                     					${p.title}
			                     				</c:otherwise>
			                     			</c:choose>
										</a>
									</p>
								</div>
								<c:if test="${index.index!=0 && (index.index+1) % 8==0}"></div></li></c:if>
	                  		</c:forEach>
					</ul>
				</div>
			</div>
			<a class=prev2 href="javascript:;">Previous</a>
			<a class="next2" href="javascript:;">Next</a>
		</div>
	</div>
</div>