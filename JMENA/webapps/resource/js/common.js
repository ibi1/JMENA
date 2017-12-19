jQuery.download = function(url, data, method){
    // url과 data를 입력받음
    if( url && data ){ 
        // data 는  string 또는 array/object 를 파라미터로 받는다.
        data = typeof data == 'string' ? data : jQuery.param(data);
        // 파라미터를 form의  input으로 만든다.
        var inputs = '';
        jQuery.each(data.split('&'), function(){ 
            var pair = this.split('=');
            inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />'; 
        });
        // request를 보낸다.
        jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
        .appendTo('body').submit().remove();
    };
};

function addZero(n) {
	return n < 10 ? "0" + n : n;
}

function dateInput(n) {
	var date = new Date();
	
	date.setMonth(date.getMonth() - n);
	
	var yyyy = date.getFullYear();
	var mm = date.getMonth() + 1;
	var dd = date.getDate();
	
	return yyyy + "-" + addZero(mm) + "-" + addZero(dd);
}

//금액관련 콤마(,)처리 와 숫자만 입력
function inputComma(id) {
	var selector="input[id="+id+"]";
	
	$(selector).keypress(function(event) {
		if (event.which && (event.which < 48 || event.widch > 57) && (event.which != 45 && event.which != 46)) {
			event.preventDefault();
		}
	}).keyup(function() {
		if (event.which && (event.which < 48 || event.widch > 57) && (event.which != 45 && event.which != 46)) {
			event.preventDefault();
		} else {
			if( $(this).val() != null && $(this).val() != '' ) {
				$(this).val( $(this).val().replace(/[^0-9-.]/g, '') );
				$(this).val( setComma($(this).val()) );
			}
		}
	}).click(function() {
		if( $(this).val() != null && $(this).val() != '' ) {
			$(this).val( $(this).val().replace(/[^0-9-.]/g, '') );
			$(this).val( setComma($(this).val()) );
		}
	});
}

//콤마 넣기
function setComma(num) {
	var minusFlag = false;
	
	var numArr = num.split(".");
	
	if (numArr[0][0] == "-") { 
		numArr[0] *= -1;
		minusFlag = true;
	}
	
	if(numArr[0]<1000){
		return num;
	}
    
	var len, point, str;  
 
	numArr[0] = numArr[0] + "";  
    point = numArr[0].length % 3;
    len = numArr[0].length;  
 
    str = numArr[0].substring(0, point);  
    
    while (point < len) {  
        if (str != "") str += ",";  
        str += numArr[0].substring(point, point + 3);  
        point += 3;  
    }  

	var reData;
    if (numArr.length == 1) {
    	reData = str;
    } else {
    	reData = str + "." + numArr[1];
    }
    
    if (minusFlag == true) {
    	reData = "-" + reData;
    }
    
    return reData;
}

// 콤마 빼기
function removeComma(num){
	if (num == null || num == "") {
		return num;
	}
	
	var numArr =num.split(".");
	
	if(numArr[0]<1000){
		return num;
	}
	
	str = parseInt(numArr[0].replace(/,/g, ""));
	
 	var reData;
    if (numArr.length == 1) {
    	reData = str;
    } else {
    	reData = str + "." + numArr[1];
    }
    
    return reData;
 }