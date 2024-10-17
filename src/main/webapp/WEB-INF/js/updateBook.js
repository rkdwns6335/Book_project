$(function(){
	$('#cameraimage').click(function(){
		$('#img').trigger('click'); //강제 이벤트 발생
	});
	
	//이미지 미리보기
	$('#img').change(function(){
		$('#showImageList').empty();
		
		for(var i = 0; i<this.files.length; i++){
			readURL(this.files[i]);
		}
	});
	
	function readURL(file){
		var reader = new FileReader();
		
		var show;
		
		reader.onload = function(e){
			var img = document.createElement('img');
			img.src = e.target.result;
			img.width = 200;
			img.height = 300;
			$('#showImageList').append(img);
		}
		
		reader.readAsDataURL(file);
	}
	
	$('#updateButton').click(function(){
		let formData = new FormData($('#updateForm')[0]);
		
		$.ajax({
			type: 'post',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			url: '/BooBooBookProject/bookboard/updateBook',
			data: formData,
			success: function(){
				location.href="/BooBooBookProject/bookboard/bookList";		
			},
			error: function(e){
				console.log(e);
			}
			
		}); //ajax
	});
});
