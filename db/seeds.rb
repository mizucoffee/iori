if Genre.count == 0
  Genre.create([
    {name: 'J-POP'},
    {name: 'イージーリスニング'},
    {name: 'インダストリアル'},
    {name: 'エレクトロニック'},
    {name: 'オルタナティブ'},
    {name: 'カントリー'},
    {name: 'ゲーム音楽'},
    {name: 'サウンドトラック'},
    {name: 'ジャズ'},
    {name: 'ダンス'},
    {name: 'チルドレン・ミュージック'},
    {name: 'テクノ'},
    {name: 'トランス'},
    {name: 'ニューエイジ'},
    {name: 'ハウス'},
    {name: 'ヒップホップ/ラップ'},
    {name: 'フォーク'},
    {name: 'ブック&スボークン'},
    {name: 'ブルース/R&B'},
    {name: 'ポップ'},
    {name: 'ホリデーミュージック'},
    {name: 'ロック'},
    {name: 'ワールド'},
    {name: '宗教音楽'},
    {name: '童謡/唱歌'},
    {name: '無分類'},
    {name: 'その他'}
  ])
  Artist.create([
    {name: '中島みゆき'},
    {name: '槇原敬之'}
  ])
end
