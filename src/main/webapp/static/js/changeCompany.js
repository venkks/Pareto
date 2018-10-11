/**
 * Created by sri on 2/12/15.
 */
var newCompanyId;
$(document).ready(function () {

    function pageLoad() {
        $(".companySection").click(function(){
            $("#changeCompanyId").val("");
            //alert($(this).attr("id"));
            var companyId = $(this).attr("id");
            companyId = companyId.replace("changeCompanyDivId", "");
            //alert(companyId);
            $("#changeCompanyId").val(companyId)
        });

        $("#modalYes").click(function(){
            newCompanyId = $("#changeCompanyId").val();
            changeSessionCompany(newCompanyId);
        })
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});

function changeSessionCompany(newCompanyId){
    $.ajax({
        type: "Post",
        url: 'ChangeCompany',
        data: {newCompanyId: newCompanyId},
        success: function (data) {
        }
    });
}