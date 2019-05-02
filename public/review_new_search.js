document.addEventListener("DOMContentLoaded", e => {

  let singer = new Set()
  let composer = new Set()
  let lyricist = new Set()
  let arranger = new Set()

  let singer_id = new Set()
  let composer_id = new Set()
  let lyricist_id = new Set()
  let arranger_id = new Set()

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
        $('<li>', { style: 'padding: 12px 10px;' })
          .append($('<span>', { class: 'list-message', text: '見つかりませんでしたか？' }))
          .append($('<a>', { class: 'uk-button uk-button-primary uk-align-right', href: '#modal-music-create', 'uk-toggle': '', text: '登録する' }))
          .appendTo('#modal-music-list')
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

  $('#music-artist-search-button').click(e => {
    fetch('/api/artist/search?q=' + $('#music-artist').val())
      .then(res => res.json())
      .then(json => {
        $('#modal-artist-list').empty()
        json.forEach(e => {
          const parent = $('<li>').append($('<a>', { class: 'uk-accordion-title', href: '#', text: e.name }))
          const content = $('<div>', { class: 'uk-accordion-content' })

          // TODO: 既に選択しているものを選択する
          $('<label>').append($('<input>', { class: "uk-checkbox", type: "checkbox" }).change(onclick(e, singer, singer_id))).append($('<span>', { text: ' 歌手  ' })).appendTo(content)
          $('<label>').append($('<input>', { class: "uk-checkbox", type: "checkbox" }).change(onclick(e, composer, composer_id))).append($('<span>', { text: ' 作曲者  ' })).appendTo(content)
          $('<label>').append($('<input>', { class: "uk-checkbox", type: "checkbox" }).change(onclick(e, lyricist, lyricist_id))).append($('<span>', { text: ' 作詞者  ' })).appendTo(content)
          $('<label>').append($('<input>', { class: "uk-checkbox", type: "checkbox" }).change(onclick(e, arranger, arranger_id))).append($('<span>', { text: ' 編曲者  ' })).appendTo(content)

          parent.append(content).appendTo('#modal-artist-list')
        })

        $('<li>', { style: 'padding: 12px 10px;' })
          .append($('<span>', { class: 'list-message', text: '見つかりませんでしたか？' }))
          .append($('<a>', { class: 'uk-button uk-button-primary uk-align-right', href: '#modal-artist-create', 'uk-toggle': '', text: '登録する' }))
          .appendTo('#modal-artist-list')

      })
  })

  $('#music-register').click(e => {
    const body = {
      name: $('#music-name').val(),
      genre: $('#music-genre').val(),
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
  })

  $('#artist-create-button').click(e => {
    fetch('/api/artist', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'},
      body: `name=${encodeURIComponent($('#artist-create-name').val())}`
    })
  })
})