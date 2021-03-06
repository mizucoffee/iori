let singer = new Set()
let composer = new Set()
let lyricist = new Set()
let arranger = new Set()

let singer_id = new Set()
let composer_id = new Set()
let lyricist_id = new Set()
let arranger_id = new Set()

$(document).ready(() => {

  $('#modal-music-search-form-search').click(e => {
    if ($('#modal-music-search-form-name').val() != '') {

      fetch('/api/music/search?q=' + $('#modal-music-search-form-name').val())
        .then(res => res.json())
        .then(json => {
          $('#modal-music-list').empty()
          json.forEach(e =>
            $('<li>').append($('<a>', {
              href: '#',
              text: e.name,
              class: 'uk-modal-close'
            }).click(() => {
              $('#form-music-name').val(e.name)
              $('#form-music-id').val(e.id)
            })).appendTo('#modal-music-list')
          )
          addNotFound('music')
        })
    } else {
      noText('music')
    }
  })

  $('#music-artist-search-button').click(e => {
    if ($('#music-artist').val() != '') {
      fetch('/api/artist/search?q=' + $('#music-artist').val())
        .then(res => res.json())
        .then(json => {
          $('#modal-artist-list').empty()
          json.forEach(e => {
            const parent = $('<li>').append($('<a>', {
              class: 'uk-accordion-title',
              href: '#',
              text: e.name
            }))
            const content = $('<div>', {
              class: 'uk-accordion-content'
            })

            const addCheckBox = (target, target_id, name) => {
              $('<label>').append($('<input>', {
                class: "uk-checkbox",
                type: "checkbox",
                checked: target_id.has(e.id)
              }).change(onclick(e, target, target_id))).append($('<span>', {
                text: ` ${name}  `
              })).appendTo(content)
            }

            addCheckBox(singer, singer_id, '歌手')
            addCheckBox(composer, composer_id, '作曲者')
            addCheckBox(lyricist, lyricist_id, '作詞者')
            addCheckBox(arranger, arranger_id, '編曲者')

            parent.append(content).appendTo('#modal-artist-list')
          })

          addNotFound('artist')
        })
    } else {
      noText('artist')
    }
  })

  $('#music-register').click(e => {
    if ($('#music-name').val() == '') {
      $('#music-alert').removeClass('uk-hidden')
      return
    }
    if (singer_id.size == 0 && composer_id.size == 0 && lyricist_id.size == 0 && arranger_id.size == 0) {
      $('#artists-alert').removeClass('uk-hidden')
      return
    }

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
      .then(r => r.json())
      .then(r => {
        $('#form-music-name').val(r.name)
        $('#form-music-id').val(r.id)

        UIkit.modal($('#modal-music-create')[0]).hide()
        UIkit.modal($('#modal-music-search')[0]).hide()
      })
  })

  $('#artist-create-button').click(e => {
    if ($('#artist-create-name').val() != '') {
      fetch('/api/artist', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
        },
        body: `name=${encodeURIComponent($('#artist-create-name').val())}`
      }).then(r => {
        UIkit.modal($('#modal-music-create')[0]).show()
        $('#music-artist').val($('#artist-create-name').val())
        $('#music-artist-search-button').click()
      })
    } else {
      $('#artist-alert').removeClass('uk-hidden')
    }
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
  $('<li>', {
      style: 'padding: 12px 10px;'
    })
    .append($('<span>', {
      class: 'list-message',
      text: '見つかりませんでしたか？'
    }))
    .append($('<a>', {
      class: 'uk-button uk-button-primary uk-align-right',
      href: `#modal-${target}-create`,
      'uk-toggle': '',
      text: '登録する'
    }))
    .appendTo(`#modal-${target}-list`)
}

function noText(target) {
  $('<li>', {
      style: 'padding: 12px 10px;'
    })
    .append($('<span>', {
      class: 'list-message',
      text: '検索ワードを入力してください。'
    }))
    .appendTo(`#modal-${target}-list`)
}