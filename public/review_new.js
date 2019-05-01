window.onload = () => {
    const color = document.getElementById('color')
    const cs1 = document.getElementById('cs1')
    const cs2 = document.getElementById('cs2')
    const nav = document.querySelector('nav')
    const header = document.querySelector('header')
    const ctx = color.getContext('2d')
    const width = color.width
    const height = color.height

    const grd1 = ctx.createLinearGradient(0, 0, width, 0)
    for (let i = 0; i <= 360; i++) grd1.addColorStop(i / 360, `hsl(${i}, 100%, 70%)`)
    const grd2 = ctx.createLinearGradient(0, 0, width, 0)
    for (let i = 0; i <= 360; i++) grd2.addColorStop(i / 360, `hsl(${i}, 100%, 30%)`)

    ctx.fillStyle = grd1
    ctx.fillRect(0, 0, width, height)

    let drag = false
    let light = true

    function changeColor(e) {
        if (e) {
            x = e.offsetX
            y = e.offsetY
            const imageData = ctx.getImageData(x, 0, 1, 1).data

            max = imageData[0] > imageData[1] ? imageData[0] : imageData[1]
            max = max > imageData[2] ? max : imageData[2]
            min = imageData[0] < imageData[1] ? imageData[0] : imageData[1]
            min = min < imageData[2] ? min : imageData[2]
            h = max - min
            if (h > 0) {
                if (max == imageData[0]) {
                    h = (imageData[1] - imageData[2]) / h
                    if (h < 0) h += 6
                } else if (max == imageData[1]) {
                    h = 2 + (imageData[2] - imageData[0]) / h
                } else {
                    h = 4 + (imageData[0] - imageData[1]) / h
                }
            }
            h /= 6
        }
        cs1.style.background = 'hsl(' + h * 360 + ', 100%, 75%, 1)'
        cs2.style.background = 'hsl(' + h * 360 + ', 100%, 25%, 1)'
        nav.style.background = 'hsl(' + h * 360 + ', 100%, ' + (light ? '75%' : '25%') + ', 1)'
        header.style.background = 'hsl(' + h * 360 + ', 100%, ' + (light ? '75%' : '25%') + ', 1)'
        document.querySelector('.uk-section').style.background = 'hsl(' + h * 360 + ', 100%, ' + (light ? '85%' : '30%') + ', 1)'
    }

    color.addEventListener("mousedown", e => {
        drag = true;
        changeColor(e)
    }, false)
    color.addEventListener("mouseup", e => drag = false, false)
    color.addEventListener("mousemove", e => {
        if (drag) changeColor(e)
    }, false)

    cs1.onclick = e => {
        cs1.classList.add('selected')
        cs2.classList.remove('selected')
        ctx.fillStyle = grd1
        ctx.fillRect(0, 0, width, height)
        light = true
        changeColor()
    }
    cs2.onclick = e => {
        cs2.classList.add('selected')
        cs1.classList.remove('selected')
        ctx.fillStyle = grd2
        ctx.fillRect(0, 0, width, height)
        light = false
        changeColor()
    }
}