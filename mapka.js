let veta =
	'##################################################                                      #        ##                  ë                   #        ##             ###############          #        ##                                               ##     #                                         ##                            #                  ##             #              #                  ##                            ######             ##                                               ##      #######                            ########                     #       #                 ##                   o                           ##                                               ##################################################';
let mapka = veta.split('');
let mapDiv = document.getElementById('map');
let posOld;

let walker = () => {
	let rX = Math.round(Math.random() * 2) - 1;
	let rY = Math.round(Math.random() * 2) - 1;
	let pos = veta.indexOf('ë') + rX + 49 * rY;

	if (mapka[pos] == 'o') {
		veta = mapka.join('');
		clearInterval(intervale);
		return (mapDiv.innerHTML = `<PRE>${veta.match(/.{49}/g).join('</br>')}</br>Zradloooooo!!!!</PRE>`);
	}

	if (mapka[pos] != '#' || posOld == pos) {
		mapka[veta.indexOf('ë')] = ' ';
		mapka[pos] = 'ë';
		posOld = pos;
	}

    veta = mapka.join('');
   
    return (mapDiv.innerHTML = `<PRE>${veta.match(/.{49}/g).join('</br>')}</PRE>`);
    
};

function interval() {
    intervale = setInterval(walker, 100);
}

let intervale = setInterval(walker, 100);

