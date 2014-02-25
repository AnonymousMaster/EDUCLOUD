ra_clear_highlight = function (){
    $$('#remarks_list li').each(function(el){el.removeClassName('match').removeClassName('js-match');});
}
ra_highlight_all = function (event){
    ra_clear_highlight();
    search_val = $('remark_autocomplete').value;
    if(search_val != '')
    {
        search_options = $$('#remarks_list li');
        matches = search_options.filter(
            function(i){
                return i.innerText.toLowerCase().indexOf(search_val.toLowerCase()) != -1
            });
        matches.each(function(el){el.addClassName('match').addClassName('js-match')});
    }
}
ra_highlight_next = function (event){
    matches = $$('#remarks_list li.js-match');
    curr = $$('#remarks_list li.highlight').first();
    curr_ind = matches.indexOf(curr);
    matches.each(function(el){el.removeClassName('highlight').addClassName('match')});
    matches[curr_ind + 1].removeClassName('match').addClassName('highlight');
}

ra_highlight_prev = function (event){
    matches = $$('#remarks_list li.js-match');
    curr = $$('#remarks_list li.highlight').first();
    curr_ind = matches.indexOf(curr);
    if(curr_ind <= 0)
        curr_ind = matches.length ;
    matches.each(function(el){el.removeClassName('highlight').addClassName('match')});
    matches[curr_ind - 1].removeClassName('match').addClassName('highlight');
}
