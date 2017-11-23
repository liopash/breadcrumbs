let veta = '#####################                  ##   x    ###       ##  #          #    ##                  ##       #          ##                  #####################';
let mapka = veta.split("")
let mapDiv = document.getElementById('map');
let posOld;

let filler = () => {

    let rX = Math.round(Math.random() * 2) - 1;
    let rY = Math.round(Math.random() * 2) - 1;
    let pos = veta.indexOf('x') + rX + 20 * rY;

    if (mapka[pos] != '#' || posOld == pos) {
        mapka[veta.indexOf('x')] = ' ';
        mapka[pos] = 'x';
        posOld = pos;
    }

    veta = mapka.join("")
    return mapDiv.innerHTML = `<PRE>${veta.match(/.{20}/g).join("</br>")}</PRE>`;

}