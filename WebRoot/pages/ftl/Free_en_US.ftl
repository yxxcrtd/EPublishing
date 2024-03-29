		<h1 class="indexHtit">
             <span class="fl titFb"><a class="ico1" >Free Resources</a></span>
             <span class="fr"><a href="#" onclick="toFreeList()">more >></a></span>
        </h1>
		<#if (pubList?? && 0 < pubList?size)>
		<#list pubList as p>
				<div class="block">
	               	<div class="fl w22 mt2">
	                    <#if (p.type==1)><img width="13" height="13" src="${request.contextPath}/images/ico/ico4.png" title="Book" /></#if>
						<#if (p.type==4 || p.type==3)><img width="13" height="13" src="${request.contextPath}/images/ico/ico5.png" /></#if>
						<#if (p.type==2)><img width="13" height="13" src="${request.contextPath}/images/ico/ico3.png" /></#if>
	               	</div>
                    <div class="fl w640">
	                    <p>
		                    <a class="a_title" title="${p.title}" href="${request.contextPath}/pages/publications/form/article/${p.id}">
		                        ${p.title?replace("&lt;","<")?replace("&gt;",">")?replace("&amp;","&")}
		                	</a>
	                	</p>
				<#if (p.author??)>
					<p>By 
					<#list p.author?split(",") as x>
					<a href='${request.contextPath}/index/search?type=2&isAccurate=1&searchValue="${x}"'>${x}</a>&nbsp;
					</#list>
				</#if>
				<p>
				    <#if (p.publisher??)>
				    <a href='${request.contextPath}/index/search?type=2&isAccurate=1&searchValue="${p.publisher.name }"'>${p.publisher.name }</a>
				    </#if>
					<#if (p.pubDate??)>(${p.pubDate?substring(0,4)})</#if>
				</p>
				<#if (p.type==2 && p.startVolume?? && p.endVolume??)>
				<p>
				vol. ${p.startVolume }-vol. ${p.endVolume }
				</p>
				</#if>
			</div>
                </div>
		</#list>
		</#if >