$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false);

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.action === "open") {
            $("#medic-cost").text("[" + item.cost + "$]");
            display(true);
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            display(false);
        }
    };

    $("#start-btn").click(function () {
        $.post(`https://${GetParentResourceName()}/callMedic`, JSON.stringify({}));
        display(false);
    });

    $("#reset-btn").click(function () {
        $.post(`https://${GetParentResourceName()}/restartScript`, JSON.stringify({}));
        display(false);
    });
});