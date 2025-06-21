
[//]: # (# Firebase Configurations)

[//]: # (await Firebase.initializeApp&#40;)

[//]: # (options: const FirebaseOptions&#40;)

[//]: # (apiKey: "AIzaSyC5xGrykr0gj2CtlRMOWtnl_I15BMvokX8",)

[//]: # (authDomain: "webapp-a487f.firebaseapp.com",)

[//]: # (projectId: "webapp-a487f",)

[//]: # (storageBucket: "webapp-a487f.firebasestorage.app",)

[//]: # (messagingSenderId: "666802123103",)

[//]: # (appId: "1:666802123103:web:d4303a2da4482b1955c6ea",)

[//]: # (measurementId: "G-KTVCNMY11Z",)

[//]: # (&#41;,)

[//]: # (&#41;;)
<script type="module">
  // Import the functions you need from the SDKs you need
  import { initializeApp } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-app.js";
  import { getAnalytics } from "https://www.gstatic.com/firebasejs/11.9.1/firebase-analytics.js";
  // TODO: Add SDKs for Firebase products that you want to use
  // https://firebase.google.com/docs/web/setup#available-libraries

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  const firebaseConfig = {
    apiKey: "AIzaSyASRGn1lBDm9sIhvLLZtmEXOvTwSHa_5zo",
    authDomain: "parivarmilap.firebaseapp.com",
    projectId: "parivarmilap",
    storageBucket: "parivarmilap.firebasestorage.app",
    messagingSenderId: "630594473617",
    appId: "1:630594473617:web:dc30a4a983a63c6df57930",
    measurementId: "G-ELNMMPQPV2"
  };

  // Initialize Firebase
  const app = initializeApp(firebaseConfig);
  const analytics = getAnalytics(app);
</script>