import localStoragePorts from '../elm-local-storage-ports/src/local-storage-ports.js';
import Elm from './elm-app.js';

var myElmApp = Elm.Main.embed(document.getElementById("app"));

localStoragePorts.register(myElmApp.ports);
