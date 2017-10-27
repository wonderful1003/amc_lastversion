<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page contentType="text/html; charset=EUC-KR" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
            <html>

            <head>
                <meta charset="EUC-KR">
            	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	
	
	
	

                <script type="text/javascript">
                    function fncGetPageList(currentPage) {
                        $("#currentPage").val(currentPage)
                        $("form").attr("method", "POST").attr("action", "/screen/getScreenList").submit();
                    }


                    $(function() {
                        //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                        $("button.btn.btn-default").on("click", function() {
                            fncGetPageList(1);
                        });

                    });
                </script>

                <style>
                    body {
                        padding-top: 70px;
                    }

                    .thumbnail {
                        width: 300px;
                        height: 250px;
                        overflow: auto;
                    }

                 
                </style>

            </head>

            <body>

                <jsp:include page="/layout/topToolbar.jsp" />


                <div class="container">
                    <div class="page-header text-info">
                        <h3>상영 관리</h3>
                    </div>


                    <div class="row">
                        <div class="col-md-6 text-left">
                            <p> 전체 ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage } 페이지</p>
                        </div>

                        <div class="col-md-6 text-right">
                            <form class="form-inline" name="detailForm">

                                <div class="form-group">
                                    <select class="form-control" name="searchCondition">
						<!-- <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>   -->
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>영화제목</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>감독</option>
					</select>
                                </div>

                                <div class="form-group">
                                    <label class="sr-only" for="searchKeyword">검색어</label>
                                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                                </div>

                                <button type="button" class="btn btn-default">검색</button>

                                <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                                <input type="hidden" id="currentPage" name="currentPage" value="" />

                            </form>
                        </div>
                    </div>
                    <div>
                    </div>
                    <br>


                    <div>
                        <div class="row">

                            <c:set var="i" value="0" />
                            <c:forEach var="screen" items="${list }">
                                <c:set var="i" value="${i+1 }" />
                                <div class="col-xs-6 col-md-4" name="screenThumbnail">
                                    <a class='thumbnail' href="/screen/getScreenContentList/${screen.movieNo}" style="text-decoration:none;">
						 
							<img src="${screen.postUrl }"  >
							<br>
							<span><strong>${screen.movieNm }</strong></span>
							
							<span><li>개봉일 : ${screen.openDt }</li></span>
							<span><li>상영마감일 : ${screen.endDt }</li></span>
						</a>
                                </div>

                            </c:forEach>

                        </div>

                    </div>



                </div>
                <jsp:include page="../common/pageNavigator.jsp" />

            </body>

            </html>