export default function Temperature() {

    return (
        <div>
         <form method="POST" action="/celsius">
           <input type="text" name="fahrenheit" />
           <input type="submit" name="submit" />
         </form>
        </div>
    );
};
