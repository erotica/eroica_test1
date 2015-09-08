<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %> 
<html>
<head>
<style type="text/css">
	#textarea333{border-top: 1px solid #BACDCB; border-bottom: 1px solid #BACDCB; padding: 1px 4px 1px 4px; width:95px; height:55px;}
</style>
<script type="text/javascript">
/////////////////////////////////////////////////////////////////////////////////// 
//rowspan 생성 스크립트
//tableId :  table id를 넣자 
//rowIndex : table의 시작 row index(0부터 시작)
//cellIndex : 해당 row의 cell index(0부터 시작)
///////////////////////////////////////////////////////////////////////////////////
//조회   

function date_add(sDate, nDays) {
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(4, 2), 10);
    var dd = parseInt(sDate.substr(6,2), 10);
  
    d = new Date(yy, mm - 1, dd + nDays);
 
    yy = d.getFullYear();
    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
 
    return '' + yy +   mm  +  dd;    
}
 
function date_minus(sDate, nDays) {
    var yy = parseInt(sDate.substr(0, 4), 10);
    var mm = parseInt(sDate.substr(4, 2), 10);
    var dd = parseInt(sDate.substr(6,2), 10);
    
    d = new Date(yy, mm - 1, dd - nDays);
 
    yy = d.getFullYear();
    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
 
    return '' + yy +   mm  +  dd;	
    }
function fn_prevdate()
	{
		var searchYear = document.getElementById("year").value;
	    var searchMonth = document.getElementById("month").value;
	    var searchDay   = document.getElementById("day").value;
  	
  	    var fromdate = searchYear + searchMonth +  searchDay;
  		var todate = date_add(fromdate,4);
  		
  		searchYear = todate.substr(0,4);
  		searchMonth = todate.substr(4,2);  
  		searchDay = todate.substr(6,2);
  	 
  		fn_search(searchYear,searchMonth,searchDay,todate,fromdate)
        
       // var today = new Date();
  	   // var year=today.getFullYear();
	//	var month=today.getMonth()+1;
	//	var day=today.getDate();
	 //   var comptodate= year.toString() + month.toString() +  day.toString();
	  //  var todate = date_add(fromdate,4);
  	//	if (todate == comptodate) {
  	//		todate = date_add(fromdate,7);
  	//	}
  		
	}
function fn_nextdatexxx()
	{
		var searchYear = document.getElementById("year").value;
	    var searchMonth = document.getElementById("month").value;
	    var searchDay   = document.getElementById("day").value;
  	
  		var date1 = searchYear + searchMonth +  searchDay;
  		var todate = date_minus(date1,4);
  		var fromdate = date_minus(todate,4);
  		  		 
  		searchYear = todate.substr(0,4);
  		searchMonth = todate.substr(4,2);  
  		searchDay = todate.substr(6,2);
  	
  		fn_search(searchYear,searchMonth,searchDay,todate,fromdate)
	}
	
function fn_nextdate()
	{
		var searchYear = document.getElementById("year").value;
	    var searchMonth = document.getElementById("month").value;
	    var searchDay   = document.getElementById("day").value;
  	
  		var date1 = searchYear + searchMonth +  searchDay;
  		var todate = date_minus(date1,4);
  		var fromdate = date_minus(todate,4);
  		  		 
  		searchYear = todate.substr(0,4);
  		searchMonth = todate.substr(4,2);  
  		searchDay = todate.substr(6,2);
  	
  		fn_search(searchYear,searchMonth,searchDay,todate,fromdate)
	}

function fn_search(searchYear,searchMonth,searchDay,todate,fromdate){
	 
	 //var searchYear = document.getElementById("year").value;
	// var searchMonth = document.getElementById("month").value;
	// var searchDay   = document.getElementById("day").value;
	// var searchDept  = document.getElementById("dept").value;
	 
	 var host= "<%= request.getHeader("host") %>";
	
     location.href = "http://"+host+"/mis/selectWorkList.bf?searchYear="+searchYear+"&searchMonth="+searchMonth+"&searchDay="+searchDay+"&todate="+todate+"&fromdate="+fromdate;
	
 }   
 
 function selectEvent(selectObj) {
 
   		var searchYear = document.getElementById("year").value;
	    var searchMonth = document.getElementById("month").value;
	    var searchDay   = document.getElementById("day").value;
  	
  	    var todate = searchYear + searchMonth +  searchDay;
  		var fromdate = date_minus(todate,4);
  	
  		searchYear = todate.substr(0,4);
  		searchMonth = todate.substr(4,2);  
  		searchDay = todate.substr(6,2);
  	
  		fn_search(searchYear,searchMonth,searchDay,todate,fromdate) ;           
                
                
 
 }

function cellMergeChk(tableObj, rowIndex, cellIndex)
{
	var rowsCn = tableObj.rows.length;
	
	if(rowsCn-1 > rowIndex)
		cellMergeProcess(tableObj, rowIndex, cellIndex);
}
	
	function cellMergeProcess(tableObj, rowIndex, cellIndex)
	{
		var rowsCn = tableObj.rows.length;
		var compareCellsLen = tableObj.rows(rowIndex).cells.length;		//시작 row에 cell 개수
		
		//초기화	
		var compareObj = tableObj.rows(rowIndex).cells(cellIndex);
		var compareValue = compareObj.innerHTML;
		var cn = 1;
		var delCells = new Array();
		var arrCellIndex = new Array();
		//for(i=rowIndex+1; i < rowsCn; i++)
		for(i=rowIndex+1; i < rowsCn-1; i++)//해당 테이블rows만큼 작업을해야하지만 맨마지막 row는 총인원으로 colspan을 하므로 제외시키기위해서 -1을 해준다.
		{
			var cellsLen = tableObj.rows(i).cells.length;
			var bufCellIndex = cellIndex

			//실질적인 row에 cellIndex를 구하자.			
			if(compareCellsLen != cellsLen) 
			{
				bufCellIndex = bufCellIndex - (compareCellsLen - cellsLen);
			}
			cellObj = tableObj.rows(i).cells(bufCellIndex);
			
			if(compareValue == cellObj.innerHTML)
			{
				delCells[cn-1] = tableObj.rows(i);		//삭제할 cell의 row를 저장한다.
				arrCellIndex[cn - 1] = bufCellIndex;	//해당 row cell index를 저장한다.
				cn++;
			}
			else
			{
				//병합
				compareObj.rowSpan = cn;
				
				//삭제
				for(j=0; j < delCells.length; j++)
				{
					delCells[j].deleteCell(arrCellIndex[j]);
				}
				
				//초기화	
				compareObj = cellObj;
				compareValue = cellObj.innerHTML;
				cn = 1;
				delCells = new Array();
				arrCellIndex = new Array();
			}
		}

		//병합		
		compareObj.rowSpan = cn;
		//삭제
		for(j=0; j < delCells.length; j++)
		{
			delCells[j].deleteCell(arrCellIndex[j]);
		}
	}
	function init()
	{	//구분에 사무직 현장직은 동일한 값을 가져오므로 하나로 합쳐줌[동적 rowspan처리]
		cellMergeChk(document.all.tblGalInfo, 1, 0);//첫번째 td 처리
	}

	function lfViewPopup(pCdDept,dtReg) {
		var objPop = window.open("<c:url value='/mis/selectWorkAppv.bf?CD_DEPT="+encodeURIComponent(pCdDept)+"&DT_REG="+encodeURIComponent(dtReg)+" '/>", "workAppv", 'top=100px, left=100px, height=900px, width=820px, scrollbars=yes, resizable=yes');
	    objPop.focus();
	}

</script>
<title>부서별 일일 업무 보고</title>
		<meta http-equiv="Content-Language" content="ko">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../css/kal_css.css" type="text/css" rel="stylesheet">
	</HEAD>
	<BODY>
			<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" CLASS="DocTitle">
		<TR>
			<TD CLASS="DocTitle">&nbsp;일일업무</TD>
			<TD VALIGN="BOTTOM" CLASS="R">
				<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" width="100%">
					<TR>
						<TD id="tr_SearchCOMM"  CLASS="sch"  style="text-align:right;">
							<%--<c:out value="${baseYm}"/>--%>
						</TD>
					</TR>
				</TABLE>
			</TD>
			<td align=right>
		
			<select id="year">
			
				<c:forEach var="result" items="${yearList}" varStatus="i">
					<option value='<c:out value="${result.year}"/>'
					<c:if test="${result.year==curYear}">
						selected="selected"
					</c:if>
					>
						<c:out value="${result.year}"/>
					</option>	
		    	</c:forEach>
			</select>년
			<select id="month">
				<option value='01' 
				<c:if test="${curMonth=='01'}">
					selected="selected"
				</c:if>
				>01</option>
				<option value='02'
				<c:if test="${curMonth=='02'}">
					selected="selected"
				</c:if>
				>02</option>
				<option value='03'
				<c:if test="${curMonth=='03'}">
					selected="selected"
				</c:if>
				>03</option>
				<option value='04'
				<c:if test="${curMonth=='04'}">
					selected="selected"
				</c:if>
				>04</option>	
				<option value='05'
				<c:if test="${curMonth=='05'}">
					selected="selected"
				</c:if>
				>05</option>	
				<option value='06'
				<c:if test="${curMonth=='06'}">
					selected="selected"
				</c:if>
				>06</option>
				<option value='07'
				<c:if test="${curMonth=='07'}">
					selected="selected"
				</c:if>
				>07</option>
				<option value='08'
				<c:if test="${curMonth=='08'}">
					selected="selected"
				</c:if>
				>08</option>
				<option value='09'
				<c:if test="${curMonth=='09'}">
					selected="selected"
				</c:if>
				>09</option>
				<option value='10'
				<c:if test="${curMonth=='10'}">
					selected="selected"
				</c:if>
				>10</option>
				<option value='11'
				<c:if test="${curMonth=='11'}">
					selected="selected"
				</c:if>
				>11</option>
				<option value='12'
				<c:if test="${curMonth=='12'}">
					selected="selected"
				</c:if>
				>12</option>
			</select>월	
			
			<select id="day" onChange="javascript:selectEvent(this)" >
				<option value='01' 
				<c:if test="${curDay=='01'}">
					selected="selected"
				</c:if>
				>01</option>
				<option value='02'
				<c:if test="${curDay=='02'}">
					selected="selected"
				</c:if>
				>02</option>
				<option value='03'
				<c:if test="${curDay=='03'}">
					selected="selected"
				</c:if>
				>03</option>
				<option value='04'
				<c:if test="${curDay=='04'}">
					selected="selected"
				</c:if>
				>04</option>	
				<option value='05'
				<c:if test="${curDay=='05'}">
					selected="selected"
				</c:if>
				>05</option>	
				<option value='06'
				<c:if test="${curDay=='06'}">
					selected="selected"
				</c:if>
				>06</option>
				<option value='07'
				<c:if test="${curDay=='07'}">
					selected="selected"
				</c:if>
				>07</option>
				<option value='08'
				<c:if test="${curDay=='08'}">
					selected="selected"
				</c:if>
				>08</option>
				<option value='09'
				<c:if test="${curDay=='09'}">
					selected="selected"
				</c:if>
				>09</option>
				<option value='10'
				<c:if test="${curDay=='10'}">
					selected="selected"
				</c:if>
				>10</option>
				<option value='11'
				<c:if test="${curDay=='11'}">
					selected="selected"
				</c:if>
				>11</option>
				<option value='12'
				<c:if test="${curDay=='12'}">
					selected="selected"
				</c:if>
				>12</option>
				
				<option value='13' 
				<c:if test="${curDay=='13'}">
					selected="selected"
				</c:if>
				>13</option>
				<option value='14'
				<c:if test="${curDay=='14'}">
					selected="selected"
				</c:if>
				>14</option>
				<option value='15'
				<c:if test="${curDay=='15'}">
					selected="selected"
				</c:if>
				>15</option>
				<option value='16'
				<c:if test="${curDay=='16'}">
					selected="selected"
				</c:if>
				>16</option>	
				<option value='17'
				<c:if test="${curDay=='17'}">
					selected="selected"
				</c:if>
				>17</option>	
				<option value='18'
				<c:if test="${curDay=='18'}">
					selected="selected"
				</c:if>
				>18</option>
				<option value='19'
				<c:if test="${curDay=='19'}">
					selected="selected"
				</c:if>
				>19</option>
				<option value='20'
				<c:if test="${curDay=='20'}">
					selected="selected"
				</c:if>
				>20</option>
				<option value='21'
				<c:if test="${curDay=='21'}">
					selected="selected"
				</c:if>
				>21</option>
				<option value='22'
				<c:if test="${curDay=='22'}">
					selected="selected"
				</c:if>
				>22</option>
				<option value='23'
				<c:if test="${curDay=='23'}">
					selected="selected"
				</c:if>
				>23</option>
				<option value='24'
				<c:if test="${curDay=='24'}">
					selected="selected"
				</c:if>
				>24</option>
				
				
				<option value='25'
				<c:if test="${curDay=='25'}">
					selected="selected"
				</c:if>
				>25</option>
				<option value='26'
				<c:if test="${curDay=='26'}">
					selected="selected"
				</c:if>
				>26</option>
				<option value='27'
				<c:if test="${curDay=='27'}">
					selected="selected"
				</c:if>
				>27</option>
				<option value='28'
				<c:if test="${curDay=='28'}">
					selected="selected"
				</c:if>
				>28</option>
				<option value='29'
				<c:if test="${curDay=='29'}">
					selected="selected"
				</c:if>
				>29</option>
				<option value='30'
				<c:if test="${curDay=='30'}">
					selected="selected"
				</c:if>
				>30</option>
				<option value='31'
				<c:if test="${curDay=='31'}">
					selected="selected"
				</c:if>
				>31</option>
				
			</select>일	
			
			<input type="button" onclick="fn_nextdate()" value="다음">
			<input type="button" onclick="fn_prevdate()" value="이전">
			
			</td>
		</TR>
		</TABLE>
		
		
		<table cellSpacing="0" cellPadding="0" border="0" width="100%">
		<c:set var="samuCnt" value="6"></c:set>
		<c:set var="exCnt" value="13"></c:set>
			<tr>
				<td vAlign="top" align="left" width="100%">
					<div id="worklist" style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px; scroll: auto; WIDTH:100%">
						<div class="divgaltable" id="divTablex"	style="overflow-x:hidden;">
							<table border="0" cellSpacing="0" cellPadding="0">
							<tr>
								<td>
									<table width="100%" height="400" border="0" cellSpacing="0" cellPadding="0">
										<tr>
											<td vAlign="top">
												<div class="divgaltable" id="divGalTable" style="display:block">
												    <table class="DataGrid_NL fixed" id="tblGalInfo" border="0" cellSpacing="0" cellPadding="0">
													<colgroup>
														<col />
														<col width="80%"/>
													</colgroup>	
													<tr>
													  <td class="thTitle_NL11" noWrap="nowrap" onselect="false" align="center">일자</td>
													  <td class="thTitle_NL11" noWrap="nowrap" onselect="false" align="center">내용</td>
													</tr>	
													<c:forEach var="workList" items="${workList}" varStatus="i">
													<tr>
														<td class="tdData_NL12" onselect="false" align="center">
														 <c:out value="${workList.DT_REG1}"/></td>
														
														<td style="PADDING-LEFT: 120px"  class="tdData_NL12" onselect="false" align="left" valign="center">
														<a href="javascript:lfViewPopup('<c:out value="${workList.CD_DEPT}"/>','<c:out value="${workList.DT_REG}"/>');">
																<pre><c:out value="${workList.NEXT_WORK}"/></pre>
														</a>
														</td>
													</tr>
													</c:forEach>	
                                                </table>
												</div>	
											</td>	
										</tr>
									</table>
								</td>
							</tr>			
							</table>	
						</div>	
					</div> 
				</td>
			</tr>
		</table>
		<!--------------- // 본문 ---------------->
	</body>
</HTML>
