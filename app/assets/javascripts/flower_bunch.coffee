# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@Bunch_controller = class Bunch_controller
    @last_id : '0'
    @last_show_id : '0'
    @quantities : []

    #Function that makes green border around products in our flowergarden
    @greenBorder = (id) ->
        $('#' + id).css("border-style", "solid")
        path = $('#' + id).prop('src')

        if Bunch_controller.last_id != '0'
          $("#" + Bunch_controller.last_id).css("border-style", "none")
        if Bunch_controller.last_show_id != '0'
          $("#0" + Bunch_controller.last_show_id).css("border-style", "none")

        $('#' + id).css("border-style", "solid")
        $("#product-status").html "Oto nasz kwiat:"
        $("#product-name").html $("#name"+id).prop('innerHTML')
        $("#product-price").html $("#price"+id).prop('innerHTML')
        $("#product-description").html $("#description"+id).prop('innerHTML')
        $("#product-quantity").css("visibility", "visible")
        $("#product-quantity").val('1')
        $("#product-add").css("visibility", "visible")
        $("#product-update").css("visibility", "hidden")
        $("#product-delete").css("visibility", "hidden")
        $("#div-big-image").html '<img src="' + path + '" id="00' + Bunch_controller.last_id + '" class="flower-image-big" />'
        Bunch_controller.last_id = id
        Bunch_controller.last_show_id = '0'


   #Function that adds new product to a bunch
    @addProduct = () ->
        if !Bunch_controller.quantities[Number(Bunch_controller.last_id)]
            path = $('#' + Bunch_controller.last_id).prop('src')
            inner =  $("#div-bunch").prop('innerHTML')
            Bunch_controller.quantities[Number(Bunch_controller.last_id)] = Number($("#product-quantity").prop('value'))
            $("#product-quantity").val('1')
            $("#product-status").html "Kwiat dodano!"
            $("#div-bunch").html inner + '<img src="' + path + '" id="0' + Number(Bunch_controller.last_id) + '" class="flower-image" onclick="parent.Bunch_controller.showBunchElement(' + Number(Bunch_controller.last_id) + ')" />'
        else
            Bunch_controller.quantities[Number(Bunch_controller.last_id)] += Number($("#product-quantity").prop('value'))
            $("#product-status").html "Kwiat zaktualizowano!"
        $("#sum-of-products").val(Bunch_controller.sumAndEnable())


     #Function that use selection of flower in the bunch
    @updateProduct = () ->
        Bunch_controller.quantities[Bunch_controller.last_show_id] = Number($("#product-quantity").prop('value'))
        $("#product-status").html "Kwiat zaktualizowano!"
        $("#sum-of-products").val(Bunch_controller.sumAndEnable())


    @deleteProduct = () ->
        last = Bunch_controller.last_show_id
        Bunch_controller.quantities[Bunch_controller.last_show_id] = null
        child = $('#0'+Bunch_controller.last_show_id)
        child.remove()
        Bunch_controller.last_show_id = '0'
        $('#sum-of-products').val(Bunch_controller.sumAndEnable())
        Bunch_controller.greenBorder(last)


    #Function that shows flower in a bunch
    @showBunchElement = (id) ->
        path = $('#' + id.toString()).prop('src')
        if (Bunch_controller.last_id != '0') 
            $('#' + Bunch_controller.last_id).css("border-style", "none")
        if (Bunch_controller.last_show_id != '0') 
            $("#0" + Bunch_controller.last_show_id).css("border-style", "none")

        $("#0"+id).css("border-style", "dotted")
        $("#product-status").html "Oto nasz kwiat:"
        $("#product-name").html $("#name"+id).prop('innerHTML')
        $("#product-price").html $("#price"+id).prop('innerHTML')
        $("#product-description").html $("#description"+id).prop('innerHTML')
        $("#product-quantity").val(Bunch_controller.quantities[id])
        $("#product-add").css("visibility", "hidden")
        $("#product-update").css("visibility", "visible")
        $("#product-delete").css("visibility", "visible")
        $("#div-big-image").html '<img src="' + path + '" id="00' + Bunch_controller.last_id + '" class="flower-image-big" />'
        Bunch_controller.last_show_id = id
        Bunch_controller.last_id = '0'


    #Function that count the price of all elements in the bunch
    @sumAll = () ->
        sum = 0
        len = Bunch_controller.quantities.length
        for index in [1...len]
            if (Bunch_controller.quantities[index])
                sum += Bunch_controller.quantities[index] * Number($("#price" + index).prop('innerHTML'))

        return sum


    @sumAndEnable = () ->
        sum = Bunch_controller.sumAll()
        button_status = ""

        if (sum > 0)
            button_status = "visible"
        else
            button_status = "hidden"

        $("#finish-bunch").css("visibility",  button_status)
        return sum


    @pickUpAllFlowers = () ->
        flowers = ''
        index = 1
        len = Bunch_controller.quantities.length
        for index in [1...len]
          if (Bunch_controller.quantities[index])
              flowers += Bunch_controller.quantities[index] + ' x ' + $("#name" + index).prop('innerHTML')
              if (index != len - 1)
                  flowers += ', '
              else
                  flowers += '.'

        return flowers


    @finishBunch = () ->
        sum = Bunch_controller.sumAll()
        flowers = Bunch_controller.pickUpAllFlowers()

        $("#sum-of-products").val(sum)
        $("#sum-of-products").prop('disabled', false)
        $("#description-field").val(flowers)
        $("#finish-form").submit()

