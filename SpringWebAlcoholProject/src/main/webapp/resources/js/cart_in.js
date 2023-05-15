window.onload = function(){
	const cards = document.querySelectorAll('.card');
	fixProducerName();
	calCardTotal();
	cards.forEach((cards) => {
		const product = cards.querySelectorAll('.product');
		
		product.forEach((product)=>{
			const minusBtn = product.querySelector('.minus');
			const plusBtn = product.querySelector('.plus');
			const amountVal = product.querySelector('.amount');
			const price = product.querySelector('.price');
			const checkbox = product.querySelector('.buy');
			const removeEle = product.querySelector('.removeEle');
			const idx = product.querySelector('.idx');
			let amount = parseInt(amountVal.innerHTML);
			const priceOne = parseInt(price.innerHTML)/amount;
			
			minusBtn.addEventListener('click', () => {
			    if (amount > 1) {
			    	amountVal.innerHTML=--amount;
			    	price.innerHTML=priceOne*amount;
			    	
			    	calCardTotal();
			    	fixAmount(amount,idx.value);
			    }
			});
			plusBtn.addEventListener('click', () => {
			    if (amount < 100) {
			    	amountVal.innerHTML=++amount;
			    	price.innerHTML=priceOne*amount;
			    	
			    	calCardTotal();
			    	fixAmount(amount,idx.value);
			    }
			});
			checkbox.addEventListener('change',() => {
				calCardTotal();
			})
			removeEle.addEventListener('click',()=>{
				var idx = product.querySelector('.idx').value;
				removeElem(idx);
				product.remove();
				calCardTotal();
			});
		});				
	});
}
function fixAmount(amount,idx){
	var url="fixAmount.do";
	var param="idx="+idx+"&amount="+amount;
	sendRequest(url,param,(response)=>{},"GET");
}

function calCardTotal(){
	const cards = document.querySelectorAll('.card');
	cards.forEach((cards) => {
		const product = cards.querySelectorAll('.product');
		const totPrice = cards.querySelector('.totPrice');
		const deliveryFee = cards.querySelector('.deliveryFee');
		const totCost = cards.querySelector('.totCost');
		let totprice=0;
		product.forEach((product)=>{
			const checkbox = product.querySelector('.buy');
			const price = product.querySelector('.price');
			if(checkbox.checked)
				totprice+=parseInt(price.innerHTML);
		});
		totPrice.innerHTML=totprice;
		if(totprice==0){
			deliveryFee.innerHTML=0;
			totCost.innerHTML=0;
		}else{
			deliveryFee.innerHTML=3000;
			totCost.innerHTML=totprice+3000;
		}
	});
	calTotal();
}

function calTotal(){
	const totPrice = document.querySelectorAll('.totPrice');
	const deliveryFee = document.querySelectorAll('.deliveryFee');
	const totCost = document.querySelectorAll('.totCost');
	var price=0;
	var fee=0;
	var cost=0;
	
	totPrice.forEach((tot)=>{
		price+=parseInt(tot.innerHTML);	
	});
	deliveryFee.forEach((tot)=>{
		fee+=parseInt(tot.innerHTML);	
	});
	cost=price+fee;
	document.getElementById("totPrice").innerHTML=price;
	document.getElementById("totDeliv").innerHTML=fee;
	document.getElementById("totCost").innerHTML=cost;
	document.ff.cost.value=cost;
}

function removeElem(idx){
	var url="remove_cart_in.do";
	var param="idx="+idx;
	sendRequest(url,param,(response)=>{},"POST");
}

function fixProducerName(){
    const producerNames = document.querySelectorAll('.producer_name');
    var idxs=[];
    const url = "findProdcerName.do";
    var names;
   	    	
    producerNames.forEach((producerName) => {
        idxs.push(parseInt(producerName.innerHTML));
    });
   	let data= { idxs: idxs };
    const xhr = new XMLHttpRequest();
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onreadystatechange = function() {
    	if (xhr.readyState === 4 && xhr.status === 200) {
        	const names = JSON.parse(xhr.responseText);
        	producerNames.forEach((producerName, idx) => {
            	producerName.innerHTML = names[idx];
        	});
    	}
    };
    xhr.send(JSON.stringify(data));
}