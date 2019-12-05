$(document).ready(function () {
    $('#new-form-submit').click(function (event) {
        let submitFormButton = $('#new-form-submit');
        submitFormButton.find('i')[0].className = 'fa fa-spinner fa-spin';
        $("form").on("submit", function () {
            $(this).find(":submit").prop("disabled", true);
        });

    });
    $('[data-new-form]') .on('ajax:success', function (event) {
        [data, status, xhr] = event.detail;
        let submitFormButton = $('#new-form-submit');
        submitFormButton.find('i')[0].className = 'fas fa-arrow-right';
        submitFormButton.prop("disabled", false);
        document.location.href = '/forms'
    }).on('ajax:error', function (err) {
        console.log(err);
    });
});