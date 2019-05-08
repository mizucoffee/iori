$(document).ready(() => {
    const m = window.innerHeight - $('html').height()
    if (m > 0) $('footer').css('margin-top', m)
})