<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Main</title>

<link rel="stylesheet" href="material.min.css">
<script src="material.min.js"></script>
<script src="jquery.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css" href="dialog-polyfill.css" />
<script src="dialog-polyfill.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
.demo-list-three {
  width: 650px;
}
.scroll-tbody-y
{
    display: block;
    overflow-y: scroll;
}

.table-body{
    height: 350px;
}
table.icons-hover .icons {
  visibility: hidden;
}
table.icons-hover tr:hover .icons {
  visibility: visible;
  cursor:pointer;
}
.demo-card-square.mdl-card {
  width: 320px;
  height: 320px;
}
.demo-card-square > .mdl-card__title {
  color: #fff;
  background:
     bottom right 15% no-repeat #46B6AC;
}
.BLEs{
	display:inline-block;
}
.input{
	margin-left:20px;
}
.bleButton{
	margin-left: 5px;
    background: 0 0;
    border: none;
    border-radius: 2px;
    color: #000;
    position: relative;
    height: 36px;
    min-width: 64px;
    padding: 0 16px;
    display: inline-block;
    font-family: "Roboto","Helvetica","Arial",sans-serif;
    font-size: 14px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0;
    overflow: hidden;
    will-change: box-shadow;
    transition: box-shadow .2s cubic-bezier(.4,0,1,1),background-color .2s cubic-bezier(.4,0,.2,1),color .2s cubic-bezier(.4,0,.2,1);
    outline: none;
    cursor: pointer;
    text-decoration: none;
    text-align: center;
    line-height: 36px;
    vertical-align: middle;
}

</style>
<script type="text/javascript">
var idBle;
$.ajaxSetup({
	url:"main",
    async: false
});
$.getJSON("login",{session:"session"}, function(result){
	if(result.exists=="false")
		document.location.href='/BLE_Beacon/login';	
});
$("#SaveProfile").click(function() {
    reloadSaveProfile();
 });
 
function deleteInformation(ID){
    $('#liInformationItem'+ID+'').remove();
}
function addInformation() {
    var text = $("#textOfInformationId").val();
	var type = $("#typeOfInformationId").val();
	var link = $("#linkOfInformationId").val();
	var date = $("#dateOfInformationId").val();
	if(text==""  ||  type=="") {
	    	document.getElementById("warning2").innerHTML = "Some fields are empty";
	        return;
	    }              
    console.log(text+" "+type+" "+link+" "+date);
    document.getElementById('textOfInformationId').value = "";
	document.getElementById('typeOfInformationId').value="";
	document.getElementById('linkOfInformationId').value="";
	document.getElementById('dateOfInformationId').value="";
    console.log(document.getElementById('liInformation'+id+'')!=null);
    console.log(typeof(document.getElementById('liInformation+'+id+''))!=undefined);
    var id=0;
    while(document.getElementById('liInformationItem'+id+'')!=null && typeof(document.getElementById('liInformationItem'+id+''))!=undefined){
        console.log(id);
        if(id==2){
            document.getElementById("warning2").innerHTML = "One object can have only 3 informations.";
            return;
        }
        ++id;
    }
    document.getElementById("warning2").innerHTML="";
        $('#liInformation').append('<li id="liInformationItem'+id+'" class="mdl-list__item mdl-list__item--three-line"></li>');
        $('#liInformationItem'+id+'').append('<span id="spanLiItem'+id+'" class="mdl-list__item-primary-content"></span>');
        if(type=="Sale")
            $('#spanLiItem'+id+'').append('<i class="material-icons mdl-list__item-avatar">local_atm</i>');
        else if(type=="Event")
             $('#spanLiItem'+id+'').append('<i class="material-icons mdl-list__item-avatar">event</i>');
        else if(type=="Special offer")
             $('#spanLiItem'+id+'').append('<i class="material-icons mdl-list__item-avatar">stars</i>');
        else
            $('#spanLiItem'+id+'').append('<i class="material-icons mdl-list__item-avatar">bookmark</i>');
        if(link=="")
            $('#spanLiItem'+id+'').append('<span class="type">'+type+'</span><span style="float:right" class="date">'+date+'</span><span class="mdl-list__item-text-body text"><span text>'+text+'</span></span></span>');
        else
            $('#spanLiItem'+id+'').append('<span class="type">'+type+'</span><span style="float:right" class="date">'+date+'</span><span class="mdl-list__item-text-body text"><span text>'+text+'</span><a href="'+link+'  ">Link</a></span></span>');
        $('#liInformationItem'+id+'').append('<span class="mdl-list__item-secondary-content"><a class="mdl-list__item-secondary-action" onclick="deleteInformation('+id+')"><i class="material-icons">clear</i></a></span>');  
    componentHandler.upgradeAllRegistered(); 

}
function deleteInformation(ID){
    $('#liInformationItem'+ID+'').remove();
}
 
 
function EditMemberContent(ID)
{	
	 $.getJSON("main",{member:ID}, function(result){
	   $('#editMemberContent').append('<div id = "warning3" style="text-align:center; color:deeppink; font-weight:bold"></div>');
       $('#editMemberContent').append('<div id="divEditFirstname" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
       $('#divEditFirstname').append('<input id="editFirstname" class="mdl-textfield__input"  value="'+result.first_name_+'" id="EditFirstname">');
       $('#divEditFirstname').append('<label class="mdl-textfield__label" for="EditFirstName">First Name</label>');
       $('#divEditFirstname').append('<span class="mdl-textfield__error">Firstname is not right formated!</span>');
       
       $('#editMemberContent').append('<div id="divEditLastname" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
       $('#divEditLastname').append('<input id="editLastname" class="mdl-textfield__input"  value="'+result.last_name_+'" id="EditLastname">');
       $('#divEditLastname').append('<label class="mdl-textfield__label" for="EditLastName">Last Name</label>');
       $('#divEditLastname').append('<span class="mdl-textfield__error">Lastname is not right formated!</span>');
       
       $('#editMemberContent').append('<div id="divEditUsername" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
       $('#divEditUsername').append('<input id="editUsername" class="mdl-textfield__input"  value="'+result.username_+'" id="EditUserName" disabled>');
       $('#divEditUsername').append('<label class="mdl-textfield__label" for="EditUserName">User Name</label>');
       $('#divEditUsername').append('<span class="mdl-textfield__error">Username is not right formated!</span>');
       
       $('#editMemberContent').append('<div id="divEditPassword" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">');
       $('#divEditPassword').append('<input id="editPassword" class="mdl-textfield__input" value="'+result.password_+'" id="EditPassword">');
       $('#divEditPassword').append('<label class="mdl-textfield__label" for="EditPassword">Password</label>');
       $('#divEditPassword').append('<span class="mdl-textfield__error">Password is not right formated!</span>'); 
       
       $('#editMemberContent').append('<div id="divEditEmail" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
       $('#divEditEmail').append('<input id="editEmail" class="mdl-textfield__input"  value="'+result.email_+'" id="EditEmail">');
       $('#divEditEmail').append('<label class="mdl-textfield__label" for="EditEmail">E-Mail</label>');
       $('#divEditEmail').append('<span class="mdl-textfield__error">E-Mail is not right formated!</span>');
       
       componentHandler.upgradeAllRegistered(); 
	 });
}  


function reloadSaveProfile(){
    UpdateProfile={firstname:"",lastname:"",username:"",password:"",email:""};
    var lastname = $("#lastNameProfile").val();
    var firstname = $("#firstNameProfile").val();
    var username = $("#usernameProfile").val();
    var password = $("#passwordProfile").val();
    var email = $("#emailProfile").val();
    if(username=="" || firstname=="" || lastname=="" || email=="" || password=="")
    {
    	document.getElementById("warning").innerHTML = "Some fields are empty";
    	return;
    }
    UpdateProfile.firstname=firstname;
    UpdateProfile.lastname=lastname;
    UpdateProfile.username=username;
    UpdateProfile.password=password;
    UpdateProfile.email=email;
    var json=JSON.stringify(UpdateProfile);
    $.ajax({
  	  method: "POST",
  	  data: { "UpdateMember": json }
  	})
}

var deleteMemeberId;
function reloadMemberDelete()
{
	deleteMemeberId = this.id;
	dialog4.showModal();
}

$(".editMember").click(function() {
    reload();
 });
$(".deleteMember" ).click(function() {
    reloadMemberDelete();
});

function updateMembers(){
    $( "#tbodyMembers").empty();
    $.getJSON("main",{members:"members"}, function(result){
    	$.each(result, function(i, field){
        memberId = result[i].id_;
        $('#tbodyMembers').append('<tr id="trMember'+i+'"></tr>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].id_+'</td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].first_name_+'</td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].last_name_+'</td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].email_+'</td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].role_+'</td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric"><span id="'+result[i].id_+'" class="icons editMember"><i class="material-icons">create</i></span></td>');
        $('#trMember'+i+'').append('<td class="mdl-data-table__cell--non-numeric"><div id="'+result[i].id_+'" class="icons deleteMember"><i class="material-icons">clear</i></div></td>');
        $('#trMember'+i+'').on('click','span', reload);
        $('#trMember'+i+'').on('click','div', reloadMemberDelete); 
        });
    });
    componentHandler.upgradeAllRegistered();
}

function editBLE(){
	UpdateBLEBeacon(this.id);
	idBle=this.id;
	$.getJSON("main",{role:"role"}, function(result){
		if(result.role=="user")
			dialog6.showModal();
		else
			dialog.showModal();
	});
	
}
var deleteBLEBeaconId;
function deleteBLE(){
	deleteBLEBeaconId=this.id;
	dialog5.showModal();
}

function BLEsUpdate()
{
	 $('#BLEs').empty();
	 $.getJSON("main",{BLEs:"BLEs"}, function(result){
			$.each(result, function(i, field){
			    $('#BLEs').append('<div id="Ble'+i+'" class="BLEs"></div');    
		        $('#Ble'+i+'').append('<div id="Bles'+i+'" class="demo-card-square mdl-card mdl-shadow--2dp" style="margin:22px"></div>');
				$('#Bles'+i+'').append('<div id="card'+i+'" class="mdl-card__title mdl-card--expand"></div>');
				$('#card'+i+'').append('<h2 class="mdl-card__title-text">'+result[i].type+'</h2>');
				$('#Bles'+i+'').append('<div class="mdl-card__supporting-text">Name of Object: <b>'+result[i].nameOfObject+'</b></div>');
				$('#Bles'+i+'').append('<div id="links'+i+'" class="mdl-card__actions mdl-card--border" style="text-align: center""></div>');
				$('#links'+i+'').append('<span id="'+result[i].id+'" class="bleButton mdl-button--raised mdl-button--accent editBLE">Edit</span>');
        		$('#links'+i+'').append('<div id="'+result[i].id+'" class="bleButton mdl-button--raised mdl-button--accent deleteBLE">Delete</div>');
        		$('#links'+i+'').on('click','span', editBLE);
        		$('#links'+i+'').on('click','div', deleteBLE); 
				componentHandler.upgradeAllRegistered();
	        });
	 });
}


var Object;
var Information;
var Device;


var Ble;
function logOut(){
	$.ajax({url:"login",
   	  method: "POST",
   	  data: { "logOut":"logOut"}
    });
	document.location.href='/BLE_Beacon/login';	
}

function UpdateBLEBeacon(ID)
{
		 $.getJSON("main",{BLE:ID}, function(result){
			 if(result.role=="admin"){
				 $('#BLEBeaconUpdate').empty();	
			   $('#BLEBeaconUpdate').append('<div id="warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');
			   $('#BLEBeaconUpdate').append('<div id="BLEUpdateHeader" class="BLEUpdateHeader" style="margin-bottom:20px"></div>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEName" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEName').append('<input class="mdl-textfield__input" id="updateObjectName"  value="'+result.nameOfObject+'" disabled>');
		       $('#updateBLEName').append('<label class="mdl-textfield__label" for="updateObjectName">Object name</label>');
		       $('#updateBLEName').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
		       $('#BLEUpdateHeader').append('<div id="updateBLECity" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLECity').append('<input class="mdl-textfield__input" id="updateObjectCity" value="'+result.city+'">');
		       $('#updateBLECity').append('<label class="mdl-textfield__label" for="updateObjectCity">City</label>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEAddress" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEAddress').append('<input class="mdl-textfield__input"  id="updateDeviceAddress" value="'+result.address+'">');
		       $('#updateBLEAddress').append('<label class="mdl-textfield__label" for="updateDeviceAddress">Address</label>');
		       $('#updateBLEAddress').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEType" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEType').append('<input class="mdl-textfield__input"  id="updateType"  value="'+result.type+'" disabled>');
		       $('#updateBLEType').append('<label class="mdl-textfield__label" for="updateType">Type</label>');
		       $('#updateBLEType').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
		       $('#BLEUpdateHeader').append('<div id="updateBLELink" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLELink').append('<input class="mdl-textfield__input" id="updateLink" value="'+result.link+'">');
		       $('#updateBLELink').append('<label class="mdl-textfield__label" for="updateLink">Link</label>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEDeviceUUID" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEDeviceUUID').append('<input class="mdl-textfield__input" id="updateDeviceUUID" value="'+result.devUUID+'">');
		       $('#updateBLEDeviceUUID').append('<label class="mdl-textfield__label" for="updateDeviceUUID">Device UUID</label>');
		       $('#updateBLEDeviceUUID').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
		       $('#updateBLEContent').append('<div id="BLEUpdateHeader" class="BLEUpdateHeader"></div>');
		       $('#BLEBeaconUpdate').append('<div id="divBLEInformation" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label" style="margin-left:20px;"></div>');
		       $('#divBLEInformation').append('<textarea class="mdl-textfield__input" maxlength="200" style="display:block;resize:none;" type="text" rows= "8" id="updateInformation">'+result.information+'</textarea>');
		       $('#divBLEInformation').append('<label class="mdl-textfield__label" for="updateInformation">Information</label>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEDeviceMajor" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEDeviceMajor').append('<input class="mdl-textfield__input" id="updateDeviceMajor" value="'+result.devMajor+'">');
		       $('#updateBLEDeviceMajor').append('<label class="mdl-textfield__label" for="updateDeviceMajor">Device Major</label>');
		       $('#updateBLEDeviceMajor').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
		       $('#BLEUpdateHeader').append('<div id="updateBLEDeviceMinor" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
		       $('#updateBLEDeviceMinor').append('<input class="mdl-textfield__input" id="updateDeviceMinor" value="'+result.devMinor+'">');
		       $('#updateBLEDeviceMinor').append('<label class="mdl-textfield__label" for="updateDeviceMinor">Device Minor</label>');
		       $('#updateBLEDeviceMinor').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
       			componentHandler.upgradeAllRegistered();
       			}
			 else{
				 $('#BLEBeaconUpdateMember').empty();	
				 updateBLEBeacon =result.nameOfObject;
				   $('#nameOfBLE').text("Edit Informations - "+result.nameOfObject+"");
				   $('#BLEBeaconUpdateMember').append('<div id="BLEUpdateMemberHeader" class="BLEUpdateHeader" style="margin-bottom:20px"></div>');
		           $('#BLEUpdateMemberHeader').append('<div id = "warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');
				   $('#BLEUpdateMemberHeader').append('<div id="newInformationBLE"><hr/><h5>Add new information</h5></div>');
				   $('#newInformationBLE').append('<div id="textOfInformation" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
			       $('#textOfInformation').append('<input class="mdl-textfield__input" id="textOfInformationId" maxlength="50">');
			       $('#textOfInformation').append('<label class="mdl-textfield__label" for="textOfInformationId">Text*</label>');
			       $('#newInformationBLE').append('<div id="typeOfInformation" style="margin-left:15px;"class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
			       $('#typeOfInformation').append('<input class="mdl-textfield__input" id="typeOfInformationId" maxlength="20" list="typeData">');
			       $('#typeOfInformation').append('<label class="mdl-textfield__label" for="typeOfInformationId">Type*</label><datalist id="typeData"><option>Sale</option><option>Event</option><option>Special offer</option></datalist>');
			       $('#newInformationBLE').append('<div id="linkOfInformation" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
			       $('#linkOfInformation').append('<input class="mdl-textfield__input" id="linkOfInformationId">');
			       $('#linkOfInformation').append('<label class="mdl-textfield__label" for="linkOfInformationId">Link</label>');
			       $('#newInformationBLE').append('<div id="dateOfInformation" style="margin-left:15px;"class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label input"></div>');
			       $('#dateOfInformation').append('<input class="mdl-textfield__input" id="dateOfInformationId" type="date">');
		           $('#newInformationBLE').append('<button style="margin-top:25px;margin-left:10px;" onclick="addInformation()"class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored addBLE"><i class="material-icons">add</i></button>');
			       $('#newInformationBLE').append('<hr/>');        
		           $('#BLEUpdateMemberHeader').append('<div id="informationOfBLEBeacon"</div>');
		           $('#informationOfBLEBeacon').append('<ul id="liInformation" class="demo-list-three mdl-list"></ul>');
		           if(result.list=="notEmpty"){
		           $.each(result.informations[0], function(i, field){
		                $('#liInformation').append('<li id="liInformationItem'+i+'" class="mdl-list__item mdl-list__item--three-line"></li>');
		            	$('#liInformationItem'+i+'').append('<span id="spanLiItem'+i+'" class="mdl-list__item-primary-content"></span>');
		            	if(result.informations[0][i].type_=="Sale")
		                	$('#spanLiItem'+i+'').append('<i class="material-icons mdl-list__item-avatar">local_atm</i>');
		            	else if(result.informations[0][i].type_=="Event")
		                	$('#spanLiItem'+i+'').append('<i class="material-icons mdl-list__item-avatar">event</i>');
		            	else if(result.informations[0][i].type_=="Special offer")
		                	$('#spanLiItem'+i+'').append('<i class="material-icons mdl-list__item-avatar">stars</i>');
		            	else
		                	$('#spanLiItem'+i+'').append('<i class="material-icons mdl-list__item-avatar">bookmark</i>');
		            	$('#spanLiItem'+i+'').append('<span class="type">'+result.informations[0][i].type_+'</span>');
		            	if(result.informations[0][i].date_!="/")
		                	$('#spanLiItem'+i+'').append('<span style="float:right" class="date">'+result.informations[0][i].date_+'</span>');
		            	if(result.informations[0][i].link_=="/")
		                	$('#spanLiItem'+i+'').append('<span class="mdl-list__item-text-body text"><span text>'+result.informations[0][i].text_+'</span></span>');
		            	else
		                	$('#spanLiItem'+i+'').append('<span class="mdl-list__item-text-body text"><span text>'+result.informations[0][i].text_+' </span><a href="'+result.informations[0][i].link_+'">Link</a></span></span>');
		            	$('#liInformationItem'+i+'').append('<span class="mdl-list__item-secondary-content"><a style="curson:hand"class="mdl-list__item-secondary-action" onclick="deleteInformation('+i+')"><i class="material-icons">clear</i></a></span>');  
		             });}
		             console.log(result);
			componentHandler.upgradeAllRegistered();
			 }
		 });
}

function addBLEFirst()
{
   $('#newBLEContent').empty();
   $('#newBLEContent').append('<div id="BLEHeader" class="BLEHeader"></div>');
   $('#newBLEContent').append('<div id="warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');
   $('#BLEHeader').append('<div id="newBLEName" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLEName').append('<input class="mdl-textfield__input"  maxlength="20" id="NewObjectName">');
   $('#newBLEName').append('<label class="mdl-textfield__label" for="NewObjectName">Object name</label>');
   $('#newBLEName').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
   $('#BLEHeader').append('<div id="newBLECity" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLECity').append('<input class="mdl-textfield__input" id="NewObjectCity">');
   $('#newBLECity').append('<label class="mdl-textfield__label" for="NewObjectCity">City</label>');
   $('#BLEHeader').append('<div id="newBLEAddress" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLEAddress').append('<input class="mdl-textfield__input" id="NewDeviceAddress">');
   $('#newBLEAddress').append('<label class="mdl-textfield__label" for="NewDeviceAddress">Address</label>');
   $('#newBLEAddress').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
   $('#BLEHeader').append('<div id="newBLELink" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLELink').append('<input class="mdl-textfield__input" id="NewLink">');
   $('#newBLELink').append('<label class="mdl-textfield__label" for="NewLink">Link</label>');
   $('#BLEHeader').append('<div id="divObjectType" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divObjectType').append('<select id="newTypes" class="mdl-textfield__input" id="type" name="type"></select>');
   $('#newTypes').append('<option value="caffee">caffee</option>');
   $('#newTypes').append('<option value="museum">museum</option>');
   $('#newTypes').append('<option value="restaurant">restaurant</option>');
   $('#newTypes').append('<option value="cinema">cinema</option>');
   $('#newTypes').append('<option value="other">other</option>');
   $('#divObjectType').append('<label class="mdl-textfield__label" for="type">Type</label>');
   componentHandler.upgradeAllRegistered();
}


function addBLESecond()
{
   $('#newBLEContent').empty();
   $('#newBLEContent').append('<div id="BLEHeader" class="BLEHeader"></div>');
   $('#newBLEContent').append('<div id="warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');
   $('#BLEHeader').append('<div id="newBLEDeviceUUID" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLEDeviceUUID').append('<input class="mdl-textfield__input" id="newDeviceUUID">');
   $('#newBLEDeviceUUID').append('<label class="mdl-textfield__label" for="newDeviceUUID">Device UUID</label>');
   $('#newBLEDeviceUUID').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
   $('#BLEHeader').append('<div id="newBLEDeviceMajor" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLEDeviceMajor').append('<input class="mdl-textfield__input" id="newDeviceMajor">');
   $('#newBLEDeviceMajor').append('<label class="mdl-textfield__label" for="newDeviceMajor">Device Major</label>');
   $('#newBLEDeviceMajor').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
   $('#BLEHeader').append('<div id="newBLEDeviceMinor" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#newBLEDeviceMinor').append('<input class="mdl-textfield__input" id="newDeviceMinor">');
   $('#newBLEDeviceMinor').append('<label class="mdl-textfield__label" for="newDeviceMinor">Device Minor</label>');
   $('#newBLEDeviceMinor').append('<span class="mdl-textfield__error">Object name is not right formated!</span>');
   $('#BLEHeader').append('<div id="divBLENewInformation" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divBLENewInformation').append('<textarea class="mdl-textfield__input" maxlength="200" style="resize:none" type="text" rows= "8" id="NewInformation" ></textarea>');
   $('#divBLENewInformation').append('<label class="mdl-textfield__label" for="NewInformation">Information</label>');
   
   componentHandler.upgradeAllRegistered();
}
function addBLEThird()
{
	$('#newBLEContent').empty();
	$('#newBLEContent').append('<div id="warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');   
	$('#newBLEContent').append('<table id="TableUsers" class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" style="display: block;white-space: nowrap"></table>');
    $('#TableUsers').append('<thead><tr><th class="mdl-data-table__cell--non-numeric">#ID</th><th class="mdl-data-table__cell--non-numeric">FIRST NAME</th><th class="mdl-data-table__cell--non-numeric">LAST NAME</th></tr></thead>');       	
    $('#TableUsers').append('<tbody id="tbodyUsers" class="scroll-tbody-y table-body"></tbody>');
    $.getJSON("main",{users:"users"}, function(result){
 	     $.each(result, function(i, field){
         $('#tbodyUsers').append('<tr id="'+result[i].id_+'"></tr>');
         $('#'+result[i].id_+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].id_+'</td>');
         $('#'+result[i].id_+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].first_name_+'</td>');
         $('#'+result[i].id_+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].last_name_+'</td>');
         $('#'+result[i].id_+'').append('<td class="mdl-data-table__cell--non-numeric"></td>');
     	});
     	componentHandler.upgradeAllRegistered(); 
		}); 
}
function addBLEBeacon()
{
	$('#newBLEBeaconContent').empty();
	$('#newBLEBeaconContent').append('<div id="warning2" style="text-align:center; color:deeppink; font-weight:bold"></div>');   
	$('#newBLEBeaconContent').append('<table id="TableBeaconUsers" class="members-list mdl-data-table mdl-js-data-table mdl-shadow--2dp icons-hover" style="margin-left:auto;margin-right:auto;margin-top:30px;"></table>');
	$('#TableBeaconUsers').append('<thead><tr><th class="mdl-data-table__cell--non-numeric">#ID</th><th class="mdl-data-table__cell--non-numeric">FIRST NAME</th><th class="mdl-data-table__cell--non-numeric">LAST NAME</th><th class="mdl-data-table__cell--non-numeric"></th></tr></thead>');       	
	$('#TableBeaconUsers').append('<tbody id="tbodyBeaconUsers"></tbody>');
	$.getJSON("main",{users:"users"}, function(result){
		$.each(result, function(i, field){
        $('#tbodyBeaconUsers').append('<tr id="trBeaconUser'+i+'"></tr>');
        $('#trBeaconUser'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].id_+'</td>');
        $('#trBeaconUser'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].first_name_+'</td>');
        $('#trBeaconUser'+i+'').append('<td class="mdl-data-table__cell--non-numeric">'+result[i].last_name_+'</td>');
        $('#trBeaconUser'+i+'').append('<td class="mdl-data-table__cell--non-numeric"></td>');
        
        });
	});
	componentHandler.upgradeAllRegistered();
}


function addNewMemberContent()
{
   $('#createMemberContent').append('<div id = "warning1" style="text-align:center; color:deeppink; font-weight:bold"></div>');        
   
   $('#createMemberContent').append('<div id="divNewFirstname" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divNewFirstname').append('<input id="newFirstname" class="mdl-textfield__input"  id="NewFirstname">');
   $('#divNewFirstname').append('<label class="mdl-textfield__label" for="NewFirstName">First Name</label>');
   $('#divNewFirstname').append('<span class="mdl-textfield__error">Firstname is not right formated!</span>');
   
   $('#createMemberContent').append('<div id="divNewLastname" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divNewLastname').append('<input id="newLastname" class="mdl-textfield__input"  id="NewLastname">');
   $('#divNewLastname').append('<label class="mdl-textfield__label" for="NewLastName">Last Name</label>');
   $('#divNewLastname').append('<span class="mdl-textfield__error">Lastname is not right formated!</span>');
   
   $('#createMemberContent').append('<div id="divNewUsername" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divNewUsername').append('<input id="newUsername" class="mdl-textfield__input" pattern="[A-Za-z]*([A-Za-z]+)?" id="NewUserName">');
   $('#divNewUsername').append('<label class="mdl-textfield__label" for="NewUserName">User Name</label>');
   $('#divNewUsername').append('<span class="mdl-textfield__error">Username is not right formated!</span>');
   
   $('#createMemberContent').append('<div id="divNewPassword" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">');
   $('#divNewPassword').append('<input id="newPassword" class="mdl-textfield__input" pattern="[A-Za-z]*([A-Za-z0-9]+)?" id="NewPassword">');
   $('#divNewPassword').append('<label class="mdl-textfield__label" for="NewPassword">Password</label>');
   $('#divNewPassword').append('<span class="mdl-textfield__error">Password is not right formated!</span>'); 
   
   $('#createMemberContent').append('<div id="divNewEmail" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divNewEmail').append('<input id="newEmail" class="mdl-textfield__input"  id="NewEmail">');
   $('#divNewEmail').append('<label class="mdl-textfield__label" for="NewEmail">E-Mail</label>');
   $('#divNewEmail').append('<span class="mdl-textfield__error">E-Mail is not right formated!</span>');
   
   $('#createMemberContent').append('<div id="divNewRole" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"></div>');
   $('#divNewRole').append('<select id="newRoles" class="mdl-textfield__input" id="role" name="role"></select>');
   $('#newRoles').append('<option value="user">user</option>');
   $('#newRoles').append('<option value="admin">admin</option>');
   $('#divNewRole').append('<label class="mdl-textfield__label" for="role">Role</label>');
   
   componentHandler.upgradeAllRegistered();
}




function UpdateProfile(){
	$.getJSON("main",{memberSession:"member"}, function(result){
		$('#profileMember').empty();
		$('#profileMember').append('<div id="profileMemberCard"class="mdl-card mdl-shadow--2dp" style="width:730px;"></div>'); 
		$('#profileMemberCard').append('<div id="profileCardTitle" class="mdl-card__title mdl-card--expand"></div>');
		$('#profileCardTitle').append('<h2 class="mdl-card__title-text">Profile</h2>');
		$('#profileMemberCard').append('<div id = "warning" style="text-align:center; color:deeppink; font-weight:bold"></div>');  
		
		$('#profileMemberCard').append('<div id="profileMemberInformation" class="mdl-card__supporting-text" style="height:220px;"></div>');
		$('#profileMemberInformation').append('<div id="divProfileFirstName" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  input"></div>');
		$('#divProfileFirstName').append('<input class="mdl-textfield__input" type="text" id="firstNameProfile" value="'+result.first_name_+'">');
		$('#divProfileFirstName').append('<label class="mdl-textfield__label" for="firstNameProfile">First name...</label>');	    
		$('#profileMemberInformation').append('<div id="divProfileLastName" class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  input"></div>');
		$('#divProfileLastName').append('<input class="mdl-textfield__input" type="text" id="lastNameProfile" value="'+result.last_name_+'"> ');
		$('#divProfileLastName').append('<label class="mdl-textfield__label" for="lastNameProfile">Last name...</label>');	    
		$('#profileMemberInformation').append('<div id="divProfileUsername"	 class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  input"></div>');   
		$('#divProfileUsername').append('<input class="mdl-textfield__input" type="text" id="usernameProfile" value="'+result.username_+'" disabled>');
		$('#divProfileUsername').append('<label class="mdl-textfield__label" for="usernameProfile">Username...</label>');	    
		$('#profileMemberInformation').append('<div id="divProfilePassword"	 class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  input"></div>');   
		$('#divProfilePassword').append('<input class="mdl-textfield__input" type="text" id="passwordProfile" value="'+result.password_+'">');
		$('#divProfilePassword').append('<label class="mdl-textfield__label" for="passwordProfile">Password...</label>');	    
		$('#profileMemberInformation').append('<div id="divProfileEmail"	 class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  input"></div>');   
		$('#divProfileEmail').append('<input class="mdl-textfield__input" type="text" id="emailProfile" value="'+result.email_+'">');
		$('#divProfileEmail').append('<label class="mdl-textfield__label" for="emailProfile">Email...</label>');	    
		$('#profileMemberCard').append('<div id="saveProfile" class="mdl-card__actions mdl-card--border" style="text-align: center"></div>');
		$('#saveProfile').append('<a onclick="reloadSaveProfile()" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent"style="margin:2px">Save</a>');
		componentHandler.upgradeAllRegistered();
	});
	
}



function showAdminBLEs(){
	$("#membersAdmin").hide();
	$(".addMember").hide();
	$("#profileMember").hide();
	$("#BLEs").show();
	$(".addBLE").show();
	BLEsUpdate();
}

function showBLEs(){
	$("#profileMember").hide();
	$("#BLEs").show();
	BLEsUpdate();
}

function showProfile(){
    $("#BLEs").hide();
    $(".addBLE").hide();
    $(".addMember").hide();
	$("#membersAdmin").hide();
    $("#profileMember").show();
	UpdateProfile();
}

function showMembers(){
    $("#BLEs").hide();
    $("#profileMember").hide();
    $(".addBLE").hide();
    $("#membersAdmin").show();
	$(".addMember").show();
	updateMembers();
}
jQuery(document).ready(function($){
	
	$.getJSON("login",{session:"session"}, function(result){
		if(result.role=="admin" || result.role=="superadmin"){
			if(result.role=="superadmin"){
				$(".superadmin").hide();
			}
		    $(".admin").show();
		    showAdminBLEs();
		}
		else{
			$(".addMember").hide();
			$(".addBLE").hide();
		    $(".user").show();
		    showBLEs();
		}	
	});
});


</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Main</title>
</head>
<body>

	<dialog class="mdl-dialog updateBLEBeacon" style="width:700px; height:550px">
		<h4 class="mdl-dialog__title" style="color:rgb(0,128,128)">Update BLE Beacon</h4>
 		<div class="mdl-dialog__content" id="BLEBeaconUpdate" style="height:400px;"></div>
 		<div class="mdl-dialog__actions">
  				<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent save">Save</button>
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close5">Close</button>
    		</div>
		</div>
	</dialog>
	
	<dialog class="mdl-dialog updateBLEBeaconMember" style="width:750px; height:640px">
		<h4 class="mdl-dialog__title" id="nameOfBLE" style="color:rgb(0,128,128)"></h4>
 		<div class="mdl-dialog__content" id="BLEBeaconUpdateMember" style="height:500px;"></div>
 		<div class="mdl-dialog__actions">
  				<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent save1">Save</button>
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close6">Close</button>
        </div>
	</dialog>
	
	
	 <dialog class="mdl-dialog newBLE" style="width:400px">
     	<h4 id="nameOfNewBLE" class="mdl-dialog__title" style="color:rgb(0,128,128)">BLE</h4> 
     	<div class="mdl-dialog__content" >
     		<div id="newBLEContent" style="margin-bottom:10px; height:435px; overflow:auto"></div> 
	 		
    		<div class="first" style=" text-align: center;">
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent next">Next</button>
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close1">Close</button>
    		</div>
    		<div class="second" style=" text-align: center;">
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent next2">Next</button>
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close2">Close</button>
    		</div>
    		<div class="third" style=" text-align: center;">
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent finish">Finish</button>
          		<button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close3">Close</button>
    		</div>
    	</div>
    </dialog>
    
	<dialog class="mdl-dialog newMember">
        <h4 class="mdl-dialog__title" style="color:rgb(0,128,128)">New Member</h4>
        <div class="mdl-dialog__content" id="createMemberContent">       
        </div>
        <div class="mdl-dialog__actions">
          <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent save2">Save</button>
          <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close">Close</button>
        </div>
    </dialog>
	<dialog class="mdl-dialog editmember">
		<h4 class="mdl-dialog__title" style="color:rgb(0,128,128)">Edit member</h4>
 		<div class="mdl-dialog__content" id="editMemberContent" style="height:300px;"></div>
		<div class="mdl-dialog__actions">
  			<button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent save3">Save</button>
  			<button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent close4">Close</button>
		</div>
	</dialog>
	<dialog class = "deleteMember" style="border:2px;">
    	<div style="color:rgb(0,128,128);text-align:center; font-weight:bold; margin-bottom:35px;font-size:16px;">Are you sure you want to delete this member?</div>
    	<button type="button" class="NoToDeleteMember mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" style="float:right;margin-left:10px;">NO</button>
    	<button type="button" class="yesToDeleteMember mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" style="float:right;margin-left:10px;">YES</button>
	</dialog>
	
	<dialog class = "deleteBLEBeacon" style="border:2px;">
    	<div style="color:rgb(0,128,128);text-align:center; font-weight:bold; margin-bottom:35px;font-size:16px;">Are you sure you want to delete this BLE Beacon?</div>
    	<button type="button" class="NoToDeleteBLEBeacon mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" style="float:right;margin-left:10px;">NO</button>
    	<button type="button" class="yesToDeleteBLEBeacon mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" style="float:right;margin-left:10px;">YES</button>
	</dialog>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-drawer
                mdl-layout--fixed-header">
      <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
        <button style="margin-top:25px;display:none" onclick="newBLE()" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored addBLE">
  			<i class="material-icons">add</i>
		</button>
		<button style="margin-top:25px;display:none" onclick="newMember()" class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored addMember">
  			<i class="material-icons">add</i>
		</button>
          <div class="mdl-layout-spacer"></div>
          
      <nav class="mdl-navigation">
         <button class="button-sign-out mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--accent" onclick="logOut()">Logout <i class="material-icons">exit_to_app</i></button>
      </nav>
    </div>
      </header>
      <div class="mdl-layout__drawer">
	  	<span class="mdl-layout-title">BLE Beacon</span>
	    	<nav class="mdl-navigation admin" style="display:none">
	      		<a class="mdl-navigation__link" href='javascript:;' onclick="showAdminBLEs()">BLEs</a>
	      		<a class="mdl-navigation__link superadmin" href='javascript:;' onclick="showProfile()">Profile</a>
	       		<a class="mdl-navigation__link" href='javascript:;' onclick="showMembers()">Members</a>
      		</nav>
      		<nav class="mdl-navigation user" style="display:none">
	      		<a class="mdl-navigation__link" href='javascript:;' onclick="showBLEs()">BLEs</a>
	      		<a class="mdl-navigation__link" href='javascript:;' onclick="showProfile()">Profile</a>
	       	</nav>
  	</div>
  	<main class="mdl-layout__content">
	    <div class="page-content admin">
	    	<div id="membersAdmin" style="display:none">
	    		
	    		<table class="members-list mdl-data-table mdl-js-data-table mdl-shadow--2dp icons-hover" style="margin-left:auto; 
    margin-right:auto;margin-top:30px;">    
            		<thead>
           	 			<tr>
              				<th class="mdl-data-table__cell--non-numeric">#ID</th>
              				<th class="mdl-data-table__cell--non-numeric">FIRST NAME</th>
              				<th class="mdl-data-table__cell--non-numeric">LAST NAME</th>
              				<th class="mdl-data-table__cell--non-numeric">E-MAIL</th>
              				<th class="mdl-data-table__cell--non-numeric">ROLE</th>
              				<th colspan="2" align="right"></th>    
             			</tr>
          			</thead>
          			<tbody id="tbodyMembers"></tbody>
        		</table>
	    	</div>
	    	<div id="BLEs" style="display:none"></div>
	    	<div id="profileMember" style="margin-left: 200px;  justify-content: center;align-items: center;margin-top:50px;display:none">
	    		
	    </div>
	    </div>
  </main>
</div>  
<script>

var dialog = document.querySelector(".updateBLEBeacon");
if (! dialog.showModal) {
	dialogPolyfill.registerDialog(dialog);
}
dialog.querySelector('.close5').addEventListener('click', function() {
    dialog.close();
});
dialog.querySelector('.save').addEventListener('click', function() {
    var nameOfObject = $("#updateObjectName").val();
	var city = $("#updateObjectCity").val();
    var address = $("#updateDeviceAddress").val();
    var deviceUUID = $("#updateDeviceUUID").val();
    var deviceMajor = $("#updateDeviceMajor").val();
    var deviceMinor = $("#updateDeviceMinor").val();
	var link=$("#updateLink").val();
	var information=$("#updateInformation").val();
    
    if(city==""  ||  address=="" || deviceUUID==""|| deviceMajor=="" || deviceMinor=="" || link==""  || information=="") {
    	document.getElementById("warning2").innerHTML = "Some fields are empty";
        return;
    }
    var exists;
    $.getJSON("main",{"deviceUUID":deviceUUID,"deviceMajor":deviceMajor,"deviceMinor":deviceMinor,"updatenameOfObject":nameOfObject}, function(result){
    	  if(result.exists[0]=="true")
    		{
 		   		document.getElementById("warning2").innerHTML = "Device with UUID,Major and Minor aleady exists !!";
    			exists="true";
    			return;
    		}
    	  else
    			exists="false";
    });
    if(exists=="true")
  	  return;
    
    UpdateObject={id:idBle,city:""};
    Device={address:"",UUID:"",Major:"",Minor:""};
    Information={link:"",information:""};
    UpdateObject.city=city;
    Device.address=address;
	Device.UUID=deviceUUID;
	Device.Minor=deviceMinor;
	Device.Major=deviceMajor;
	Information.link=link;
	Information.information=information;
	var NewBLEBeacon={"BLEObject":UpdateObject,"Device":Device,"Information":Information};
	var json=JSON.stringify(NewBLEBeacon);
	$.post( "main", { "updateBLEBeacon": json } );
	BLEsUpdate();
    dialog.close();
});

var dialog1 = document.querySelector(".newBLE");
if (! dialog1.showModal) {
	dialogPolyfill.registerDialog(dialog1);
}
dialog1.querySelector('.close1').addEventListener('click', function() {
    dialog1.close();   
});
dialog1.querySelector('.close2').addEventListener('click', function() {
    dialog1.close();   
});
dialog1.querySelector('.close3').addEventListener('click', function() {
    dialog1.close();   
});
dialog1.querySelector('.finish').addEventListener('click', function() {
	var BLEUsers = new Array();
	var numOfUsers = 0;
	$("#TableUsers tr").each(function() {
    	if($('#'+this.id+'').hasClass( "is-selected" )==true){
    		var id ={"id":this.id};
    		BLEUsers.push(id);
    		++numOfUsers;
    	}
	});
	if(numOfUsers==0){
		document.getElementById("warning2").innerHTML = "You must select at least one user!!";
		return;
	}
	var NewBLEBeacon={"BLEObject":BLEObject,"Device":Device,"Information":Information,"users":BLEUsers};
	var json=JSON.stringify(NewBLEBeacon);
	$.post( "main", { "newBLEBeacon": json } );
	BLEsUpdate();
	dialog1.close();   
});
var BLEObject,Device;
$(".next").click(function() {
    var name = $("#NewObjectName").val();
    var city = $("#NewObjectCity").val();
    var address = $("#NewDeviceAddress").val();
	var link=$("#NewLink").val();
    var type = $("#newTypes").val();
    if(name=="" || city==""  || type=="" || address=="" || link=="") {
    	document.getElementById("warning2").innerHTML = "Some fields are empty";
        return;
    }
    
    var exists;
    $.getJSON("main",{objectName:name}, function(result){
    	  if(result.exists[0]=="true")
    		{
 		   		document.getElementById("warning2").innerHTML = "Name of Object already exists !!";
    			exists="true";
    			return;
    		}
    	  else
    			exists="false";
    });
    if(exists=="true")
  	  return;
    BLEObject={name:"",city:"",type:""};
    Device={address:"",UUID:"",Major:"",Minor:""};
    Information={link:"",information:""};
    BLEObject.name=name;
    BLEObject.city=city;
    BLEObject.type=type;
    Device.address=address;
    Information.link=link;
    $(".first").css('display','none');
    $(".second").css('display','block');
    addBLESecond();
});

$(".next2").click(function() {
	var deviceUUID = $("#newDeviceUUID").val();
	var deviceMajor = $("#newDeviceMajor").val();
	var deviceMinor = $("#newDeviceMinor").val();
	var information=$("#NewInformation").val();
	if(deviceUUID=="" || deviceMinor=="" ||deviceMajor=="" || information=="") {
        	document.getElementById("warning2").innerHTML = "Some fields are empty";
            return;
        }
	var exists;
    $.getJSON("main",{"deviceUUID":deviceUUID,"deviceMajor":deviceMajor,"deviceMinor":deviceMinor}, function(result){
    	  if(result.exists[0]=="true")
    		{
    		  document.getElementById("warning2").innerHTML = "Device with UUID,Major and Minor aleady exists !!";
    		  exists="true";
    		  return;
    		}
    	  else
    			exists="false";
    });
    if(exists=="true")
  	  return;
    
	Device.UUID=deviceUUID;
	Device.Major=deviceMajor;
	Device.Minor=deviceMinor;
	Information.information=information;
	$(".second").css('display','none');
	$(".third").css('display','block');
	addBLEThird();
});

function newBLE(){
    addBLEFirst();
	dialog1.showModal();
	BLEObject={name:"",city:"",type:""};
    Device={address:"",UUID:"",Major:"",Minor:""};
    Information={link:"",information:""};
	$(".first").css('display','block');
	$(".second").css('display','none');
	$(".third").css('display','none');
}
var dialog2 = document.querySelector(".newMember");
if (! dialog2.showModal) {
	dialogPolyfill.registerDialog(dialog2);
}
dialog2.querySelector('.close').addEventListener('click', function() {
    dialog2.close();   
});

dialog2.querySelector('.save2').addEventListener('click', function() {
	NewMember={firstname:"",lastname:"",username:"",password:"",email:"",role:""};
    var newFirstname = $("#newFirstname").val();
    var newLastname = $("#newLastname").val();
    var newUsername = $("#newUsername").val();
    var newPassword = $("#newPassword").val();
    var newEmail = $("#newEmail").val();
    var newRoles = $("#newRoles").val();
    if(newUsername=="" || newFirstname=="" || newLastname=="" || newEmail=="" || newPassword=="")
    {
    	document.getElementById("warning1").innerHTML = "Some fields are empty";
    	return;
    }
    NewMember.firstname=newFirstname;
    NewMember.lastname=newLastname;
    NewMember.username=newUsername;
    NewMember.password=newPassword;
    NewMember.email=newEmail;
    NewMember.role=newRoles;
    var json=JSON.stringify(NewMember);
    var exists;
    $.getJSON("main",{username:NewMember.username}, function(result){
    	  if(result.exists[0]=="true")
    		{
 		   		document.getElementById("warning1").innerHTML = "Username already exists !!";
    			exists="true";
    			return;
    		}
    	  else
    			exists="false";
    });
    if(exists=="true")
  	  return;
    $.post( "main", { "newMember": json } );
  	updateMembers();
  	dialog2.close();
});
function newMember(){
	ble={name:""};
	$( "#createMemberContent").empty();
    addNewMemberContent();  
    dialog2.showModal();
}
var dialog3 = document.querySelector(".editmember");
if (! dialog3.showModal) {
	dialogPolyfill.registerDialog(dialog3);
}
dialog3.querySelector('.close4').addEventListener('click', function() {
    dialog3.close();
});

dialog3.querySelector('.save3').addEventListener('click', function() {
    EditMember={username:"",firstname:"",lastname:"",email:"",password:""};
    var editFirstname = $("#editFirstname").val();
    var editLastname = $("#editLastname").val();
    var editUsername = $("#editUsername").val();
    var editPassword = $("#editPassword").val();
    var editEmail = $("#editEmail").val();
     
    if(editUsername=="" || editFirstname=="" || editLastname=="" || editEmail=="" || editPassword==""){
              document.getElementById("warning3").innerHTML = "Some fields are empty";
               return;
    }
    EditMember.firstname=editFirstname;
    EditMember.lastname=editLastname;
    EditMember.username=editUsername;
    EditMember.password=editPassword;
    EditMember.email=editEmail;
    var json=JSON.stringify(EditMember);
    $.ajax({
  	  method: "POST",
  	  data: { "UpdateMember": json }
  	})
  	updateMembers();
    dialog3.close();
  });
function reload(){
    $( "#editMemberContent").empty();
    EditMemberContent(this.id); 
    dialog3.showModal();
}
var dialog4 = document.querySelector(".deleteMember");
if (! dialog4.showModal) {
	dialogPolyfill.registerDialog(dialog4);
}
dialog4.querySelector('.yesToDeleteMember').addEventListener('click', function() {
    	$.ajax({url:"main",method: 'POST',data:{DeleteMember:deleteMemeberId}});
    		updateMembers();
dialog4.close();
});
dialog4.querySelector('.NoToDeleteMember').addEventListener('click', function() {
dialog4.close();
});

var dialog5 = document.querySelector(".deleteBLEBeacon");
if (! dialog5.showModal) {
	dialogPolyfill.registerDialog(dialog5);
}
dialog5.querySelector('.yesToDeleteBLEBeacon').addEventListener('click', function() {
    	$.ajax({url:"main",method: 'POST',data:{DeleteBLEBeacon:deleteBLEBeaconId}});
    	BLEsUpdate();
dialog5.close();
});
dialog5.querySelector('.NoToDeleteBLEBeacon').addEventListener('click', function() {
dialog5.close();
});

var dialog6 = document.querySelector(".updateBLEBeaconMember");
if (! dialog6.showModal) {
	dialogPolyfill.registerDialog(dialog6);
}
dialog6.querySelector('.close6').addEventListener('click', function() {
    dialog6.close();
});
dialog6.querySelector('.save1').addEventListener('click', function() {
	 var informations = new Array();
     var id=0;
      while(document.getElementById('liInformationItem'+id+'')!=null && typeof(document.getElementById('liInformationItem'+id+''))!=undefined){
          var Information ={text:"",link:"",date:"",type:""};
          var li = document.getElementById("liInformationItem"+id+"");
          var textSpan = jQuery('span.text', li);
          var text = jQuery('span',textSpan).text();
          var link = jQuery('a',textSpan);
          var type = jQuery('span.type', li).text();
          var date = jQuery('span.date', li).text();
          Information.type = type;
          Information.text = text;
          console.log("Type: "+type+" Text:"+text);
          if(date!=""){
              var Date ={exists:"true",date:date};
              Information.date = Date;
              console.log("Date:"+date);
          }
          else{
              var Date ={exists:"false"};
              Information.date = Date;
          }
          if(link.attr("href")!=undefined){
             console.log("Link:"+link.attr("href"));
             var Link = {exists:"true",link:link.attr("href")};
             Information.link = Link;
          }
          else{
             var Link = {exists:"false"};
              Information.link = Link;
          }
          informations.push(Information);
          ++id;
      }
      var updateBeacon;
      if(informations.length>0)
         updateBeacon = {"nameOfObject":updateBLEBeacon,"Informations":informations,"update":"yes"};
  	 else 
          updateBeacon = {"nameOfObject":updateBLEBeacon, "update":"no"};
      var json=JSON.stringify(updateBeacon);
  	 console.log(json);
      $.post( "main", { "updateBLEBeacon": json } );
    dialog6.close();
});


</script>
</body>
</html>