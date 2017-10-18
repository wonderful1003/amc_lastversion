<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE> New Document </TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <SCRIPT LANGUAGE="JavaScript">
 
    /* 모달팝업*/
function modalPopup(){ 
    var objectName = new Object(); // object 선언 modal의 이름이 된다. 
    objectName.message = "이건 테스트"; // modal에 넘겨줄 값을 선언할 수 있다. 
    var site = "./modalPop.html"; 
    var style ="dialogWidth:255px;dialogHeight:250px"; // 사이즈등 style을 선언 
    window.showModalDialog(site, objectName ,style ); // modal 실행 window.showModalDialog 포인트!! 
    // modal 에 넘겨줬던 값을 다시 부모창에 받아 들임     
    //document.getElementById("test1").value = objectName.message; 
}
 
  </SCRIPT>
 </HEAD>
 
 <BODY>
   
<pre>
모달 팝업 테스트해보자
<input type="text" id="test1">
<input type="button" value="모달 팝업 테스트" onclick="modalPopup()">
</pre>
 
 </BODY>
</HTML>


출처: http://basic-x.tistory.com/45 [WebBrain]