function appendText(section, questions, target) {
    let cardDiv = $('<div/>', {'class': 'mt-4 card'});
    let cardHeader = $('<h5/>', {'class': 'card-header'}).text(section.name);
    let descriptionTextPara = $('<p/>', {'class': 'card-text'}).text(section.description);
    let cardBody = $('<div/>', {'class': 'card-body'}).append(descriptionTextPara);
    let container = $('<div/>', {'class': 'container'});
    if (questions.length > 0) {
        questions.forEach(function (question) {
            let cardBoundary = $('<div/>', {'class': 'card border-secondary mb-3', 'style': 'max-width: 60rem;'});
            let innerCard = $('<div/>', {'class': 'card'});
            let innerCardHeader = $('<div/>', {'class': 'card-header'}).text(question.text);
            innerCard.append(innerCardHeader);
            if (!question.description.length === 0) {
                let innerCardText = $('<p/>', {'class': 'card-text'}).text(question.description);
                let innerCardBody = $('<div/>', {'class': 'card-body'}).append(innerCardText);
                innerCard.append(innerCardBody);
            }
            cardBoundary.append(innerCard);
            container.append(cardBoundary);
        });
    }
    cardDiv.append(cardHeader, cardBody, container);
    $(target).prepend(cardDiv);
}

function makeInputTag(type, placeholder, className) {
    return $('<input/>', {'class': className, 'type': type, 'placeholder': placeholder});
}
$(document).ready(function () {
    $(document).on('click', '.remove-section', function() {
        $(this)[0].parentElement.parentElement.parentElement.remove();
    });

    $(document).on('change', '.question-type', function () {
        let selectTag = $(this)[0];
        let addOptionButton = $(selectTag.parentElement).siblings('.add-option-container').find('.add-option');
        let optionDiv =  $(selectTag.parentElement).siblings('.card').find('.card-body');
        addOptionButton.attr('data', selectTag.value);
        optionDiv.empty();
        // addOptionButton.attr('disabled', 'true');
        if (selectTag.value === '7' || selectTag.value === '8') {
            let inputTag = makeInputTag('number', 'Define the range upper limit', 'form-control');
            optionDiv.append(inputTag);
        } else if (selectTag.value === '13') {
            let inputTag = makeInputTag('number', 'Define the number of URLs expected', 'form-control');
            optionDiv.append(inputTag);
        } else if (selectTag.value === '1' || selectTag.value === '2' || selectTag.value === '11') {
            addOptionButton.removeAttr('disabled');
        }
    });

    $(document).on('click', '#new-section-submit', function () {
        let submitFormButton = $('#new-section-submit');
        submitFormButton.find('i')[0].className = 'fa fa-spinner fa-spin';
        $("form").on("submit", function () {
            $(this).find(":submit").prop("disabled", true);
        });
    });
    $(document).on('ajax:success', '[data-new-section]', function (event) {
        [data, status, xhr] = event.detail;
        let submitFormButton = $('#new-section-submit');
        submitFormButton.find('i')[0].className = 'fas fa-arrow-right';
        $(this).find(":submit").removeAttr("disabled");
        if (data["success"] === true) {
            appendText(data["data"]["section"], data["data"]["questions"], '.section-display');
        }
        if(data.error === undefined || data.error == null) return;
        if (Object.keys(data.error).length === 0) {
            toastr.success('Successfully Created A Section');
            $(this)[0].parentElement.parentElement.remove();
        } else {
            toastr.error('OOPS!!! Something Went Wrong');
            Object.keys(data.error).forEach(function (key) {
                toastr.error(`${key} ${data.error[key]}`);
            })
        }
    });

    $(document).on('click', '.add-option', function (event) {
        let dataValue = $(this).attr('data');
        let optionDiv =  $($(this)[0].parentElement).siblings('.card').find('.card-body');
        let id = $($(this)[0].parentElement).siblings('.form-group').find('.form-control').attr('id').split("_")[3];
        console.log(dataValue);
        if(dataValue === '1' || dataValue === '2' || dataValue === '11') {
            let inputTag = makeInputTag('text', 'Enter the option value', 'form-control mb-3');
            inputTag.attr('name', `section[questions_attributes][${id}][options][]`);
            optionDiv.append(inputTag);
        }
    });
});
