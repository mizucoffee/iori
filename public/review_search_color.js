$(document).ready(() => {

  function click(e) {
    const ctx = $('#color-canvas')[0].getContext('2d')
    ctx.clearRect(0, 0, 400, 100)

    const lightGrd = createGrd(85)
    const darkGrd = createGrd(30)
  
    ctx.fillStyle = lightGrd
    ctx.fillRect(0, 0, 400, 100)
  
    let light = true
    let x = 0
    changeColor()
  
    function changeColor(e) {
      e && (x = e.offsetX)
      const id = ctx.getImageData(x, 0, 1, 1).data
      let h = Math.max(id[0], id[1], id[2]) - Math.min(id[0], id[1], id[2])
      if (h > 0) {
        switch (Math.max(id[0], id[1], id[2])) {
          case id[0]:
            h = ((id[1] - id[2]) / h)
            if (h < 0) h += 6
            h = h / 6 * 360
            break
          case id[1]:
            h = (2 + (id[2] - id[0]) / h) / 6 * 360
            break
          case id[2]:
            h = (4 + (id[0] - id[1]) / h) / 6 * 360
            break
        }
      }  
  
      $('#cs1').css('background', `hsl(${h}, 100%, 85%, 1)`)
      $('#cs2').css('background', `hsl(${h}, 100%, 30%, 1)`)
      $('#new-review').css('background', `hsl(${h}, 100%, ${light ? '85%' : '30%'}, 1)`)
      $('#form-hue').val(h)
      $('#form-light').val(light ? '1' : '0')
      $('#form-color').val(`${light ? 'l' : 'd'}${h}`)
      $('.text').css('color', light ? 'black' : 'white')
    }
  
    let drag = false
    $('#color-canvas')
      .mousedown(e => { drag = true; changeColor(e) })
      .mouseup(e => drag = false)
      .mousemove(e => { e.buttons == 0 && (drag = false); drag && changeColor(e) })
  
    $('#cs1').click(colorOnClick)
    $('#cs2').click(colorOnClick)
  
    function createGrd(p) {
      const grd = ctx.createLinearGradient(0, 0, 400, 0)
      for (let i = 0; i <= 360; i++) grd.addColorStop(i / 360, `hsl(${i}, 100%, ${p}%)`)
      return grd
    }
  
    function colorOnClick(e) {
      $(e.target).addClass('selected')
      $(e.target.id == 'cs1' ? '#cs2' : '#cs1').removeClass('selected')
      light = e.target.id == 'cs1'
      ctx.fillStyle = light ? lightGrd : darkGrd
      ctx.fillRect(0, 0, 400, 100)
      changeColor()
    }
  }
  $('#tab1').click(e => setTimeout(click, 10))
  $('#tab').click(e => $('#body').removeClass('uk-hidden'))
  click()
})
