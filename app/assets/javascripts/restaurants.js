	$(document).on('turbolinks:load',function(){
		details=[]
		if(details.length==0){
			$('#order-confirm').prop('disabled',true)
		}
		$('#modal').on('hidden.bs.modal',function(e){
			$(e.target).find('.modal-content').html('')
		})

		
	})
	$(document).ready(function(){
		loadNotifications()
	})
	function loadNotifications(){
		$.get('/notifications',function(data){
			console.log(data)
			if(data.notifications.length > 0){
				$('#notification-icon').css('color','red')
				$('#nots').html('')
				$.each(data.notifications,function(k){
					$('#nots').append(`<li>
						<a href="/users/orders/`+this.id+`"><b>`+this.user+`</b> Ha realizado un pedido en <b>`+this.restaurant+`<b></a>
						</li>`)
				})
				$('#nots-count').html(data.notifications.length)
			}
		},'JSON')
	}
	function listeners(){
		a=$('#modal input')
		a.each(function(){
			$(this).on('click keyup',function(){
				detail.update()

			})
		})
	}
	function pedir(dish_id){
		$.get('/orders/cartmodal',{id:dish_id},function(data){
			$("#modal .modal-content").html(data)
			detail=new Detail()
			listeners()
			$("#modal").modal('toggle')

		},'html')
	}

	class Detail{
		constructor(){
			this.dish_id=$('#detail-qty').data('dish-id')
			this.name=$("#myModalLabel").text()
			this.qty=parseInt($('#detail-qty').val())
			this.price=parseFloat($('#detail-price').val())
			this.comment=$('#detail-comment').val()
			this.additionals_attributes=[]
			this.update()
		}

		update(){
			this.dish_id=$('#detail-qty').data('dish-id')
			this.qty=parseInt($('#detail-qty').val())
			this.name=$("#myModalLabel").text()
			this.price=parseFloat($('#detail-price').val())
			this.comment=$('#detail-comment').val()
			this.setAddons()
			this.totalprice=this.totalize()
			$('#totalprice').text(this.totalprice)

		}

		totalize(){
			var obj=this
			var normalprice=this.qty*this.price
			var extra=0
			$.each(obj.additionals_attributes,function(){
				let add=this.price;
				extra = extra+(add*parseInt(obj.qty))
			})
			return normalprice+extra
		}

		setAddons(){
			this.additionals_attributes=[]
			var obj=this
			$('#modal input:checked').each(function(){
				obj.additionals_attributes.push({addon_id:$(this).data('id'),price:$(this).data('price'),name:$(this).data('name')})
			})
		}

		toString(){
			return{'id':this.id}
		}

	}

	function calculateTotal(){
		total=0;
		envio=parseFloat($('#costo_envio').text())
		console.log(total)
		if(details.length>0){
			$.each(details,function(i){
				total=total+this.totalprice
				console.log(this.totalprice)
			})
		}
		if(total==0){
			total=0
		}
		else{
			total=total+envio
		}
		$('#total').html('Total: '+total+' R$')

	}

	function removeFromCart(element){

		if(confirm("Seguro que desea eliminar del carrito?")){
			index=element.parents('.list-group-item').data('detail')
			details.splice(index,1)
			element.parents('.list-group-item').remove()
			if(details.length==0){
				$('#order-confirm').prop('disabled',true)
			}
			else{
				$('#order-confirm').prop('disabled',false)
			}

			calculateTotal();
		}
		
	}

	function addToCart(det){
		details.push(det)
		var total=0;
		$('.cart-detail').html('')
		$.each(details,function(i){
			var additionals=this.additionals_attributes.map(n=>n.name).join(', ')

			$('.cart-detail').append(`
				<div class="list-group-item" data-detail="`+i+`">
				<span onclick="removeFromCart($(this))" class="glyphicon glyphicon-remove"></span>
				<p class='item-name'>`+this.qty+` `+this.name+`<span class='pull-right'> `+this.totalprice+` R$</span></p>
				<p class='item-adds'>Adicionales: `+additionals+`</p>`
				)
			total=total+this.totalprice
		})
		if(details.length==0){
			$('#order-confirm').prop('disabled',true)
		}
		else{
			$('#order-confirm').prop('disabled',false)
		}
		$('#modal').modal('toggle')
		calculateTotal()
	}

	function confirmOrder(restaurantId){
		data={'order':{details_attributes:details,restaurant_id:restaurantId},authenticity_token:window._token}
		data=JSON.stringify(data)
		$.ajax({
			type:'post',
			url:'/orders/paymodal',
			dataType: 'html',
			data:data,
			headers: {'Content-type':"application/json"},
			success:function(data){
				$("#modal .modal-content").html(data)
				$("#modal").modal('toggle')
			}
		})

	}
