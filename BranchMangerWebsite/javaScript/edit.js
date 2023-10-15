// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-app.js";
import { getFirestore, doc, getDoc, updateDoc, collection } from 'https://www.gstatic.com/firebasejs/10.4.0/firebase-firestore.js';

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyAWSHSS6v0pG5VxrmfXElArcMpjBT5o6hg",
    authDomain: "app-be149.firebaseapp.com",
    projectId: "app-be149",
    storageBucket: "app-be149.appspot.com",
    messagingSenderId: "18569998394",
    appId: "1:18569998394:web:c8efa4c8b656702c1cc503"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Access Firestore
const db = getFirestore(app);

// Specify the name of the collection you want to read from
const collectionName = "Station";

// Create a reference to the collection
const collectionRef = collection(db, collectionName);

// Retrieve a specific document by ID ("s1") must tack id from BM fk ************************
const documentPath = doc(collectionRef, "fZrKBr4GceRfpp6GPcPC");

// retrieve station name and location
getDoc(documentPath)
    .then((docSnap) => {
        if (docSnap.exists()) {
            // Access data for each document
            const statinData = docSnap.data();

            document.getElementById("StationName").value = statinData.name;
            document.getElementById("StationLocation").value = statinData.Location;

            document.getElementById("StationName").style.fontSize = "larger";
            document.getElementById("StationLocation").style.fontSize = "larger";

            document.getElementById("StationName").style.color = "#f8a71a98";
            document.getElementById("StationLocation").style.color = "#f8a71a98";

        } else {
            console.log("Document does not exist.");
        }
    })
    .catch((error) => {
        console.error("Error reading documents: ", error);
    });

// Get references to the checkboxes and radio button groups
const checkbox1 = document.getElementById('fuelType91');
const checkbox2 = document.getElementById('fuelType95');
const checkbox3 = document.getElementById('fuelTypeDiesel');
const radioGroup1 = document.getElementById('91State');
const radioGroup2 = document.getElementById('95State');
const radioGroup3 = document.getElementById('dieselState');

// Add event listeners to the checkboxes
checkbox1.addEventListener('change', toggleRadioGroup);
checkbox2.addEventListener('change', toggleRadioGroup);
checkbox3.addEventListener('change', toggleRadioGroup);

function toggleRadioGroup() {
    // Show/hide the radio button group for 91 based on its checkbox state
    if (checkbox1.checked) {
        radioGroup1.style.display = 'block';
        document.getElementById("heightBox").style.height= 700;
        document.getElementById("BKimage").height= 830;
    } else {
        radioGroup1.style.display = 'none';
    }

    // Show/hide the radio button group for 95 based on its checkbox state
    if (checkbox2.checked) {
        radioGroup2.style.display = 'block';
        document.getElementById("heightBox").style.height= 800;
        document.getElementById("BKimage").height= 900;
    } else {
        radioGroup2.style.display = 'none';
    }

    // Show/hide the radio button group for Diesel based on its checkbox state
    if (checkbox3.checked) {
        radioGroup3.style.display = 'block';
        document.getElementById("heightBox").style.height= 900;
        document.getElementById("BKimage").height= 945;
    } else {
        radioGroup3.style.display = 'none';
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("editStation");

    form.addEventListener("submit", function (event) {
        // Prevent the form from submitting in the traditional way
        event.preventDefault();

        const OpenHourInput = document.getElementById("OpenHour");
        const CloseHourInput = document.getElementById("CloseHour");
        const OpenHour = formatTimeWithAmPm(OpenHourInput.value);
        const CloseHour = formatTimeWithAmPm(CloseHourInput.value);

        const fuelTypes = ["91", "95", "Diesel"];
        let hasChecked = false; // Flag to track if at least one checkbox is checked for each fuel type

        for (const fuelType of fuelTypes) {
            const checkboxes = document.querySelectorAll(`input[name="fuelType"][value="${fuelType}"]`);
            const radioButtons = document.querySelectorAll(`input[name^="fuelState${fuelType}"]`);

            const checkedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked);

            if (checkedCheckboxes.length > 0) {
                const checkedRadioButtons = Array.from(radioButtons).filter(radio => radio.checked);
                if (checkedRadioButtons.length === 0) {
                    alert(`Please select the status for Fuel Type ${fuelType}`);
                    return; // Prevent form submission if a validation check fails
                }

                hasChecked = true;
            }
        }

        // Check if an image has been selected
        const imageUpload = document.getElementById("imageUpload");
        if (imageUpload.files.length === 0) {
            alert("Please select an image");
            return; // Prevent form submission if a validation check fails
        }

        // If all validation checks pass, you can proceed to update the Firestore document
        if (hasChecked) {
            AddStation(OpenHour, CloseHour);
        } else {
            alert("Please select at least one checkbox for each fuel type.");
        }
    });
});


// Add an event listener to the file input
document.getElementById('imageUpload').addEventListener('change', function () {
    const imageUpload = document.getElementById('imageUpload');
    const imageLabel = document.getElementById('imageLabel');

    if (imageUpload.files.length > 0) {
        const allowedExtensions = /(\.JPG)$/i;
        if (!allowedExtensions.exec(imageUpload.files[0].name)) {
            // If the selected file doesn't have a .jpg extension, clear the input and show an alert.
            imageUpload.value = '';
            imageLabel.textContent = 'Choose file in JPG format';
            alert('Please select an image in JPG format');
        } else {
            // Update the label text to the selected file's name
            imageLabel.textContent = imageUpload.files[0].name;
        }
    } else {
        // Reset the label text when no file is selected
        imageLabel.textContent = 'Choose file in JPG format';
    }
});


// Function to format time input value with AM or PM
function formatTimeWithAmPm(timeValue) {
    const parsedTime = new Date(`2000-01-01T${timeValue}`);
    const formattedTime = parsedTime.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true });
    return formattedTime;
}


// set to station doc
function AddStation(OpenHour, CloseHour) {
    const stationImage = document.getElementById("imageUpload").value;
    const fuelType = document.getElementsByName("fuelType");
    let fuelTypeArray = [];
    let fuelStatevalue = [];

    for (let i = 0; i < fuelType.length; i++) {
        if (fuelType[i].checked) {
            fuelTypeArray.push(fuelType[i].value);

            // Check if the corresponding radio button is checked
            // Use the name attribute to identify the related radio buttons
            const relatedRadioName = "fuelState" + fuelType[i].value;
            const relatedRadioButtons = document.getElementsByName(relatedRadioName);

            for (let j = 0; j < relatedRadioButtons.length; j++) {
                if (relatedRadioButtons[j].checked) {
                    fuelStatevalue.push(fuelType[i].value+ " "+ relatedRadioButtons[j].value);
                    break; // Stop checking once you find the checked radio button
                }
            }
        }
    }

    // Define a reference to the Firestore collection id change based on PM fk *******************
    const myCollection = doc(db, "Station", "fZrKBr4GceRfpp6GPcPC");

    // Update the station with more information
    updateDoc(myCollection, {
        open_hour: OpenHour,
        close_hour: CloseHour,
        image_station: stationImage,
        fuel_type: fuelTypeArray,
        fuel_status: fuelStatevalue,
    })
}
