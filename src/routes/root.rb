# / Router
class RootRouter < Base
  get '/' do
    erb :'routes/root'
  end

  get '/@:screen_name' do
    @twuser = Tw.app.user(params[:screen_name])
    @user = User.find_by(twitter_id: @twuser.id)
    erb :'routes/@user/root'
  end

  get '/@:screen_name/:review_id' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    erb :'routes/@user/review'
  end

  get '/@:screen_name/:review_id/og.png' do
    @review = Review.find_by(id: params[:review_id])

    error 404 if @review.blank?
    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    svg = '<svg width="1200" height="630" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad" x1="0" x2="0" y1="0" y2="1">
      <stop class="stop1" offset="0%"/>
      <stop class="stop2" offset="100%"/>
    </linearGradient>
    <style type="text/css"><![CDATA[
      .stop1 { stop-color: hsl(' + @review.hue.to_s + ', 100%, ' + (@review.light ? '97%' : '35%') + ', 1); }
      .stop2 { stop-color: hsl(' + @review.hue.to_s + ', 100%, ' + (@review.light ? '85%' : '25%') + ', 1); }
    ]]></style>
  </defs>
  <rect x="0" y="0" width="1200" height="150" fill="#40414f"/>
  <rect x="0" y="150" width="1200" height="480" fill="url(#grad)"/>
  <text x="600" y="280" font-size="92" stroke="black" text-anchor="middle" stroke-width="0.5" >' + @review.title + '</text>
  <line x1="200" y1="310" x2="1000" y2="310" stroke-width="1" stroke="#aaa" />
  <text x="600" y="380" font-size="54" stroke="black" text-anchor="middle" stroke-width="0.5" >' + @review.music.name + '</text>
  <text x="600" y="520" font-size="64" stroke="black" text-anchor="middle" stroke-width="0.5" >' + @review.user.name + '</text>
  <line x1="400" y1="535" x2="800" y2="535" stroke-width="1" stroke="#aaa" />
  <text x="600" y="570" font-size="36" stroke="black" text-anchor="middle" stroke-width="0.5" >@' + @review.user.screen_name + '</text>
  <image x="115" y="25" width="100px" height="100px" href="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiB2aWV3Qm94PSIwIDAgMTAyNCAxMDI0IiB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIKICAgIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4bWw6c3BhY2U9InByZXNlcnZlIiB4bWxuczpzZXJpZj0iaHR0cDovL3d3dy5zZXJpZi5jb20vIgogICAgc3R5bGU9ImZpbGwtcnVsZTpldmVub2RkO2NsaXAtcnVsZTpldmVub2RkO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2UtbWl0ZXJsaW1pdDoxLjQxNDIxO2ZpbGw6d2hpdGU7Ij4KICAgIDxnPgogICAgICAgIDxwYXRoCiAgICAgICAgICAgIGQ9Ik0yNzUuNjM2LDE3NS41NTNjMTcuNTAyLC0zMC4zMTQgNy4xLC02OS4xMzQgLTIzLjIxNCwtODYuNjM2Yy0zMC4zMTQsLTE3LjUwMiAtNjkuMTM1LC03LjEgLTg2LjYzNiwyMy4yMTRsLTE1Ny4yODgsMjcyLjQzYy0xNy41MDIsMzAuMzE0IC03LjEsNjkuMTM1IDIzLjIxNCw4Ni42MzdjMzAuMzE0LDE3LjUwMSA2OS4xMzQsNy4wOTkgODYuNjM2LC0yMy4yMTVsMTU3LjI4OCwtMjcyLjQzWiIgLz4KICAgICAgICA8cGF0aAogICAgICAgICAgICBkPSJNMjc1LjY4MSwxMTIuMTMxYy0xNy41MDIsLTMwLjMxNCAtNTYuMzIyLC00MC43MTYgLTg2LjYzNiwtMjMuMjE0Yy0zMC4zMTQsMTcuNTAyIC00MC43MTYsNTYuMzIyIC0yMy4yMTUsODYuNjM2bDE1Ny4yODgsMjcyLjQzYzE3LjUwMiwzMC4zMTQgNTYuMzIyLDQwLjcxNiA4Ni42MzYsMjMuMjE1YzMwLjMxNCwtMTcuNTAyIDQwLjcxNiwtNTYuMzIzIDIzLjIxNCwtODYuNjM3bC0xNTcuMjg3LC0yNzIuNDNaIiAvPgogICAgICAgIDxwYXRoCiAgICAgICAgICAgIGQ9Ik01OTAuMzQ1LDE3NS41NTNjMTcuNTAyLC0zMC4zMTQgNy4xLC02OS4xMzQgLTIzLjIxNCwtODYuNjM2Yy0zMC4zMTQsLTE3LjUwMiAtNjkuMTM0LC03LjEgLTg2LjYzNiwyMy4yMTRsLTE1Ny4yODgsMjcyLjQzYy0xNy41MDIsMzAuMzE0IC03LjEsNjkuMTM1IDIzLjIxNCw4Ni42MzdjMzAuMzE0LDE3LjUwMSA2OS4xMzUsNy4wOTkgODYuNjM2LC0yMy4yMTVsMTU3LjI4OCwtMjcyLjQzWiIgLz4KICAgICAgICA8cGF0aAogICAgICAgICAgICBkPSJNNTkwLjM5LDExMi4xMzFjLTE3LjUwMiwtMzAuMzE0IC01Ni4zMjIsLTQwLjcxNiAtODYuNjM2LC0yMy4yMTRjLTMwLjMxNCwxNy41MDIgLTQwLjcxNiw1Ni4zMjIgLTIzLjIxNCw4Ni42MzZsNDI1LjExMiw3MzYuMzE2YzE3LjUwMiwzMC4zMTQgNTYuMzIyLDQwLjcxNiA4Ni42MzYsMjMuMjE0YzMwLjMxNCwtMTcuNTAyIDQwLjcxNiwtNTYuMzIyIDIzLjIxNCwtODYuNjM2bC00MjUuMTEyLC03MzYuMzE2WiIgLz4KICAgIDwvZz4KPC9zdmc+Cg=="/>
  <image x="230" y="45" width="150px" height="60px" href="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiB2aWV3Qm94PSIwIDAgMTAyNCA1MTIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIgogICAgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zOnNlcmlmPSJodHRwOi8vd3d3LnNlcmlmLmNvbS8iCiAgICBzdHlsZT0iZmlsbC1ydWxlOmV2ZW5vZGQ7Y2xpcC1ydWxlOmV2ZW5vZGQ7c3Ryb2tlLWxpbmVqb2luOnJvdW5kO3N0cm9rZS1taXRlcmxpbWl0OjEuNDE0MjE7ZmlsbDp3aGl0ZTsiPgogICAgPGc+CiAgICAgICAgPGc+CiAgICAgICAgICAgIDxwYXRoCiAgICAgICAgICAgICAgICBkPSJNMTE3LjUyLDIzMy4xMDJjMCwtMjkuNDQzIC0yMy45MDQsLTUzLjM0OCAtNTMuMzQ3LC01My4zNDhjLTI5LjQ0NCwwIC01My4zNDgsMjMuOTA1IC01My4zNDgsNTMuMzQ4bDAsMjI1LjU1YzAsMjkuNDQ0IDIzLjkwNCw1My4zNDggNTMuMzQ4LDUzLjM0OGMyOS40NDMsMCA1My4zNDcsLTIzLjkwNCA1My4zNDcsLTUzLjM0OGwwLC0yMjUuNTVaIiAvPgogICAgICAgICAgICA8cGF0aAogICAgICAgICAgICAgICAgZD0iTTExNy41Miw1My4zMjdjMCwtMjkuNDMyIC0yMy44OTUsLTUzLjMyNyAtNTMuMzI3LC01My4zMjdsLTAuMDQxLDBjLTI5LjQzMiwwIC01My4zMjcsMjMuODk1IC01My4zMjcsNTMuMzI3YzAsMjkuNDMyIDIzLjg5NSw1My4zMjcgNTMuMzI3LDUzLjMyN2wwLjA0MSwwYzI5LjQzMiwwIDUzLjMyNywtMjMuODk1IDUzLjMyNywtNTMuMzI3WiIgLz4KICAgICAgICA8L2c+CiAgICAgICAgPGc+CiAgICAgICAgICAgIDxwYXRoCiAgICAgICAgICAgICAgICBkPSJNNjk5LjMwMiwyMzMuMTAyYzAsLTI5LjQ0MyAtMjMuOTA1LC01My4zNDggLTUzLjM0OCwtNTMuMzQ4Yy0yOS40NDMsMCAtNTMuMzQ4LDIzLjkwNSAtNTMuMzQ4LDUzLjM0OGwwLDIyNS41NWMwLDI5LjQ0NCAyMy45MDUsNTMuMzQ4IDUzLjM0OCw1My4zNDhjMjkuNDQzLDAgNTMuMzQ4LC0yMy45MDQgNTMuMzQ4LC01My4zNDhsMCwtMjI1LjU1WiIgLz4KICAgICAgICAgICAgPHBhdGgKICAgICAgICAgICAgICAgIGQ9Ik04MDguMzg1LDI5MC40NTdjMjUuNDk5LC0xNC43MjIgMzQuMjQ4LC00Ny4zNzUgMTkuNTI2LC03Mi44NzRjLTE0LjcyMSwtMjUuNDk5IC00Ny4zNzUsLTM0LjI0OCAtNzIuODc0LC0xOS41MjdsLTk1LjI5LDUzLjM3MmMtMjUuNDk5LDE0LjcyMiAzNy45ODIsMTUxLjMzNiAzOS41NTUsMTIxLjkzNWMxLjU5MiwtMjkuNzgxIDM2LjUxNywtNDIuNjU0IDYyLjAxNiwtNTcuMzc2bDQ3LjA2NywtMjUuNTNaIiAvPgogICAgICAgIDwvZz4KICAgICAgICA8Zz4KICAgICAgICAgICAgPHBhdGgKICAgICAgICAgICAgICAgIGQ9Ik0xMDEzLjE4LDIzMy4xMDJjMCwtMjkuNDQzIC0yMy45MDQsLTUzLjM0OCAtNTMuMzQ4LC01My4zNDhjLTI5LjQ0MywwIC01My4zNDcsMjMuOTA1IC01My4zNDcsNTMuMzQ4bDAsMjI1LjU1YzAsMjkuNDQ0IDIzLjkwNCw1My4zNDggNTMuMzQ3LDUzLjM0OGMyOS40NDQsMCA1My4zNDgsLTIzLjkwNCA1My4zNDgsLTUzLjM0OGwwLC0yMjUuNTVaIiAvPgogICAgICAgICAgICA8cGF0aAogICAgICAgICAgICAgICAgZD0iTTEwMTMuMTgsNTMuMzI3YzAsLTI5LjQzMiAtMjMuODk1LC01My4zMjcgLTUzLjMyNywtNTMuMzI3bC0wLjA0MSwwYy0yOS40MzIsMCAtNTMuMzI3LDIzLjg5NSAtNTMuMzI3LDUzLjMyN2MwLDI5LjQzMiAyMy44OTUsNTMuMzI3IDUzLjMyNyw1My4zMjdsMC4wNDEsMGMyOS40MzIsMCA1My4zMjcsLTIzLjg5NSA1My4zMjcsLTUzLjMyN1oiIC8+CiAgICAgICAgPC9nPgogICAgICAgIDxwYXRoCiAgICAgICAgICAgIGQ9Ik0zNTUuMDYzLDE3OS43NTRjOTEuNjg2LDAgMTY2LjEyMyw3NC40MzcgMTY2LjEyMywxNjYuMTIzYzAsOTEuNjg2IC03NC40MzcsMTY2LjEyMyAtMTY2LjEyMywxNjYuMTIzYy05MS42ODUsMCAtMTY2LjEyMiwtNzQuNDM3IC0xNjYuMTIyLC0xNjYuMTIzYzAsLTkxLjY4NiA3NC40MzcsLTE2Ni4xMjMgMTY2LjEyMiwtMTY2LjEyM1ptMCwxMDYuNjg4YzMyLjgwNCwwIDU5LjQzNiwyNi42MzIgNTkuNDM2LDU5LjQzNWMwLDMyLjgwMyAtMjYuNjMyLDU5LjQzNSAtNTkuNDM2LDU5LjQzNWMtMzIuODAzLDAgLTU5LjQzNSwtMjYuNjMyIC01OS40MzUsLTU5LjQzNWMwLC0zMi44MDMgMjYuNjMyLC01OS40MzUgNTkuNDM1LC01OS40MzVaIiAvPgogICAgPC9nPgo8L3N2Zz4K"/>
  <text x="1100" y="95" font-size="54" fill="white" stroke="white" text-anchor="end" stroke-width="0.5">音楽レビュー</text>
</svg>'


    res = Faraday.post "https://svg2ogp.mizucoffee.net/", data: svg

    content_type :'image/png'
    res.body
  end

  get '/@:screen_name/:review_id/like' do
    @review = Review.find_by_id(params[:review_id])

    redirect '/' if @review.nil?

    unless Tw.app.user(@review.user.twitter_id.to_i).screen_name == params[:screen_name]
      redirect '/'
    end

    p = {user: @me, review: @review}
    if @review.likes.find_by(p).nil?
      @review.likes.create(p)
    else
      @review.likes.find_by(p).destroy
    end

    redirect "/@#{params[:screen_name]}/#{params[:review_id]}"
  end
end
