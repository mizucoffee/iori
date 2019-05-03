let singer = new Set()
let composer = new Set()
let lyricist = new Set()
let arranger = new Set()

let singer_id = new Set()
let composer_id = new Set()
let lyricist_id = new Set()
let arranger_id = new Set()

document.addEventListener("DOMContentLoaded", e => {

  $('#modal-music-search-form-search').click(e => {
    fetch('/api/music/search?q=' + $('#modal-music-search-form-name').val())
      .then(res => res.json())
      .then(json => {
        $('#modal-music-list').empty()
        json.forEach(e =>
          $('<li>').append($('<a>', { href: '#', text: e.name, class: 'uk-modal-close' }).click(() => {
            $('#form-music-name').val(e.name)
            $('#form-music-id').val(e.id)
          })).appendTo('#modal-music-list')
        )
        addNotFound('music')
      })
  })

  $('#music-artist-search-button').click(e => {
    fetch('/api/artist/search?q=' + $('#music-artist').val())
      .then(res => res.json())
      .then(json => {
        $('#modal-artist-list').empty()
        json.forEach(e => {
          const parent = $('<li>').append($('<a>', { class: 'uk-accordion-title', href: '#', text: e.name }))
          const content = $('<div>', { class: 'uk-accordion-content' })

          addLabel(e, singer, singer_id, '歌手', content)
          addLabel(e, composer, composer_id, '作曲者', content)
          addLabel(e, lyricist, lyricist_id, '作詞者', content)
          addLabel(e, arranger, arranger_id, '編曲者', content)

          parent.append(content).appendTo('#modal-artist-list')
        })

        addNotFound('artist')
      })
  })

  $('#music-register').click(e => {
    const body = {
      name: $('#music-name').val(),
      genre: $('#music-genre').val(),
      singer: Array.from(singer_id).join(','),
      composer: Array.from(composer_id).join(','),
      lyricist: Array.from(lyricist_id).join(','),
      arranger: Array.from(arranger_id).join(',')
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
  })

  $('#artist-create-button').click(e => {
    fetch('/api/artist', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8' },
      body: `name=${encodeURIComponent($('#artist-create-name').val())}`
    })
  })
})

function refresh() {
  $('#music-singer').val(Array.from(singer).join(','))
  $('#music-lyricist').val(Array.from(lyricist).join(','))
  $('#music-composer').val(Array.from(composer).join(','))
  $('#music-arranger').val(Array.from(arranger).join(','))
}

const onclick = (e, t, tid) => {
  return i => {
    if (i.target.checked) {
      t.add(e.name)
      tid.add(e.id)
    } else {
      t.delete(e.name)
      tid.delete(e.id)
    }
    refresh()
  }
}

function addNotFound(target) {
  $('<li>', { style: 'padding: 12px 10px;' })
    .append($('<span>', { class: 'list-message', text: '見つかりませんでしたか？' }))
    .append($('<a>', { class: 'uk-button uk-button-primary uk-align-right', href: `#modal-${target}-create`, 'uk-toggle': '', text: '登録する' }))
    .appendTo(`#modal-${target}-list`)
}

function addLabel(e, target, target_id, name, content) {
  $('<label>').append($('<input>', {
    class: "uk-checkbox",
    type: "checkbox",
    checked: target_id.has(e.id)
  }).change(onclick(e, target, target_id))).append($('<span>', {
    text: ` ${name}  `
  })).appendTo(content)
}
