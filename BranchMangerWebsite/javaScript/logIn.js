import { initializeApp } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-app.js";
import { getFirestore, collection, getDocs, addDoc, updateDoc, doc } from 'https://www.gstatic.com/firebasejs/10.4.0/firebase-firestore.js';

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
const collectionName = "Station_Requests";

async function checkEmailExists(email) {
    const collectionRef = collection(db, collectionName);
    let loged = false; 
    const querySnapshot = await getDocs(collectionRef);

    querySnapshot.forEach(async (docs) => {
        const data = docs.data();
        if (data.email === email && data.accepted === true) {
            loged = true;
            const firtsName = data.first_name;
            const lastName = data.last_name;
            const iemail = data.email;
            const stationName = data.station_name;
            const stationLocation = data.station_location;

            // Add a new "Branch_Manager" document
            const branchManagerRef = await addDoc(collection(db, "Branch_Manager"), {
                first_name: firtsName,
                last_name: lastName,
                email: iemail,
            });

            // Get the ID of the newly created "Branch_Manager" document
            const branchManagerId = branchManagerRef.id;

            // add to station collection
            const stationRef = await addDoc(collection(db, "Station"), {
                name: stationName,
                Location: stationLocation,
                branch_manager_id: branchManagerId, // Store the foreign key
            });

            // Get the ID of the newly created "Branch_Manager" document
            const stationId = stationRef.id;

            // Define a reference to a specific document within the "Branch_Manager" collection
            const branchManagerDocRef = doc(db, "Branch_Manager", branchManagerId);

            // Update the document with the new field
            updateDoc(branchManagerDocRef, {
                station_id: stationId,
            })
        }
    });

    // if email doesn't exist or accepted = false
    if (loged === false) {
        alert("Please register first");
    }
}

document.getElementById("registrationForm").addEventListener("submit", async function (event) { //حطي ايدي الفورم
    event.preventDefault();

    const email = document.getElementById("Email").value;//حطي ايدي الانبوت حق الايميل
    await checkEmailExists(email);
});