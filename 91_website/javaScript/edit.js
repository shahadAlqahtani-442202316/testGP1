// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-app.js";
import { getFirestore, doc, getDoc, setDoc, collection } from 'https://www.gstatic.com/firebasejs/10.4.0/firebase-firestore.js';

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
const collectionName = "station";

// Create a reference to the collection
const collectionRef = collection(db, collectionName);

// Retrieve a specific document by ID ("s1")
const documentPath = doc(collectionRef, "s1");

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


// validate at least one checkbox is checked and radio choose
document.getElementById("editStation").addEventListener("submit", function (event) {
    const fuelType = document.getElementsByName("fuelType");
    let atLeastOneChecked = false;

    for (let i = 0; i < fuelType.length; i++) {
        if (fuelType[i].checked) {
            atLeastOneChecked = true;
            break; // Exit the loop if at least one checkbox is checked
        }
    }

    if (!atLeastOneChecked) {
        alert("Please select at least one Fuel type");
        event.preventDefault(); // Prevent the form from submitting
    }

    const fuelState = document.getElementsByName("fuelState");
    let atLeastOneSelected = false;

    for (let i = 0; i < fuelState.length; i++) {
        if (fuelState[i].checked) {
            atLeastOneSelected = true;
            break; // Exit the loop if at least one radio button is selected
        }
    }

    if (!atLeastOneSelected) {
        alert("Please select at least one fuel state");
        event.preventDefault(); // Prevent the form from submitting
    }
});

// set to station doc
function AddStation() {
    const OpenHour = document.getElementById("OpenHour").value;
    const CloseHour = document.getElementById("CloseHour").value;
    const fuelType = document.getElementsByName("fuelType");
    const fuelState = document.getElementsByName("fuelState");
    let fuelTypeArray = [];
    let fuelStatevalue = "";

    for (let i = 0; i < fuelType.length; i++) {
        if (fuelType[i].checked) {
            fuelTypeArray.push(fuelType[i].value);
        }
    }

    for (let i = 0; i < fuelState.length; i++) {
        if (fuelState[i].checked) {
            fuelStatevalue = fuelState[i].value;
        }
    }

    // Define a reference to the Firestore collection
    const myCollection = doc(db, "station", "s2");

    const data = {
        open_hour: OpenHour,
        close_hour: CloseHour,
        fuel_type: fuelTypeArray,
        fuel_state: fuelStatevalue,
    };

    setDoc(myCollection, data)
    .then(() => {
        console.log("Document successfully written");
    })
    .catch((error) => {
        console.error("Error writing document: ", error);
    });
      
}

// Add an event listener to the form
document.getElementById("editStation").addEventListener("submit", function (event) {
    event.preventDefault(); // Prevent the form from submitting in the traditional way
    AddStation(); // Call the function to add data to Firestore
  });






