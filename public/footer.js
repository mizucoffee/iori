function adjust() {
    $('footer').css('margin-top', 0)
    const m = window.innerHeight - $('html').height()
    if (m > 0) $('footer').css('margin-top', m)
}

$(document).ready(adjust)
$(window).resize(adjust)

$(window).click(adjust)