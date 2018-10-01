<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/layout/app.jsp">
	<c:param name="content">
		<c:choose>
			<c:when test="${diary != null}">
				<h2>日誌 詳細ページ</h2>

				<table>
					<tbody>
						<tr>
							<th>氏名</th>
							<td><c:out value="${diary.employee.name}" /></td>
						</tr>
						<tr>
							<th>日付</th>
							<td><fmt:formatDate value='${diary.diary_date}'
									pattern='yyyy-MM-dd' /></td>
						</tr>
						<tr>
							<th>作業内容</th>
							<td><pre>
									<c:out value="${diary.content}" />
								</pre></td>
						</tr>
						<tr>
							<th>使用した農薬・肥料など</th>
							<td><pre>
									<c:out value="${diary.fixtures }" />
								</pre></td>
						</tr>


						<c:forEach var="picture" items="${pictures }" >
						<tr>
						<th>ファイル名</th>
						<td><c:out value="${picture.name }" />
						</td>
						</tr>


                        <tr>
                            <th>登録画像</th>
                            <td><img style="width: 300px; height: 300px" src= "<c:url value='/loadImage' />?id=${picture.diary.id }"/></td>
                        </tr>
                        </c:forEach>




						<tr>
							<th>登録日時</th>
							<td><fmt:formatDate value="${diary.created_at}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
						<tr>
							<th>更新日時</th>
							<td><fmt:formatDate value="${diary.updated_at}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
					</tbody>
				</table>

				<c:if test="${sessionScope.login_employee.id == diary.employee.id}">
					<p>
						<a href="<c:url value='/diaries/edit?id=${diary.id}' />">この日報を編集する</a>
					</p>
				</c:if>
			</c:when>
			<c:otherwise>
				<h2>お探しのデータは見つかりませんでした。</h2>
			</c:otherwise>
		</c:choose>

		<p>
			<a href="<c:url value='/diaries/index' />">一覧に戻る</a>
		</p>
	</c:param>

</c:import>