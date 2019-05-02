document.addEventListener("DOMContentLoaded", e => {

  let singer = new Set()
  let composer = new Set()
  let lyricist = new Set()
  let arranger = new Set()

  let singer_id = new Set()
  let composer_id = new Set()
  let lyricist_id = new Set()
  let arranger_id = new Set()

  const musicInput = document.getElementById('music_input')
  const musicSearch = document.getElementById('music_search')
  const musicResult = document.getElementById('music_result')

  musicSearch.onclick = e => {
    fetch('/api/music/search?q=' + musicInput.value)
      .then(res => res.json())
      .then(json => {
        if (json.length == 0) {
          const parent = document.createElement('li')
          parent.innerHTML = '<span class="list-message">アーティストが見つかりませんでした。</span><a class="uk-button uk-button-primary" href="#modal3" uk-toggle>登録する</a>'
          musicResult.appendChild(parent)
        } else {
          json.forEach(e => {
            const parent = $('<li>').append($('<a>',{ href: '#', text: e.name, class: 'uk-modal-close'}).click(() => {
              $('#music_box').val(e.name)
            }))
            parent.appendTo('#music_list') 
          })
          $('<li>', { style: 'padding: 12px 10px;' })
            .append($('<span>', {class: 'list-message', text: '見つかりませんでしたか？'}))
            .append($('<a>', {class: 'uk-button uk-button-primary uk-align-right', href: '#modal3', 'uk-toggle': 'uk-toggle', text: '登録する'}))
            .appendTo('#music_list')
        }
      })
  }

  function refresh() {
    $('#singer-input').attr('value',Array.from(singer).join(','))
    $('#lyricist-input').attr('value',Array.from(lyricist).join(','))
    $('#composer-input').attr('value',Array.from(composer).join(','))
    $('#arranger-input').attr('value',Array.from(arranger).join(','))
  }

  const onclick = (e, t, tid) => {
    return i => {
      if(i.target.checked){
        t.add(e.name)
        tid.add(e.id)
      }else {
        t.delete(e.name)
        tid.delete(e.id)
      }
      refresh()
    }
  }

  const artistInput = document.getElementById('artist_input')
  const artistSearch = document.getElementById('artist_search')
  const artistResult = document.getElementById('artist_list')

  artistSearch.onclick = e => {
    fetch('/api/artist/search?q=' + artistInput.value)
      .then(res => res.json())
      .then(json => {
        artistResult.innerHTML = ''
        if (json.length == 0) {
          const parent = document.createElement('li')
          parent.innerHTML = '<span class="list-message">アーティストが見つかりませんでした。</span><a class="uk-button uk-button-primary" href="#modal3" uk-toggle>登録する</a>'
          artistResult.appendChild(parent)
        } else {
          json.forEach(e => {
            const parent = $('<li>').append($('<a>',{class: 'uk-accordion-title', href: '#', text: e.name}))
            const content = $('<div>', {class: 'uk-accordion-content'})
            // 既に選択しているものを選択する
            $('<label>').append($('<input>', {class:"uk-checkbox", type: "checkbox" }).change(onclick(e, singer, singer_id))).append($('<span>',{ text: ' 歌手  '})).appendTo(content)
            $('<label>').append($('<input>', {class:"uk-checkbox", type: "checkbox" }).change(onclick(e, composer, composer_id))).append($('<span>',{ text: ' 作曲者  '})).appendTo(content)
            $('<label>').append($('<input>', {class:"uk-checkbox", type: "checkbox" }).change(onclick(e, lyricist, lyricist_id))).append($('<span>',{ text: ' 作詞者  '})).appendTo(content)
            $('<label>').append($('<input>', {class:"uk-checkbox", type: "checkbox" }).change(onclick(e, arranger, arranger_id))).append($('<span>',{ text: ' 編曲者  '})).appendTo(content)
            
            parent.append(content).appendTo('#artist_list') 
          })

          const parent = document.createElement('li')
          parent.style.padding = '12px 10px'
          parent.innerHTML = '<span class="list-message">見つかりませんでしたか？</span><a class="uk-button uk-button-primary uk-align-right" href="#modal3" uk-toggle>登録する</a>'
          artistResult.appendChild(parent)
        }
      })
  }

  $('#music_register').click(e => {
    const body = {
      name: $('#music_name').val(),
      genre: $('#genre').val(),
      singer: Array.from(singer).join(','),
      composer: Array.from(composer).join(','),
      lyricist: Array.from(lyricist).join(','),
      arranger: Array.from(arranger).join(',')
    }

    let str = ''
    for (var key in body) {
        if (str != '') str += '&'
        str += key + '=' + encodeURIComponent(body[key])
    }

    fetch('/api/music', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
      },
      body: str
    })
    .then(res => console.log(res))
  })

  const artistRegisterInput = document.getElementById('artist_register_input')
  const artistRegister = document.getElementById('artist_register')

  artistRegister.onclick = e => {
    fetch('/api/artist', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
        body: `name=${encodeURIComponent(artistRegisterInput.value)}`
      })
      .then(res => console.log(res))
  }
})