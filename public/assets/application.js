function insertMarkup(a,b){switch(b){case"image":var c=$(a).prevAll("a").attr("href"),d="<img src='"+c+"' />",e=$("#post_content");e.insertAtCaret(d);break;case"carousel":var f=$(a).prevAll("textarea"),d='<div class="post-carousel"> </div>';$(f).insertAtCaret(d);break;case"superscript":var d="<sup> </sup>",f=$(a).prevAll("textarea");$(f).insertAtCaret(d);break;case"code":var d="~~~ lang     ~~~",f=$(a).prevAll("textarea");$(f).insertAtCaret(d)}}$(function(a){a("form a.add_nested_fields").live("click",function(){var b=a(this).attr("data-association"),c=window[b+"_fields_blueprint"],d=a(this).attr("data-insert-node")||this,e=a(this).attr("data-insert-position")||"before",f=(a(this).closest(".fields").find("input:first").attr("name")||"").replace(new RegExp("[[a-z]+]$"),"");if(f){var g=f.match(/[a-z_]+_attributes/g)||[],h=f.match(/(new_)?[0-9]+/g)||[];for(var i=0;i<g.length;i++)h[i]&&(c=c.replace(new RegExp("(_"+g[i]+")_.+?_","g"),"$1_"+h[i]+"_"),c=c.replace(new RegExp("(\\["+g[i]+"\\])\\[.+?\\]","g"),"$1["+h[i]+"]"))}var j=new RegExp("new_"+b,"g"),k=(new Date).getTime();c=c.replace(j,"new_"+k),d=a(this).closest("form").find(d);switch(e){case"before":var l=a(c).insertBefore(d);break;case"after":var l=a(c).insertAfter(d);break;case"top":var l=a(c).prependTo(d);break;case"bottom":var l=a(c).appendTo(d);break;default:var l=a(c).insertBefore(this)}return a(this).closest("form").trigger("nested:fieldAdded",l),!1}),a("form a.remove_nested_fields").live("click",function(){var b=a(this).prev("input[type=hidden]")[0];b&&(b.value="1");var c=a(this).closest(".fields").hide();return a(this).closest("form").trigger("nested:fieldRemoved",c),!1})}),$(document).ready(function(){$(".post-carousel").each(function(){var a=$('<div id="nav"></div>').insertAfter(this);$(this).cycle({fx:"scrollRight",speed:300,timeout:0,pager:a})})}),$(document).ready(function(){$("#post_category_id").change(function(){$(this).val()=="1"?$("#citations").fadeIn(300):($("#citations :input").val(""),$("#citations").fadeOut(300))}),$.fn.extend({insertAtCaret:function(a){return this.each(function(b){if(document.selection)this.focus(),sel=document.selection.createRange(),sel.text=a,this.focus();else if(this.selectionStart||this.selectionStart=="0"){var c=this.selectionStart,d=this.selectionEnd,e=this.scrollTop;this.value=this.value.substring(0,c)+a+this.value.substring(d,this.value.length),this.focus(),this.selectionStart=c+a.length,this.selectionEnd=c+a.length,this.scrollTop=e}else this.value+=a,this.focus()})}})})