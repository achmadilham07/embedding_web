window.onload = function () {

    // Set default selected value to "red"
    const selectElement = document.getElementById('color-dropdown');
    selectElement.value = 'red';
    changeDropdownColor('red');

    selectElement.addEventListener('change', function (event) {
        changeDropdownColor(event.target.value);

        const selectedValue = event.target.value;
        console.log('Selected value:', selectedValue);

        // Call the Flutter method to change the theme
        window._appState.onSelected(selectedValue);
    });

    window.updateDropdownValue = function (data) {
        selectElement.value = data;
        changeDropdownColor(data);
    }

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

// create function to change the color of dropdown container
function changeDropdownColor(color) {
    const dropdownContainerElement = document.getElementsByClassName('dropdown-container');
    dropdownContainerElement.item(0).style.backgroundColor = color;
}