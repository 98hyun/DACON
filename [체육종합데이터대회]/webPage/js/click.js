var cnt = 113;
function qtrFunction(val) {
  if(val=='k'){
    cnt += 1
    alert("반납 됐습니다.");        
  }else {
    cnt -= 1
    alert("대여 했습니다.");
  }
  
  document.getElementById('var').innerHTML = `잔여 자전거수 : ${cnt}`;	  
}