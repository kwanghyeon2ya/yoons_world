/**
 * 
 */

function makeRandomName(){
	
	var first_word = ["첫눈","마지막","바람","꽃잎","잎새","빗방울","처음","고양이","강아지"];
	var second_word = ["처럼","같이"];
	var third_word = ["재밌게","멋있게","후회없이","신나게"];
	var forth_word = ["사는","걷는","먹는","하는","씹는","뜯는"];
	var fifth_word = ["사람","호랑이","곰","나그네","개발자","지렁이","미역"];
	

	var randomName = first_word[Math.floor(Math.random()*first_word.length)] +" "+ second_word[Math.floor(Math.random()*second_word.length)] +" "+ third_word[Math.floor(Math.random()*third_word.length)] +" "+ forth_word[Math.floor(Math.random()*forth_word.length)]+" "+fifth_word[Math.floor(Math.random()*fifth_word.length)];
	var chk_value = document.getElementById("hide_name_check").value
	
	console.log(randomName);
	if(document.getElementById("hide_name_check").checked){
		document.getElementById("hide_name_check").value = 1;
		document.getElementById("hide_name").value = randomName;
		console.log(document.getElementById("hide_name_check").value);
	}else{
		document.getElementById("hide_name_check").value = 0;
		document.getElementById("hide_name").value = "";
	}
}