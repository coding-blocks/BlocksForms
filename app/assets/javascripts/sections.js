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

$(document).on('click', '#new-section-submit', function () {
    let submitFormButton = $('#new-section-submit');
    submitFormButton.find('i')[0].className = 'fa fa-spinner fa-spin';
    $("form").on("submit", function () {
        $(this).find(":submit").prop("disabled", true);
    });
});
$(document).on('ajax:success', '[data-new-section]', function (event) {
    [data, status, xhr] = event.detail;
    console.log(data);
    let submitFormButton = $('#new-section-submit');
    submitFormButton.find('i')[0].className = 'fas fa-arrow-right';
    $(this).find(":submit").prop("disabled", false);
    if (data["success"] === true) {
        appendText(data["data"]["section"], data["data"]["questions"], '.section-display');
    }
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