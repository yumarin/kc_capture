(function(){
 if(window.__KC_CAPTURE__) return;
 window.__KC_CAPTURE__ = true;

 const targets=[
  "/kcsapi/api_port/port",
  "/kcsapi/api_get_member/require_info"
 ];

 function capture(url,body){
  try{
   window.webkit.messageHandlers.apiCapture.postMessage({
    url:url,
    body:body
   });
  }catch(e){}
 }

 const oldFetch=window.fetch;
 window.fetch=function(...args){
  return oldFetch.apply(this,args).then(r=>{
   let url=typeof args[0]=="string"?args[0]:args[0].url;
   if(r.ok && targets.some(x=>url.includes(x))){
    r.clone().text().then(t=>capture(url,t));
   }
   return r;
  });
 };

 const oldOpen=XMLHttpRequest.prototype.open;
 const oldSend=XMLHttpRequest.prototype.send;

 XMLHttpRequest.prototype.open=function(m,u){
  this.__kc_url=u;
  return oldOpen.apply(this,arguments);
 };

 XMLHttpRequest.prototype.send=function(){
  this.addEventListener("load",()=>{
   if(this.__kc_url && targets.some(x=>this.__kc_url.includes(x))){
    capture(this.__kc_url,this.responseText);
   }
  });
  return oldSend.apply(this,arguments);
 };
})();