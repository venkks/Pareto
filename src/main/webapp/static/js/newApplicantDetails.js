/**
 * Created by sourabhrohilla on 2/2/16.
 */
$(function(){

    function pageLoad(){
        $('#print').click(function(){
            window.print();
        })
    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);

});


$(function(){
    function pageLoad(){

        $('#grid').magnificPopup({
            delegate: '.thumbnail > a', // child items selector, by clicking on it popup will open
            type: 'image',
            gallery: {
                enabled: true
            }
        });
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});