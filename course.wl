(* ::Package:: *)

genCookies[con_,date_]:={<|"Domain"->"xkgo.ucas.ac.cn","Path"->"/","Name"->"session_id","Content"->con,"ExpirationDate"->DateObject[date]|>};
url="http://xkgo.ucas.ac.cn:3000/courseManage/selectCourse";
headers={"Content-Type"->"application/x-www-form-urlencoded"};
cc="1800840705XXXXXXXX";(*set your course ID here*)
data=<|"type"->"","deptIds1"->"&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=0&deptIds=910&deptIds=911&deptIds=957&deptIds=912&deptIds=928&deptIds=913&deptIds=914&deptIds=921&deptIds=951&deptIds=952&deptIds=958&deptIds=917&deptIds=945&deptIds=927&deptIds=964&deptIds=915&deptIds=954&deptIds=955&deptIds=959&deptIds=946&deptIds=961&deptIds=962&deptIds=963&deptIds=968&deptIds=969&deptIds=970&deptIds=971&deptIds=972&deptIds=967&deptIds=973&deptIds=974&deptIds=975&deptIds=976&deptIds=977&deptIds=987&deptIds=989&deptIds=950&deptIds=965&deptIds=990&deptIds=988&deptIds=993","courseType1"->"","courseCode"->cc,"courseName"->""|>;
ck=genCookies["XXXXXXX-XXXXX-XXXX-XXXX-XXXXXXXXXXXX","2025-XX-XXXXXXXXXXX"];(*set your cookies here*)
req=HTTPRequest[url,<|"Method"->"POST","Body"->data,"Headers"->headers,"Cookies"->ck|>];
times=0;
ntfy[msg_]:=URLExecute@HTTPRequest["https://ntfy.sh/XXXXXXXXX",<|"Method"->"POST","Body"->ToString[msg]|>];(*set how you want to be notified.*)
msg[msg_]:=URLExecute@HTTPRequest["https://ntfy.sh/XXXXXXXXXXX",<|"Method"->"POST","Body"->ToString[msg]|>];(*set how you want to be msg.*)
msg["Start WATCHING"];(*refresh and watch every 60s*)
Until[(!idx)||(sc=={}),sc=StringCases[URLRead[req]["Body"],{"<td><a href=\"https://xkcts.ucas.ac.cn:8443/course/coursetime/"~~NumberString~~Shortest[__]~~">"~~Name:Shortest[__]~~"</a></td>":>Name,"<td><span id=\"courseCredit"~~Shortest[__]~~"<td>"~~Max:NumberString~~"</td>"~~Shortest[__]~~"<td"~~Shortest[__]~~Sel:NumberString~~"</td>":>StringJoin[{"Max:",Max,"\t Sel:",Sel,"\t Full:",ToString[idx=(Max==Sel)]}]}];If[(idx)&&(sc!={}),Pause[60]];times=times+1;If[Mod[times,60]==0,msg["Time:"<>ToString[times]<>"Get web:"<>sc<>"Is abaliable:"<>!idx];];]
If[(sc=={}),ntfy["!!!AUTH ERROR!!!"];Print["!!!AUTH ERROR!!!"];];
If[!idx,ntfy["###COURSE AVALIABLE###\nhttp://xkgo.ucas.ac.cn:3000/courseManage/selectCourse"];ntfy[cc];];
Print["Get web:",sc,"Course is abaliable:",!idx];

