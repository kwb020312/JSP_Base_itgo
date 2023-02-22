 function CheckAddProduct() {
	 const productId = document.getElementById("productId")
	 const name = document.getElementById("name");
	 const unitPrice = document.getElementById("unitPrice");
	 const unitsInStock = document.getElementById("unitsInStock");
	 
	 if(!check(/^P[0-9]{4,11}$/, productId, "[상품 코드]\nP와 숫자를 조합하여 5에서 12자까지 입력하세요\n" +
			"첫 글자는 반드시 P로 시작해주세요.")){
		return false;
	}
	 
	 if(name.value.length < 4 || name.value.length > 12) {
		 alert("[상품명] \n 최소 4자리에서 최대 11자리까지 입력해주세요/")
		 name.focus()
		 return false
	 }
	 
	 if(unitPrice.value.length === 0 || isNaN(unitPrice.value)) {
		 alert("[가격] \n 숫자만 입력해주세요.")
		 unitPrice.focus()
		 return false
	 }
	 
	 if(unitPrice.value < 0) {
		 alert("[가격] \n 음수를 입력할 수 없습니다.")
		 unitPrice.focus()
		 return false
	 }
	 
	 if(isNaN(unitsInStock.value)) {
		 alert("[재고 수] \n 숫자만 입력해주세요.")
		 unitsInStock.focus()
		 return false
	 }
	 
	 if(unitsInStock.value < 0) {
		 alert("[재고 수] \n 음수를 입력할 수 없습니다.")
		 unitsInStock.focus()
		 return false
	 }
	 
	 
	 // 정규식, HTMLElement, 오류 메시지를 매개변수로 받는다.
	 function check(regExp, e, msg) {
		 if(regExp.test(e.value)) {
			 return true
		 } 
		 
		 alert(msg)
		 e.focus()
		 return false
	 }
	 
	 document.newProduct.submit()
	 return 
 }