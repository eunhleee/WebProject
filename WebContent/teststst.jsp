<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<script type="text/javascript" src="se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
var oEditors = [];
 
$(function(){
   nhn.husky.EZCreator.createInIFrame({
      oAppRef: oEditors,
      elPlaceHolder: "ir1",
      //SmartEditor2Skin.html ������ �����ϴ� ���
      sSkinURI: "se2/SmartEditor2Skin.html",  
      htParams : {
          // ���� ��� ���� (true:���/ false:������� ����)
          bUseToolbar : true,             
          // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
          bUseVerticalResizer : true,     
          // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
          bUseModeChanger : true,         
          fOnBeforeUnload : function(){
               
          }
      }, 
      fOnAppLoad : function(){
          //textarea ������ �����ͻ� �ٷ� �ѷ��ְ��� �Ҷ� ���
          oEditors.getById["ir1"].exec("PASTE_HTML", ["���� �������ڸ��� �̹��� �ۼ���."]);
      },
      fCreator: "createSEditor2"
      });
</script>
</head>
<body>
<textarea name="ir1" id="ir1" rows="10" cols="100"></textarea>
</body>
</html>


