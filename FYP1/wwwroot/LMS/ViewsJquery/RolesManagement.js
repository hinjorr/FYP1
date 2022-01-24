$(document).ready(function () {
    CommonFunctions.GetRoles("#dpDownRoles")
    RolesInTable();
    Menus(0);

});

function RolesInTable() {
    $("#tblRoles").DataTable({
        ajax: {
            url: "/General/GetRolesinJson",
            type: "Get",
            datatype: "json",
        },
        bPaginate: false,
        bFilter: false,
        bInfo: false,

        columns: [

            { data: "roleId" },
            { data: "roleName" },
            {
                data: "roleId",
                render: function (id) {
                    return (
                        '<button class="btn btn-sm btn-clean btn-icon" title="Edit Role" onclick="Update(' +
                        id +
                        ')"><i class="la la-edit"></i></button>' +
                        '<button class="btn btn-sm btn-clean btn-icon" title="Delete Role" onclick="Delete(' +
                        id +
                        ')"><i class="la la-trash"></i></button>'
                    );
                },
            },
        ],
    });
}

function Update(id) {
    $.ajax({
        url: "/Roles/GetSingleRole?id=" + id,
        success: function (resp) {
            if (resp.Icon == null) {
                $("#txtRoleName").val(resp.role.roleName)
                RoleDTO.RoleId = resp.role.roleId
            }
            else {
                swal
                    .fire({
                        text: resp.text,
                        icon: resp.icon,
                        buttonsStyling: false,
                        confirmButtonText: "Ok, got it!",
                        customClass: {
                            confirmButton: "btn font-weight-bold btn-light-primary",
                        },
                    })
                    .then(function () {
                        CommonFunctions.GetRoles("#dpDownRoles")
                    });
            }
        }
    });
}
function Delete(id) {
    $.ajax({
        url: "/Roles/DeleteRole?id=" + id,
        success: function (resp) {
            swal
                .fire({
                    text: resp.text,
                    icon: resp.icon,
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn font-weight-bold btn-light-primary",
                    },
                })
                .then(function () {
                    $("#tblRoles").DataTable().clear().destroy();
                    RolesInTable()
                    CommonFunctions.GetRoles("#dpDownRoles")
                });
        }
    });
}


function Menus(roleId) {
    $("#tblScreens").DataTable({
        ajax: {
            url: "/Roles/GetMenus?id=" + roleId,
            type: "Get",
            datatype: "json",
        },
        paging: false,
        scrollY: 400,
        bInfo: false,
        columns: [
            { data: "menu.menuId" },
            {
                data: "menu.controller",
                render: function (data, type, row) {
                    return row.menu.controller + "/" + row.menu.action
                }
            },
            {
                data: "roleMenu.check",
                render: function (check) {
                    if (check != null) {
                        if (check == true) {
                            return `<label class="checkbox">
                            <input type="checkbox" name="permissions" checked="checked" />
                            <span></span>&nbsp Allow</label>`
                        }
                        else {
                            return `<label class="checkbox">
                            <input type="checkbox" name="permissions"  />
                            <span></span>&nbsp Allow</label>`
                        }
                    }
                    else {
                        return `<label class="checkbox">
                        <input type="checkbox" name="permissions" value="12" />
                        <span></span>&nbsp Allow</label>`
                    }
                },
            },
        ],
    });
}


var RoleMenuDTO = []
$("#btnPermissions").click(function (e) {
    var Role = $("#dpDownRoles").val();
    if (Role != 0) {
        var tbl = $("#tblScreens tr");
        $.each(tbl, function (index, value) {
            if (index != 0) {
                var dto = {}
                dto.RoleId = Role
                dto.MenuId = $(this).find("td:eq(0)").text()
                dto.Check = $(this).find('input[type="checkbox"]').is(":checked")
                RoleMenuDTO.push(dto)
            }
        });
        SendData(RoleMenuDTO)
    }
});

function SendData(RoleMenuDTO) {
    console.log(RoleMenuDTO)
    $.ajax({
        method: "Post",
        url: "/Roles/AssignPermissions",
        data: { dto: RoleMenuDTO },
        success: function (resp) {
            swal
                .fire({
                    text: resp.text,
                    icon: resp.icon,
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn font-weight-bold btn-light-primary",
                    },
                })
                .then(function () {
                    while (RoleMenuDTO.length > 0) {
                        RoleMenuDTO.pop()
                    }
                });
        }
    });
}

$("#dpDownRoles").change(function (e) {
    var roleId = $("#dpDownRoles").val();
    if (roleId != 0) {
        $("#tblScreens").DataTable().clear().destroy();
        Menus(roleId)
    }
    else {
        $("#tblScreens").DataTable().clear().destroy();
        Menus(roleId)
    }
});

RoleDTO = {}
//role creation
$("#btnSubmit").click(function (e) {
    RoleDTO.RoleName = $("#txtRoleName").val();
    $.ajax({
        url: "/Roles/CreateRole",
        data: RoleDTO,
        success: function (resp) {
            swal
                .fire({
                    text: resp.text,
                    icon: resp.icon,
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn font-weight-bold btn-light-primary",
                    },
                })
                .then(function () {
                    $("#tblRoles").DataTable().clear().destroy();
                    RolesInTable()
                    CommonFunctions.GetRoles("#dpDownRoles")
                });
        }
    });
});