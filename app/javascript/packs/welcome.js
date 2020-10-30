// <script type="text/javascript">
  var n=1,x=0,c=0;
    var z=[],k=[];
    var colors=[];
    colors[0]="#C88F24";
    colors[1]="#2546DF";
    colors[2]="#12AC6C";
    colors[3]="#3545BC";
    colors[4]="#C9BD0C";
    colors[5]="#0096F5";
    function theEnd(){
    var mbox = document.getElementById("m-box");
    mbox.style.animation="lightSpeedOut 2s ease-in 1 0s";
    mbox.style.animation="flipOutY 2s ease-in 1 0s";
    mbox.style.animationFillMode="forwards";
    }
    function lastShow(){
        var name = document.getElementById("name").value;
        var ibox = document.getElementById("inputBox");
        var writex = document.getElementById("writex");
        var subtext = document.getElementById("subtext");
        ibox.style.visibility="hidden";
        subtext.innerHTML =name;
        writex.style.transition='0.5s ease all';
        writex.style.opacity=2;
        writex.style.top='20px';
        writex.style.transform='scale(1)';    
        setTimeout('theEnd()',3000);
    }
    function printName(){
        var ibox = document.getElementById("inputBox");
        ibox.style.animation="bounceOutLeft 2s ease-in 1 0.5s";
        ibox.style.animationFillMode="forwards";
        setTimeout('lastShow()',2000);
    }
    function ibox(){
        var ibox = document.getElementById("inputBox");        
        ibox.style.top="20px";
    }
    function animate_msg(){
        var innertext = document.getElementById("innerText");
        innertext.style.transition="0.5s ease all";
        innertext.style.animation="rotateOut 1s ease 1 0s";
        innertext.style.animationFillMode="forwards";
        innertext.style.visibility="hidden";
        stopper = setTimeout('ibox()',700);
    }
    function player(){
        var shutter = document.getElementById("shutter");
        var msgtext    = "Hi.My name is Magic Box. My creator is Shivam.. LETs PLAY Can I have your name please...";
        var writor = document.getElementById("innerText");
        if(n==1){
            for(var i=0;i<=msgtext.length;i++){
                z[i]=msgtext.substr(i,1);
            }
            shutter.style.visibility="hidden";
            n=2;
        }
        if(n==2){
            if(c==6){c=0;}
            if(x==3){
                writor.innerHTML+="<br>";
            }
            if(x==47 || x==57){
                writor.innerHTML+="<br><br>";
            }
            writor.style.color=colors[c];
            c=c+1;
            writor.innerHTML += z[x];
            x=x+1;
            animate = setTimeout('player()',50);
            if(x==msgtext.length){
                clearTimeout(animate);
                setTimeout('animate_msg()',2000);
            }
        }
    }
    function openShutter(){
        var shutter = document.getElementById("shutter");
        shutter.style.animation="flipOutX 1s ease-in 1 0s";
        shutter.style.animationFillMode="forwards";
        setTimeout('player()',2000);
    }
// </script>