import axios from 'axios';

export default function Temperature() {

  async function toFahrenheit(event) {
     event.preventDefault()
     let celsius = document.getElementById("celsius").value;
     console.log(celsius);
     let data = {
        celsius: celsius,
     };
       try {
        const response = await axios.post("/api/fahrenheit", data,
        {
          headers: { 'Content-Type': 'application/json', }
        }
        )
        console.log('apiCall was made.');
         console.log(response.data);
         // setlogins(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
  }

  async function toCelsius(event) {
     //console.log(event.formData);
     event.preventDefault()
     // const form = document.getElementById("temperature-input")
     // const formEntries = new FormData(form).entries();
     // console.log(formEntries)
     // console.log(event.formData);
     // console.log(event.target);

     let fahrenheit = document.getElementById("fahrenheit").value;
     console.log(fahrenheit);
     let data = {
        fahrenheit: fahrenheit,
     };
     // const formData = new FormData(event.target);
     // console.log("f=" + formData.get('fahrenheit'));
     // Now you can use formData.get('foo'), for example.

       try {
        const response = await axios.post("/api/celsius", data,
        {
          headers: { 'Content-Type': 'application/json', }
        }
        )
        console.log('apiCall was made.');
         console.log(response.data);
         // setlogins(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
  }

    return (
        <div>
           <form name="temperature-input">
           <label>fahrenheit</label>
           <input type="text" name="fahrenheit" id="fahrenheit" />
           <button onClick={toCelsius}>toCelsius</button>
           </form>

           <form name="temperature-input">
           <label>celsius</label>
           <input type="text" name="celsius" id="celsius" />
           <button onClick={toFahrenheit}>toFahrenheit</button>
           </form>
        </div>
    );
};
