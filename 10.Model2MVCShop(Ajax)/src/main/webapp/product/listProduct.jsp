<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
<%@ page import="java.util.List"  %>

<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	String menu = (String)request.getParameter("menu");

	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%> 	/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>


<html>

<head>
	<meta charset="EUC-KR">
	<title>상품 목록조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용
	
	function fncGetUserList(currentPage) {
			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
		   	//document.detailForm.submit();
			$("form").attr("method" , "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
		}
	//==========================================================//
   	//==> 추가된부분 : "검색" ,  prodName link  Event 연결 및 처리
   	
	$(function (){
			
	      //==> 검색 Event 연결처리부분
	      //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	      //==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			$("td.ct_btn01:contains('검색')").on("click", function(){
		    //Debug..
		    //alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetUserList(1);	
			
			});
	
 	//==================이거 왜 안돼지?여길 건들고나서 상품명, 클릭해서 상세정보나 수정창으로 안들어 가진다========================================//
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
    //==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
 		$(".ct_list_pop td:nth-child(3)").on("click", function(){
 			//이걸 왜 해야줘야 하나?
 			var prodNo = $(this).data("param");
            //Debug..
            //alert(  $( this ).text().trim() );
            if(${param.menu == 'manage'}) {
            	self.location = "/product/updateProduct?prodNo="+prodNo+"&menu=manage";
            }else {
            	$.ajax(
            			{
            			<!-- self.location = "/product/getProduct?prodNo="+prodNo+"&menu=search";-->
            				url: "/product/json/getProduct/"+prodNo,
            				method : "GET" ,
            				dataType : "json" ,
            				headers : {
            					"Accept" : "application/json" ,
            					"Content-Type" : "application/json"
            				},
            				success : function(JSONData , status ) {
            					
            					<!--alert(JSONData.prodNo); -->
            					
								//Debug...
								//alert(status);
								//Debug...
								//alert("JSONData : \n"+JSONData);
            					
								var displayValue = "<h3>"
															+"상품번호 : "+JSONData.prodNo+"<br/>"
															+"상품이름 : "+JSONData.prodName+"<br/>"
															+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
															+"상품제조일자 : "+JSONData.manuDate+"<br/>"
															+"상품가격 : "+JSONData.price+"<br/>"
															+"상품이미지 : "+JSONData.fileName+"<br/>"
															+"상품등록일자 : "+JSONData.regDate+"<br/>"
															+"</h3>" ;
								
								//Debug...									
								//alert(displayValue);							
								$("h3").remove();
								$( "#"+prodNo+"" ).html(displayValue);
																
            				}
            			});
////////////////////////////////////////////////////////////////////////////////////////////
            }
 		});	
    
 	//==========================================================//
	  //==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
      $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
      $("h7").css("color" , "red");
 	
 	
 	      //==> 아래와 같이 정의한 이유는 ??
 	      //==> 아래의 주석을 하나씩 풀어 가며 이해하세요.               
 	      $(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
 	      //console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
 	      //console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
 	      //console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
 	      //console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
 	      //console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
 	      console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
 	      //console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
 	   });  
 		
 		
	      
	
	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!--  <form name="detailForm" action="/product/listProduct?menu=${param.menu}" method="post">
	  jQuery로 작성 해놨음 위에 -->
<form name="detailForm">







<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
		<%-- 		
				<%
					if(menu.equals("search")){
				%>
				
					<td width="93%" class="ct_ttl01">상품 목록조회</td>
					
				<%
						} else{
								%>
				
					<td width="93%" class="ct_ttl01">상품 관리</td>
				
				<%
					}
				%>
		--%>
				
			 <c:choose>	 
				 <c:when test="${param.menu eq 'manage'}">
			            상품 관리
			     </c:when>
			     <c:when test="${param.menu eq 'search'}">
			            상품 목록조회
		         </c:when>
		      </c:choose>

				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>




<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
		<%--	<option value="0" <%= (searchCondition.equals("0") ? "selected" : " ")%>>상품번호</option>
				<option value="1" <%= (searchCondition.equals("1") ? "selected" : " ")%>>상품명</option>
				<option value="2" <%= (searchCondition.equals("2") ? "selected" : " ")%>>상품가격</option>
		--%>
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : " " }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : " " }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : " " }>상품가격</option>
			</select>
			<input 	type="text" name="searchKeyword" 
							value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
							class="ct_input_g" 
							style="width:200px; height:20px" >
		</td>
		
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!--  <a href="javascript:fncGetUserList('1');">검색</a> -->
						<!-- 이부분은 fncGetUserList('1');">검색 이걸로해야 검색이됨 product로 바꾸면 안됨
							 위의 부분에 fnc 부분과 연동 -->
 						검색
					</td>
					
					
					
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>









<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			<%-- 전체  <%= resultPage.getTotalCount() %> 건수,	현재 <%= resultPage.getCurrentPage() %> 페이지--%>
				 전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">등록일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">현재상태</td>
		<td class="ct_line02"></td>
	
	</tr>
	
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<%-- 
	<%
		for(int i=0; i<list.size(); i++) {
			Product product = list.get(i);
	%>
	
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
		
		<% 	if(menu.equals("search")){%>
		
			<a href="/product/getProduct?prodNo=<%=product.getProdNo() %>"><%=product.getProdName() %></a>
		
			<%} else{%>
			
			<a href="/product/updateProduct?prodNo=<%=product.getProdNo() %>"><%=product.getProdName() %></a>
		
		<%}%>
		

		</td>
		<td></td>
		<td align="left"><%=product.getPrice() %></td>
		<td></td>
		<td align="left"><%=product.getRegDate() %>	</td>
		<td></td>
		<td align="left">배송중</td>
		<td></td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
</table>

	--%>
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			
		<td align="left" data-param="${ product.prodNo }">
			
			${ product.prodName }
		
		<!--<c:choose>
		
			<c:when test="${param.menu eq 'manage'}">

					
			<a href="/product/updateProduct?prodNo=${product.prodNo}">${product.prodName}</a>
			</c:when>
			<c:otherwise>
			<a href="/product/getProduct?prodNo=${product.prodNo}">${product.prodName}</a>

			</c:otherwise>

		</c:choose>
		-->
		
		</td>
		
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
		<td align="left">판매중</td>
	</tr>
		
		<tr>
		<td id="${ product.prodNo }" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>



<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%-- 
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
		--%>
		
		<jsp:include page="../common/pageNavigator.jsp"/>	
		
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->



</form>
</div>

</body>
</html>