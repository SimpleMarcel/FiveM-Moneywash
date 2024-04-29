$(function () {
    function display(bool) {
        if (bool) {
            $("body").fadeIn(500);
        } else {
            $("body").fadeOut(500);
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        $("#SimpleSchwarzGeld").html(item.currentblackMoney + "$")
        $("#SimpleBargeld").html(item.currentMoney + "$")
        $("#SimpleWaschKosten").html(item.currentWashCost + "$")
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
   
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://Simple_Moneywash/EXIT', JSON.stringify({})); 
            return
        }
    };

    $("#close").click(function () {
        $.post('http://Simple_Moneywash/EXIT', JSON.stringify({})); 
        return
    })
    
})