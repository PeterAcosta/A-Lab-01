


function getFontSizeBase() {
    var elemento = document.querySelector('html');
    // Obtener el valor de una propiedad CSS
    var valorPropiedad = window.getComputedStyle(elemento).getPropertyValue("font-size");

    var primerRenglon  = "El valor de la propiedad base font-size:" + valorPropiedad;
    var segundoRenglon = "1 rem = "+valorPropiedad;
    
    var miParrafo = document.getElementById("root-data");
    miParrafo.innerHTML = primerRenglon + "<br>" + segundoRenglon;


    return{valorPropiedad}
}

function obtenerMedidasMonitor() {
    const ancho = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    const alto = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    return { ancho, alto };
}




function writeValues(){
    const medidasMonitor = obtenerMedidasMonitor();
    const fontSizeBase   = getFontSizeBase();

    var line_1 = `Ancho: ${medidasMonitor.ancho}px, Alto: ${medidasMonitor.alto}px`;
    var line_2 = "El valor de la propiedad base font-size:" + fontSizeBase.valorPropiedad;
    var line_3 = "1 rem = " + fontSizeBase.valorPropiedad;
    var parrafo = line_1 + "<br>" + line_2 + "<br>" + line_3

    var miParrafo = document.getElementById("root-data");
    miParrafo.innerHTML = parrafo;

    console.log(parrafo);
}
