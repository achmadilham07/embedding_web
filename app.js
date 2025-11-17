window.onload = function () {

    // Set default selected value to "red"
    const selectElement = document.getElementById('color-dropdown');
    selectElement.value = 'red';

    // START FLUTTER BUILD

    // Get the embedding target element
    const embeddingTarget = document.querySelector("#embed");

    // Setup mainJsPath for run flutter web
    _flutter.buildConfig = {
        "builds": [
            {
                "mainJsPath": "./flutter/build/web/main.dart.js",
            }
        ]
    };

    // Setup asset base where the flutter app folder exist
    // and put the app on embedding target
    const config = {
        "assetBase": "./flutter/build/web/",
        "hostElement": embeddingTarget,
    };

    // Load the flutter app
    _flutter.loader.load({
        config: config,
    });
    // END FLUTTER BUILD
}