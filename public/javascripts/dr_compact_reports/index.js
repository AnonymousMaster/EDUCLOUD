function updateLink (e) {
  $('js-view-report').href  = $('js-view-report').href.replace(/\/\d*$/,'/'+this.value)
}
