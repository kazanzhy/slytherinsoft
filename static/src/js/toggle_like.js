"use strict";

let like_forms = document.querySelectorAll(".like_form")



console.log("=====", like_forms)

like_forms.forEach(function(item){
	item.addEventListener("submit", handleSubmit);
})


function handleSubmit(ev){
	ev.preventDefault();


	const url = ev.target.getAttribute("action")
	const csrf = ev.target.firstElementChild.value

	console.log("URL", url)

	const data = {"lala":"blblbl"}

	fetch(url, {
		method: 'GET', 
    	body: data,
	    headers: {  
	      "Content-type": "blab",
	    },
	    credentials: 'include'
	  })
		.then((resp) => resp.json())
		.then(function(data){
	  		console.log("ID", data.id);
	  		console.log("Liked", data.liked);
	  		console.log("likes", data.likes);
			
			const like_button = document.getElementById(data.id+"_like");
			
			like_button.firstElementChild.innerHTML = data.likes
			like_button.lastElementChild.classList.toggle("fas");
			like_button.lastElementChild.classList.toggle("far");			
	  });


}

